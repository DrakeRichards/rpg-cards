from dataclasses import dataclass, asdict
from pathlib import Path

import yaml

import obsidian_tools


@dataclass
class Character:
    @dataclass
    class PhysicalInfo:
        gender: str = ''
        race: str = ''
        job: str = ''

    @dataclass
    class Description:
        overview: str = ''
        looks: str = ''
        voice: str = ''

    @dataclass
    class Personality:
        quirk: str = ''
        likes: str = ''
        dislikes: str = ''

    @dataclass
    class Hooks:
        goals: str = ''
        frustration: str = ''

    name: str = ''
    physicalInfo: PhysicalInfo | None = None
    description: Description | None = None
    personality: Personality | None = None
    hooks: Hooks | None = None


def markdown_to_character_yaml(filepath: str) -> str:
    # File contents to string
    text = Path(filepath).read_text()

    # Parse string to object
    page = obsidian_tools.Page(text)

    # The name of the character should be H1, which is the key of the top-level element.
    name: str = list(page.content.keys())[0]

    # Check whether H1 has any subheaders.
    if isinstance(page.content[name], str):
        raise KeyError('H1 has no subheadings.')

    # Put the page's contents into a separate dict for ease of reference.
    content: dict[str, dict] = page.content[name]  # type: ignore

    # I want the resulting object's keys to be lowercase.
    description_lower_keys = {
        k.lower(): v for k, v in content['Description'].items()}
    personality_lower_keys = {
        k.lower(): v for k, v in content['Personality'].items()}
    hooks_lower_keys = {
        k.lower(): v for k, v in content['Hooks'].items()}

    # Make it a Character class
    char = Character(
        name=name,
        physicalInfo=Character.PhysicalInfo(
            gender=page.dataview_fields['gender'][0],
            race=page.dataview_fields['race'][0],
            job=page.dataview_fields['class'][0],
        ),
        description=Character.Description(**description_lower_keys),
        personality=Character.Personality(**personality_lower_keys),
        hooks=Character.Hooks(**hooks_lower_keys)
    )

    # Export to a YAML file.
    outfile: str = f"./out/yaml/{char.name}.yaml"
    with open(outfile, mode="wt", encoding="utf-8") as file:
        yaml.dump(asdict(char), file)

    return outfile