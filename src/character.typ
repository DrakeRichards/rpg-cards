// Data imports
#let data = yaml("../data/Nelra Treewhisper.yaml")

// Global settings
#set page(
  width: 7in, 
  height: 5in, 
  margin: 15pt,
  columns: 2,
  fill: white
)

// Element settings
#show heading: it => {
  smallcaps(it)
}

// Level 1 headings have a highlight.
#show heading.where(
  level: 1
): it => [
  #set text(
    size: 18pt,
    fill: white
  )
  #box(
    width: 100%,
    inset: 5pt,
    fill: color.maroon,
    it
  )
]

// Level 2 headings are centered with a line beneath.
#show heading.where(
  level: 2
): it => [
  #set align(center)
  #it
  // Move the line up a bit.
  #pad(
    top: -8pt,
    line(
      length: 100%
    )
  )
]

// Main body text
#let bodytext = [
  = #data.name

  #emph(
    [#data.physicalInfo.gender
    #data.physicalInfo.race
    #data.physicalInfo.job]
  )

  #if data.location != none {
    [
      *Location:* #data.location
    ]
  }

  == Description

  #data.description.overview

  #if data.groupName != "" {
    [
      == Group Membership

      *Group Name:* #data.groupName

      *Group Title:* #data.groupTitle

      *Group Rank:* #data.groupRank
    ]
  }
]

// Main image
#let portrait = [
  #figure(
    image(
      "../test/attachments/" + data.image,
      width: 100%
    ),
  )
]

// Build the document.
//#grid(columns: (auto, 45%), rows: (70%), gutter: 5pt, bodytext, portrait)

//#line(length: 100%, stroke: gray)
//== _Notes_

#bodytext
#colbreak()
#portrait
#emph(data.description.looks)