// Clear any data from memory
clear

// Set the random number seed
set seed 7779311

// Set the number of observations to simulate data for
set obs 99

// Simulate random uniform variate
qui: g y = runiform()

// Simulate data from inverse exponential function
qui: g x = invexponential(.5, y)

// Get the summary statistics from the simulated x variable
qui: su x

// Store the maximum value of x in the local macro ma
loc ma = r(max)

// Store the minimum value of x in the local macro mi
loc mi = r(min)

// Create graph showing the production frontier curve
tw line y x, sort xsca(range(`ma'(0.1)`mi') rev line) xlab(none, nogrid)	 ///   
ysca(range(0(0.1)1)) ylab(none, nogrid) graphr(c(white)) lc(black) 			 ///   
lw(medthick) yti("Precision of Interpretation" " ", c(black) si(medium))	 ///   
xti(" " "Difficulty Perceiving Visual Encoding", c(black) si(medium))

// Export the graph to include in slides
gr export exampleGraphs/encodingProductionFunction.pdf, as(pdf) replace

