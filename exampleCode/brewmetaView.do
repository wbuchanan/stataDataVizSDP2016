// What properties do each of the palettes have with regards to accessibility?

// When available, the -brewmeta- command can be used to look up the metadata 
// properties for each of the colors.  The colors argument should be the maximum
// number of colors in the palette the colorid value will return the properties 
// for a given color within the palette with colors() number of colors
brewmeta "accent", colorid(5) colors(8)
brewmeta "blues", colorid(8) colors(9)
brewmeta "oranges", colorid(6) colors(8)
brewmeta "category10", colorid(10) colors(10)
brewmeta "set1", colorid(9) colors(9)

// While textual information can be helpful to making some of these decisions, 
// it is usually helpful to see how these different palettes look
// Running these commands individually so the image files will be reasonable to 
// view/include in the slide deck.
brewviewer accent, c(5) seq imp

// Export to pdf
gr export exampleGraphs/brewviewAccent.pdf, as(pdf) replace

// Preview the blues palette
brewviewer blues, c(8) seq imp

// Export to pdf
gr export exampleGraphs/brewviewBlues.pdf, as(pdf) replace

// Preview the oranges palette
brewviewer oranges, c(6) seq imp

// Export to pdf
gr export exampleGraphs/brewviewOranges.pdf, as(pdf) replace

// Preview the category 10 palette
brewviewer category10, c(10) seq imp

// Export to pdf
gr export exampleGraphs/brewviewCategory10.pdf, as(pdf) replace

// Preview the category 10 palette
brewviewer set1, c(9) seq imp

// Export to pdf
gr export exampleGraphs/brewviewSet1.pdf, as(pdf) replace
