// Set the random number seed for Mata
mata: rseed(7779311)

// Simulate item responses from a Rasch model
irtsim, th(0 1.5) nob(5000) discrim(1) diff(-2(0.5)2) scalef(1) pseudog(0)

// Fit a 1PL model to the data
irt 1pl item1-item9

// Now you can look at ICC
irtgraph icc item1-item9, scheme(sdp2016b) n(1500)

// Save the graph example for the slide deck
gr export exampleGraphs/itemCharacteristicCurves.pdf, as(pdf) replace

// Example of single item characteristic curve
irtgraph icc item3, scheme(sdp2016b) bloc ploc  n(1500)

// Save the graph example for the slide deck
gr export exampleGraphs/itemCharacteristicCurve.pdf, as(pdf) replace

// Example of item information functions
irtgraph iif item1-item9, scheme(sdp2016b2) n(1500)

// Save the graph example for the slide deck
gr export exampleGraphs/itemInformationFunctions.pdf, as(pdf) replace

// Example of test characteristic curve
irtgraph tcc, scheme(sdp2016a) n(1500) th(-2(1)2) ra(-5 5)

// Save the graph example for the slide deck
gr export exampleGraphs/testCharacteristicCurve.pdf, as(pdf) replace

// Example of test information function
irtgraph tif, scheme(sdp2016a) n(1500) se ra(-5 5)

// Save the graph example for the slide deck
gr export exampleGraphs/testInformationFunction.pdf, as(pdf) replace
