#!/bin/sh

# Generate a character card for a given character.
# Usage: ./generate-character-card.sh <character-name>

# Check if the character name is provided.
if [ -z "$1" ]; then
  echo "Please provide a character name."
  exit 1
fi

# Check if the character exists.
if [ ! -f "in/markdown/$1.md" ]; then
  echo "Character not found."
  exit 1
fi

# Pass the character's markdown file to ./src/python/main.py and output it to ./src/python/out
python ./src/python/main.py "in/markdown/$1.md" "./src/python/out"

# Copy the character's yaml file to ./src/typst/in/character.yaml and overwrite the file there, if present.
cp "./src/python/out/$1.yaml" "./src/typst/in/character.yaml"

# Pull the name of the character's image file from their yaml file.
image=$(grep "image:" "src/python/out/$1.yaml" | cut -d ' ' -f 2)

# Copy the character's image to ./src/typst/in/character.png and overwrite the file there, if present.
cp "in/images/$image" "src/typst/in/character.png"

# Run the character card generation script.
typst compile src/typst/character.typ "out/$1.pdf"