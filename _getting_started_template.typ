#set text(font: "Calibri", size: 11pt)

#let primary-color = rgb("#ba0225")
#let secondary-color = rgb("#475160")

// Style links with secondary color
#show link: it => {
  text(fill: secondary-color, weight: "bold", it)
}

// Create colored left margin background with primary and secondary stripes
#set page(
  margin: (top: 2cm, bottom: 2.5cm, left: 3.5cm, right: 2cm),
  background: place(
    top + left,
    box(
      width: 1.8cm,
      height: 100%,
      fill: primary-color
    )
  ) + place(
    top + left,
    dx: 1.2cm,
    box(
      width: 0.6cm,
      height: 100%,
      fill: secondary-color
    )
  )
)

// Title page - centered
#align(center)[
  #v(3cm)
  
  #block(width: 90%, fill: primary-color, inset: 30pt)[
    #text(size: 24pt, weight: "bold", fill: white)[CREDO Learning: Getting Started]
  ]
  
  #v(1em)
  
  #block(width: 90%, fill: secondary-color, inset: 25pt)[
    #text(size: 14pt, fill: white)[Introduction to Statistics for Clinical Research]
  ]
  
  #v(3cm)
  
  #text(size: 12pt)[
    ISARIC – International Severe Acute Respiratory and emerging Infection Consortium
  ]
]

#v(1fr)

#pagebreak()

#set align(left)

$body
