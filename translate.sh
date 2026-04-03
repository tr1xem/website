#!/bin/bash

API_KEY=$GEMINI_KEY
LANG_PREFIX="hi"
TARGET_PATHS=(
    "content/blog/*"
    "content/nanolog/"
    "content/tutorials/*"
    "content/*.md"
)
MODEL="gemini-3.1-flash-lite-preview"



JQ_BIN=$(command -v jq || echo "./jq")

if [ -z "$API_KEY" ]; then
    echo "Error: GEMINI_KEY is not set."
    exit 1
fi

if [ ! -f "$JQ_BIN" ] && ! command -v jq &> /dev/null; then
    echo "Error: jq not found. Make sure to download it in your build command."
    exit 1
fi

for path_entry in "${TARGET_PATHS[@]}"; do
    for item in $path_entry; do
        if [ -d "$item" ]; then
            files=$(find "$item" -maxdepth 1 -name "*.md")
        elif [ -f "$item" ] && [[ "$item" == *.md ]]; then
            files="$item"
        else
            continue
        fi

        for file in $files; do

            if [[ "$file" == *."$LANG_PREFIX".md ]]; then continue; fi

            target_file="${file%.md}.$LANG_PREFIX.md"
            if [ -f "$target_file" ]; then
                echo "Skipping: $target_file already exists."
                continue
            fi

            echo "Processing: $file -> $target_file"

            content=$(cat "$file")


            full_prompt="Translate the following text to Hindi.
            IMPORTANT:
            1. This is a Zola markdown file.
            2. DO NOT translate anything inside the frontmatter (between +++ and +++).
            3. DO NOT translate Zola shortcodes like {{ ... }} or links [ ... ]( ... ).
            4. Keep all formatting exactly as it is.
            5. Return ONLY the translated content, no extra text or explanations.

            CONTENT:
            $content"


            payload=$($JQ_BIN -n --arg p "$full_prompt" '{contents: [{parts: [{text: $p}]}]}')

            response=$(curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/$MODEL:generateContent?key=$API_KEY" \
                -H 'Content-Type: application/json' \
                -d "$payload")


            translated_text=$(echo "$response" | $JQ_BIN -r '.candidates[0].content.parts[0].text' 2>/dev/null | sed 's/^```markdown//; s/```$//' | sed 's/^```//; s/```$//')

            if [ "$translated_text" != "null" ] && [ -n "$translated_text" ]; then

                echo -e "$translated_text" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' > "$target_file"
                echo "Successfully saved translation."
            else
                echo "Error: Could not translate $file."
                echo "Full API Response for debugging: $response"
            fi
        done
    done
done
