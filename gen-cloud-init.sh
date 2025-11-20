#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <input-yaml> <output-yaml>"
    exit 1
fi

INPUT_YAML="$1"
OUTPUT_YAML="$2"

PLACEHOLDER_REGEX='%%([^%]+)%%'

# Create or clear output file
: > "$OUTPUT_YAML"

while IFS= read -r line; do
    # Check for placeholder
    if [[ "$line" =~ $PLACEHOLDER_REGEX ]]; then
        FILE_PATH="${BASH_REMATCH[1]}"

        if [[ ! -f "$FILE_PATH" ]]; then
            echo "Error: file not found: $FILE_PATH" >&2
            exit 1
        fi

        # Encode file
        B64_CONTENT=$(base64 -i "$FILE_PATH")

        # Escape for sed
        SAFE_B64=$(printf "%s" "$B64_CONTENT" | sed -e 's/[\/&]/\\&/g')

        # Replace placeholder(s)
        line=$(echo "$line" | sed "s|%%$FILE_PATH%%|$SAFE_B64|g")
    fi

    echo "$line" >> "$OUTPUT_YAML"
done < "$INPUT_YAML"
