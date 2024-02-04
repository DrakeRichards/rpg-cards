#set page(
  width: 7in,
  height: 5in
)

#let data = yaml("../test/item.yaml")

= #data.name

== #data.type

