


API_KEY=$GEMINI_KEY
LANG_PREFIX="hi"
TARGET_PATHS=(
    "content/blog/*"
    "content/nanolog/"
    "content/tutorials/*"
    "content/"
)
MODEL="gemini-3.1-flash-lite-preview"


if [ -z "$API_KEY" ]; then
    echo "Error: GEMINI_KEY is not set."
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


            full_prompt="Translate this in hindi keep formating and link and stuff (ex: shortcodes {{ somthings}} its written in zola so you \
                figure out what to not translate) as it is just translate the TEXT Return only translated stuff and no explations: \n\n$content"



            payload=$(jq -n --arg p "$full_prompt" '{contents: [{parts: [{text: $p}]}]}')


            response=$(curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/$MODEL:generateContent?key=$API_KEY" \
                -H 'Content-Type: application/json' \
                -d "$payload")


            translated_text=$(echo "$response" | jq -r '.candidates[0].content.parts[0].text' 2>/dev/null | sed 's/^```markdown//; s/```$//' | sed 's/^```//; s/```$//')

            if [ "$translated_text" != "null" ] && [ -n "$translated_text" ]; then
                echo "$translated_text" > "$target_file"
                echo "Successfully saved translation."
            else
                echo "Error: Could not translate $file."
                echo "API Response: $response"
            fi
        done
    done
done
