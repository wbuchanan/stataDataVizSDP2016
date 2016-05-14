// Load the performance data
msas using msas.xlsx, perf

// Fit regression model to data w/interaction term
reg gradrate i.region##c.rlagro if schnm != "District Level"

// Estimate the marginal effects for every 5 point change in reading growth
margins region, at(rlagro=(0(5)100))

// Create a graph with default settings
marginsplot

// Export the plain/default example
gr export exampleGraphs/marginsplotExample1.pdf, as(pdf) replace

// Make slight improvement
marginsplot, by(region) recastci(rarea) recast(line)

// Export the plain/default example
gr export exampleGraphs/marginsplotExample2.pdf, as(pdf) replace

// Use a custom scheme to clean things up a bit
marginsplot, by(region) recastci(rarea) recast(line) scheme(sdp2016a2)

// Export the graph to be included elsewhere
gr export exampleGraphs/marginsplot2016a2.pdf, as(pdf) replace

// Use a custom scheme to clean things up a bit
marginsplot, by(region) recastci(rarea) recast(line) scheme(sdp2016b2)

// Export the graph to be included elsewhere
gr export exampleGraphs/marginsplot2016b2.pdf, as(pdf) replace

// The same method is also helpful for visualizing nonlinear relationships
reg gradrate c.rlagrol##c.rlagrol if schnm != "District Level"

// Estimate the marginal effect of gains in points for reading growth for the low 25% on grad rates
margins, at(rlagrol=(0(5)100))

// Simple plot of the marginal effects
marginsplot

// Export the plain/default example
gr export exampleGraphs/marginsplotPolynomial1.pdf, as(pdf) replace

// You can adjust how the graph is rendered as well
marginsplot, recast(line)

// Export the plain/default example
gr export exampleGraphs/marginsplotPolynomial2.pdf, as(pdf) replace

// You can adjust how the graph is rendered as well
marginsplot, recast(line) recastci(rarea) scheme(sdp2016a)

// Export the plain/default example
gr export exampleGraphs/marginsplotPolynomial3.pdf, as(pdf) replace

