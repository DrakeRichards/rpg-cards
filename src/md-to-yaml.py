import markdown
import markdown_to_json
import yaml
import re
import frontmatter as fm
from pathlib import Path


class Character:
    name: str
    overview: str
    looks: str
    voice: str
    quirk: str
    likes: str
    dislikes: str
    goals: str
    frustration: str
    relationships: list[str]
    groups: list[str]


def parse_dataview_fields(text: str) -> (dict[str, str | list[str]] | None):
    """
    Parses inline Dataview fields to a dict.

    `[[Wikilinks]]` will lose their square brackets.

    Should detect:

    - `(key:: value)`
    - `[key:: value]`
    - `- key:: value`
    """
    PATTERN = r"(?:[(\[]|^- )(?P<dvKey>[\w ]+)::\s(?:\[{0,2})(?P<dvValue>[\w \]-]*?)(?:[)\]]|$|\n)"
    pattern = re.compile(PATTERN)
    matches = pattern.finditer(text)
    dataview_fields: dict[str, str | list[str]] = {}
    if not matches:
        return
    for match in matches:
        dvKey = match.group("dvKey")
        dvValue = match.group("dvValue")
        # If this key is already present, change the existing value to a list and append the new value.
        if dvKey in dataview_fields:
            if not isinstance(dataview_fields[dvKey], list):
                dataview_fields[dvKey] = [  # type: ignore
                    dataview_fields[dvKey]]
            dataview_fields[dvKey] = [*dataview_fields[dvKey], dvValue]
        else:
            dataview_fields[dvKey] = dvValue
    return dataview_fields


INPUT_FILE_PATH = "./data/Azel Steelhands.md"

# Text to string
text_full = Path(INPUT_FILE_PATH).read_text()
frontmatter = fm.parse(text_full)
text_markdown = frontmatter[1]
data = markdown_to_json.dictify(text_markdown)
dataview_fields = parse_dataview_fields(text_markdown)

print(data)
