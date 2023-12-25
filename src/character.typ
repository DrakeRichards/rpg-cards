#set page(width: 7in, height: 5in, margin: 15pt)

#let data = yaml("../out/yaml/Azel Steelhands.yaml")

#let bodytext = [
  = #data.name

  #emph(data.genderRaceJob)

  #data.description

  == Description

  #data.looks

  *Location:* #data.location

  *Group:* #data.groupName
]

#let portrait = align(
  alignment.center + alignment.horizon,
  figure(image("../media/" + data.image)),
)

// Build the document.
#grid(columns: (auto, 45%), rows: (70%), gutter: 5pt, bodytext, portrait)

#line(length: 100%, stroke: gray)

== _Notes_

