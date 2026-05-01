#!/bin/bash
# Hitokoto Data Merge Script (Cross-platform)
# Merge all JSON files into hitokoto-data.js

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INPUT_DIR="$SCRIPT_DIR/sentences"
OUTPUT_DIR="$SCRIPT_DIR/../themes/minimal-chinese/static/js"
OUTPUT_FILE="$OUTPUT_DIR/hitokoto-data.js"

echo "========================================"
echo "  Hitokoto Data Merge Script"
echo "========================================"
echo ""

if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Input directory not found: $INPUT_DIR"
    exit 1
fi

# Count JSON files
JSON_FILES=($(find "$INPUT_DIR" -name "*.json" -type f | sort))
FILE_COUNT=${#JSON_FILES[@]}

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "Error: No JSON files found in: $INPUT_DIR"
    exit 1
fi

echo "Found $FILE_COUNT JSON files"
echo ""

# Check for Python availability
if ! command -v python3 &> /dev/null; then
    echo "Error: Python3 not found. Python is required for proper JSON handling."
    exit 1
fi

# Use Python to merge all files
python3 << 'PYTHON_SCRIPT'
import json
import os
import sys
from datetime import datetime
from pathlib import Path

def main():
    script_dir = Path(__file__).parent.resolve() if '__file__' in locals() else Path.cwd()
    # Try to get parent dir (since we execute this script from the right location)
    input_dir = Path.cwd() / "sentences"
    output_dir = Path.cwd() / ".." / "themes" / "minimal-chinese" / "static" / "js"
    output_file = output_dir / "hitokoto-data.js"

    print("=" * 40)
    print("  Hitokoto Data Merge Script")
    print("=" * 40)
    print()

    if not input_dir.exists():
        print(f"Error: Input directory not found: {input_dir}")
        sys.exit(1)

    json_files = sorted(input_dir.glob("*.json"))

    if not json_files:
        print(f"Error: No JSON files found in: {input_dir}")
        sys.exit(1)

    print(f"Found {len(json_files)} JSON files")
    print()

    total_count = 0
    all_sentences = []

    for json_file in json_files:
        print(f"Reading: {json_file.name}...", end=" ", flush=True)

        try:
            with open(json_file, "r", encoding="utf-8-sig") as f:
                data = json.load(f)

            count = len(data)
            total_count += count

            for item in data:
                sentence = {
                    "text": item.get("hitokoto") or "",
                    "author": item.get("from_who") or "",
                    "type": item.get("type") or "f",
                    "from": item.get("from") or ""
                }
                all_sentences.append(sentence)

            print(f"{count} items")

        except Exception as e:
            print(f"Failed - {e}")

    print()
    print("=" * 40)
    print(f"  Merging {total_count} sentences...")
    print("=" * 40)
    print()

    output_dir.mkdir(parents=True, exist_ok=True)

    current_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    with open(output_file, "w", encoding="utf-8") as f:
        f.write("// Hitokoto Local Database\n")
        f.write("// Source: https://github.com/hitokoto-osc/sentences-bundle\n")
        f.write(f"// Generated: {current_date}\n")
        f.write(f"// Total: {total_count} sentences\n")
        f.write("// AGPL License - Must follow open source license terms\n\n")
        f.write("const hitokotoData = ")
        json.dump(all_sentences, f, ensure_ascii=False, separators=(',', ':'))
        f.write(";\n\n")
        f.write("function getRandomHitokoto() {\n")
        f.write("  const index = Math.floor(Math.random() * hitokotoData.length);\n")
        f.write("  return hitokotoData[index];\n")
        f.write("}\n\n")
        f.write("window.hitokotoData = hitokotoData;\n")
        f.write("window.getRandomHitokoto = getRandomHitokoto;\n")

    print("=" * 40)
    print("  Success!")
    print(f"  Total: {total_count} sentences")
    print(f"  Output: {output_file}")
    print("=" * 40)
    print()
    print("Please rebuild the website to apply new data")

if __name__ == "__main__":
    main()
PYTHON_SCRIPT

exit $?
