import character

INPUT_FILE_PATH = './test/Azel Steelhands.md'

if __name__ == "main":
    outfile = character.markdown_to_character_yaml(INPUT_FILE_PATH)
