// Load the performance data
msas using msas.xlsx, perf

// Fit regression model to data w/interaction term
reg gradrate i.region##c.rlagro

// Estimate the marginal effects of Reading growth
margins region, at(rlagro=(0(5)100))

// Create a graph with default settings
marginsplot

// Export the plain/default example
gr export exampleGraphs/marginsplotExample1.eps, as(eps) replace

// Make slight improvement
marginsplot, by(region) recastci(rarea) recast(line)

// Export the plain/default example
gr export exampleGraphs/marginsplotExample2.eps, as(eps) replace

// Use a custom scheme to clean things up a bit
marginsplot, by(region) recastci(rarea) recast(line) scheme(somecolorex1)

// Export the graph to be included elsewhere
gr export exampleGraphs/marginsplotExampl3.eps, as(eps) replace
