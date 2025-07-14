import json
import numpy as np

# Paths
ground_truth_path = "gas_report_all_contracts_ground_truth.json"
generated_json_paths = [
    "comparison_chatgpt.json",
    "comparison_codellama.json",
    "comparison_gemini.json",
    "comparison_deepseek.json",
    "comparison_chatgpt_rag.json",
    "comparison_codellama_rag.json",
    "comparison_gemini_rag.json",
    "comparison_deepseek_rag.json",
]

# ==========================
# Ground Truth Data
# ==========================
print("\n============================")
print("📂 Processing Ground Truth")
print("============================")

with open(ground_truth_path) as f:
    data = json.load(f)

all_gas_values = []

# Iterate over contracts
for contract in data:
    function_gas = contract.get("function_gas", {})

    for func_info in function_gas.values():
        samples = func_info.get("samples", [])
        # Collect successful gas values, ignoring None
        gas_values = [s["gas"] for s in samples if s["gas"] is not None]
        if gas_values:
            all_gas_values.extend(gas_values)

# Overall aggregated metrics
if all_gas_values:
    filtered_all_gas_values = [v for v in all_gas_values if v is not None]
    all_gas_array = np.array(filtered_all_gas_values)
    print("\n📊 Overall Ground Truth Gas Statistics")
    print(f"  Min gas: {all_gas_array.min()}")
    print(f"  Max gas: {all_gas_array.max()}")
    print(f"  Mean gas: {all_gas_array.mean():.2f}")
    print(f"  Std gas: {all_gas_array.std():.2f}")
else:
    print("No gas data found in ground truth.")

# ==========================
# Generated Comparison Files
# ==========================
for path in generated_json_paths:
    print("\n============================")
    print(f"📂 Processing {path}")
    print("============================")

    with open(path) as f:
        comparison_data = json.load(f)

    comparison_gas_values = []
    high_consistency_gas = []

    for func_id, info in comparison_data.items():
        total_gas = info.get("total_gas", 0)
        total_samples = info.get("total_samples", 0)
        identical_outputs = info.get("identical_outputs", 0)

        if total_gas > 0 and total_samples > 0:
            mean_gas = total_gas / total_samples
            comparison_gas_values.append(mean_gas)

            # Check functional consistency threshold
            if identical_outputs >= 0.75 * total_samples:
              #  print(f"✅ {func_id}: High consistency ({identical_outputs}/{total_samples} identical outputs)")
                high_consistency_gas.append(mean_gas)

    if comparison_gas_values:
        comparison_array = np.array(comparison_gas_values)
        print("\n📊 Overall Statistics for", path)
        print(f"  Count: {len(comparison_array)}")
        print(f"  Min gas: {comparison_array.min()}")
        print(f"  Max gas: {comparison_array.max()}")
        print(f"  Mean gas: {comparison_array.mean():.2f}")

        if high_consistency_gas:
            high_array = np.array(high_consistency_gas)
            print(f"  High consistency functions: {len(high_array)}")
            print(f"  Mean gas (high consistency): {high_array.mean():.2f}")
        else:
            print("  No functions with high consistency.")
    else:
        print("No non-zero gas data found in this file.")
