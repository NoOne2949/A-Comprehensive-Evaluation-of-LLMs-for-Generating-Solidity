from dotenv import load_dotenv

load_dotenv()
import subprocess
import time
from solcx import (
    compile_files,
    install_solc,
    get_installed_solc_versions,
    set_solc_version,
    get_compilable_solc_versions
)
import pandas as pd
import os
import re
from packaging import version

complete_function = []


# Extract the Solidity version requirement from pragma
def extract_solidity_version(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            match = re.search(r'pragma\s+solidity\s+([^;]+);', line)
            if match:
                return match.group(1).strip()
    return None


# Resolve the most compatible version from the pragma version expression
def resolve_version_range(version_expr):
    available_versions = sorted(get_compilable_solc_versions())
    expr = version_expr.replace(' ', '')
    constraints = re.findall(r'[\^<>=]*\d+\.\d+(?:\.\d+)?', expr)

    def is_compatible(ver):
        for constraint in constraints:
            if constraint.startswith('^'):
                base = version.parse(constraint[1:])
                upper = version.parse(f"{base.major + 1}.0.0")
                if not (base <= ver < upper):
                    return False
            elif constraint.startswith(">="):
                if ver < version.parse(constraint[2:]):
                    return False
            elif constraint.startswith("<="):
                if ver > version.parse(constraint[2:]):
                    return False
            elif constraint.startswith(">"):
                if ver <= version.parse(constraint[1:]):
                    return False
            elif constraint.startswith("<"):
                if ver >= version.parse(constraint[1:]):
                    return False
            else:
                if ver != version.parse(constraint):
                    return False
        return True

    compatible_versions = [v for v in available_versions if is_compatible(v)]
    if not compatible_versions:
        return None

    return str(compatible_versions[-1])


# Compile a Solidity file with the correct compiler version
def compile_target(path, filename, version):
    try:
        if version not in get_installed_solc_versions():
            install_solc(version)
        set_solc_version(version)

        compiled_contracts = compile_files(
            [path],
            output_values=["abi", "bin"],
            allow_paths=[".", "./node_modules"],
            base_path="."
        )

        for contract_name, contract_data in compiled_contracts.items():
            complete_function.append({
                "full_name": contract_name,
                "filename": filename,
                "contract": filename,
                "abi": contract_data["abi"],
                "bytecode": contract_data["bin"]
            })

    except Exception as e:
        print(f"Compilation failed for {filename} with version {version}:\n{str(e)}\n")


def start_ganache(port=8545):
    try:
        command = ['ganache', '--port', str(port)]
        ganache_process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        time.sleep(5)
        print(f"Ganache started on port {port}.")
        return ganache_process
    except Exception as e:
        print(f"Error starting Ganache: {e}")
        return None


# Main execution
print("Current working directory:", os.getcwd())
current_directory = os.getcwd()
sol_files = [file for file in os.listdir(current_directory) if file.endswith('.sol')]
print(f"Found {len(sol_files)} Solidity files")

for c in sol_files:

    file_path = os.path.join(current_directory, c)
    version_expr = extract_solidity_version(file_path)
    if version_expr:
        resolved_version = resolve_version_range(version_expr)
        if resolved_version:
            print(f"Compiling {c} with Solidity {resolved_version} (pragma: {version_expr})")
            compile_target(file_path, c[:-4], resolved_version)
        else:
            print(f"No compatible version found for {c} (pragma: {version_expr})")
    else:
        print(f"No Solidity version found in {c}, skipping...")

# Save compiled filenames
df = pd.DataFrame(complete_function)
output_path = "compiled_gt_contracts.csv"
df.to_csv(output_path, index=False)
print(f"Saved results to {output_path}")

gt_path = "../../data/sample_of_interest.csv"
ground_truth = pd.read_csv(gt_path)
ground_truth["ID"] = ground_truth["ID"].astype(str)
ground_truth["IsCorrect"] = False
matched_ids = set()

for index, row in df.iterrows():
    contract = str(row["contract"])

    if contract and contract[0].isdigit():
        print(f"[{index}] Starts with a number: {contract}")
        contract_id = str(contract.split(".")[0])

        matched_ids.add(contract_id)

        ground_truth.loc[ground_truth["ID"] == contract_id, "IsCorrect"] = True

ground_truth.to_csv(gt_path, index=False)
