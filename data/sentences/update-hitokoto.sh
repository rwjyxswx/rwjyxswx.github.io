#!/bin/bash
# Hitokoto Database Update Script (Cross-platform)
# Download and update hitokoto-osc/sentences-bundle database

# Configuration
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_OWNER="hitokoto-osc"
REPO_NAME="sentences-bundle"
BRANCH="master"
RAW_BASE_URL="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${BRANCH}/sentences"
API_BASE_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/sentences"
OUTPUT_DIR="$SCRIPT_DIR/sentences"

# Type mapping
declare -A TYPE_MAP=(
    ["a"]="animation"
    ["b"]="manga"
    ["c"]="game"
    ["d"]="literature"
    ["e"]="original"
    ["f"]="f"
    ["g"]="other"
    ["h"]="film"
    ["i"]="poetry"
    ["j"]="music"
    ["k"]="philosophy"
    ["l"]="joke"
)

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "========================================"
echo "  Hitokoto Database Update Script"
echo "========================================"
echo ""

echo "Fetching file list from GitHub..."

# Get remote file list
RESPONSE=$(curl -s "$API_BASE_URL")

if [ $? -ne 0 ]; then
    echo "Error: Cannot fetch file list"
    echo "Possible reasons:"
    echo "  1. Network connection issue"
    echo "  2. GitHub API rate limit"
    echo "  3. Repository temporarily unavailable"
    exit 1
fi

# Parse JSON files using grep and sed (simple parser)
JSON_FILES=$(echo "$RESPONSE" | grep -o '"name": "[^"]*\.json"' | sed 's/"name": "//g; s/"//g')

if [ -z "$JSON_FILES" ]; then
    echo "Error: No JSON files found"
    exit 1
fi

FILE_COUNT=$(echo "$JSON_FILES" | wc -l)
echo "Found $FILE_COUNT data files"
echo ""

TOTAL_COUNT=0

for FILE_NAME in $JSON_FILES; do
    TYPE_CODE="${FILE_NAME%.json}"
    TYPE_NAME="${TYPE_MAP[$TYPE_CODE]:-$TYPE_CODE}"

    echo -n "Downloading: $FILE_NAME ($TYPE_NAME)..."

    FILE_URL="$RAW_BASE_URL/$FILE_NAME"
    OUTPUT_PATH="$OUTPUT_DIR/$FILE_NAME"

    if curl -s -o "$OUTPUT_PATH" "$FILE_URL"; then
        COUNT=$(cat "$OUTPUT_PATH" | grep -o '"hitokoto"' | wc -l)
        TOTAL_COUNT=$((TOTAL_COUNT + COUNT))
        echo " Done ($COUNT items)"
    else
        echo " Failed"
    fi
done

echo ""
echo "========================================"
echo "  Download Complete!"
echo "  Total: $TOTAL_COUNT sentences"
echo "  Location: $OUTPUT_DIR"
echo "========================================"
echo ""
echo "Running merge-data.sh to generate hitokoto-data.js..."

# Call merge script
"$SCRIPT_DIR/merge-data.sh"
