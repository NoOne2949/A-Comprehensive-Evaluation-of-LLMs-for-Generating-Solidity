import json
import os

# List of JSON paths (add or remove as needed)
json_files = [
    "comparison_chatgpt.json",
    "comparison_codellama_rag.json",
    "comparison_gemini_rag.json",
    "comparison_gemini.json",
    "comparison_deepseek.json",
    "comparison_deepseek_rag.json",
    "comparison_codellama.json",
    "comparison_chatgpt_rag.json"
]

# Ensure the output folder exists
output_dir = "correctness_summaries"
os.makedirs(output_dir, exist_ok=True)

for json_path in json_files:
    if not os.path.exists(json_path):
        print(f"[⚠️] File not found: {json_path}, skipping.\n")
        continue

    print(f"\n📂 Processing file: {json_path}")

    with open(json_path) as f:
        data = json.load(f)

    total_functions = 0
    total_correct_outputs = 0
    total_incorrect_outputs = 0
    contracts_summary = []

    for contract_id, results in data.items():
        ident = results["identical_outputs"]
        diff = results["different_outputs"]
        total = results["total_samples"]

        total_functions += 1
        total_correct_outputs += ident
        total_incorrect_outputs += diff

        correctness_rate = ident / total if total > 0 else 0

        contracts_summary.append({
            "contract_id": contract_id,
            "identical_outputs": ident,
            "different_outputs": diff,
            "total_samples": total,
            "correctness_rate": correctness_rate
        })

    # Compute overall metrics
    total_samples = total_correct_outputs + total_incorrect_outputs
    overall_accuracy = total_correct_outputs / total_samples if total_samples > 0 else 0

    # Print detailed results
    #print("\n📊 Correctness per contract:")
    # for entry in contracts_summary:
    #     print(f"- Contract ID {entry['contract_id']}:")
    #     print(f"   Correct outputs: {entry['identical_outputs']}")
    #     print(f"   Incorrect outputs: {entry['different_outputs']}")
    #     print(f"   Accuracy: {entry['correctness_rate']*100:.2f}%")

    print("\n✅ Overall Correctness Summary:")
    print(f"   Total contracts evaluated: {total_functions}")
    print(f"   Total samples: {total_samples}")
    print(f"   Total correct outputs: {total_correct_outputs}")
    print(f"   Total incorrect outputs: {total_incorrect_outputs}")
    print(f"   Overall accuracy: {overall_accuracy*100:.2f}%")

    # Prepare the summary dictionary
    summary_output = {
        "total_functions": total_functions,
        "total_samples": total_samples,
        "total_correct_outputs": total_correct_outputs,
        "total_incorrect_outputs": total_incorrect_outputs,
        "overall_accuracy": overall_accuracy,
        "per_contract": contracts_summary
    }

    # Write summary to file
    basename = os.path.basename(json_path).replace(".json", "")
    output_path = os.path.join(output_dir, f"{basename}_summary.json")

    with open(output_path, "w") as out_f:
        json.dump(summary_output, out_f, indent=2)

    print(f"\n💾 Saved summary to {output_path}")
