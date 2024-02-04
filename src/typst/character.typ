// Data imports
#let data = yaml("in/character.yaml")

// Global settings
#set page(width: 4in, height: 6in, margin: 15pt, fill: white)
#set text(size: 9pt)

// Element settings
#show heading: it => {
  smallcaps(it)
}

// Level 1 headings have a highlight.
#show heading.where(level: 1): it => [
  #set text(size: 1.5em, fill: white)
  #box(width: 100%, inset: 5pt, fill: color.maroon, it)
]

// Level 2 headings are centered with a line beneath.
#show heading.where(level: 2): it => [
  #set align(center)
  #set text(size: 1.2em)
  #it
  // Move the line up a bit.
  #pad(top: -8pt, line(length: 100%))
]

// Blocks
#let headerText = [= #data.name]

#let genderRaceJob = [
  #emph([
    #data.physicalInfo.gender
    #data.physicalInfo.race
    #data.physicalInfo.job
  ])
]

#let groupInfo = if data.groupName != "" {
  [
    #grid(
      columns: (auto, 40%),
      rows: (auto),
      column-gutter: 5pt,
      [
        #align(alignment.left, [*Group Name:* #data.groupName])
      ],
      // Display "n/a" if there is no group title.
      [
        #align(alignment.right, [
          *Group Title:*
          #if data.groupTitle == "" {
            [n/a]
          } else { [#data.groupTitle] }
           
        ])
      ],
    )
  ]
} else { [] }

#let location = if data.location != none {
  [*Location:* #data.location]
} else { [] }

#let description = [
  #data.description.overview
]

#let portrait = image("in/character.png", width: 75%)

// Alternate header with an image background.
// Not implemented until the Stroke function is released.
#let headerImage = box(width: 100%, height: 15%)[
  #place(
    top,
    float: false,
  )[#image("images/Forest Banner.png", width: 100%, fit: "cover")]
  #align(
    alignment.center + alignment.horizon,
  )[#text(fill: white, size: 2.0em, weight: "black")[#data.name]]
]

// Build the document.
//#headerImage
#headerText
#genderRaceJob
#align(alignment.center)[#portrait]
#line(length: 100%)
#description
#align(alignment.bottom)[#groupInfo]
#align(alignment.bottom + alignment.center)[#location]
