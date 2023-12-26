import character

INPUT_FILE_PATH = './test/Nelra Treewhisper.md'

if __name__ == "__main__":
    outfile = character.markdown_to_character_yaml(INPUT_FILE_PATH)
