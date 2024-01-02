import character
from yaml import dump
from pathlib import Path
from dataclasses import asdict

INPUT_FILE_PATH = './test/Nelra Treewhisper.md'

if __name__ == "__main__":
    text = Path(INPUT_FILE_PATH).read_text()

    char: dict[str, str] = character.parse(text)

    # Export to a YAML file.
    outfile: str = f"./data/{char['name']}.yaml"
    with open(outfile, mode="wt", encoding="utf-8") as file:
        dump(char, file)
