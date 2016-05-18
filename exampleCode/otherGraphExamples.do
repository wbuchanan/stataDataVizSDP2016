// Simulate some data
schsim, avgsc(100 15) dist(3) disteff(0 .15) asi(0.065 7) bl(0.375 -7.5)	 ///   
hisp(0.2 -5.25) natam(0.03 -9.5) white(0.33 4.75) sex(0.51 3.75) 			 ///   
sp(0.11 -14.5) el(0.175 -8.5) mast(0.8 0.0125) lateh(0.225 -2.5) 			 ///   
altc(0.075 -1.5) hq(0.95 0.001) frl(0.65 -4.5) chart(0.085 0.75) 			 ///   
sch(1 15) educ(10 35) stud(18 34) yea(4) attr(0.2285) time(0 1) 			 ///   
scheff(0 1) edeff(0 5) steff(0 10) seed(7779311) 

// Retain the data in memory
preserve

	// Retain only a few variables
	keep stdid schyr tchid schid distid testscore proflevel race sex sped ell 	 ///   
	frl nce

	// Reshape the data into wide/multivariate format
	reshape wide testscore nce proflevel, i(distid schid tchid stdid) j(schyr)

	// Need to create time indicators
	forv i = 2006/2009 {

		// Creates a school year variable
		qui: g int x`i' = `i'
		
	} // End Loop 

	// Stores if condition for graphs
	loc ifc distid == 1 & schid == 1 

	// Creates a parallel coordinates (paired coordinates in Stata vernacular) 
	// plot of student test scores
	tw pcspike testscore2006 x2006 testscore2007 x2007 if `ifc',				 ///   
	by(tchid, ti("Test Score Changes From 2006 to 2007") 						 ///   
	note("Panels by Classroom")) xlab(#2) xsca(range(2006(1)2007)) 				 ///   
	xti("School Year") scheme(sdp2016b2) yti("Test Scores")

	// Save the example
	gr export exampleGraphs/parallelCoordinates1.pdf, as(pdf) replace

	// Now create the parallel coordinates plot
	tw pcspike testscore2006 x2006 testscore2007 x2007 if `ifc' || 				 ///   
	pcspike testscore2007 x2007 testscore2008 x2008 if `ifc'  || 				 ///   
	pcspike testscore2008 x2008 testscore2009 x2009 if `ifc', 					 ///   
	scheme(sdp2016a) xti("School Year") yti("Test Scores") 						 ///   
	ti("Student Test Scores Over Time") 

	// Save the example
	gr export exampleGraphs/parallelCoordinates2.pdf, as(pdf) replace

	// Almost same type of graph, but not as usefull if there are too many observations
	xtset stdid schyr

	// Looks like a spaghetti monster attacked your screen
	xtline testscore if distid == 1 & schid == 1, ov legend(off) scheme(sdp2016a2)

	// Save the example
	gr export exampleGraphs/parallelCoordinates3.pdf, as(pdf) replace

// Can be useful for aggregates
restore, preserve

	// Retain just a bit of the data
	keep distid schid tchid clsavg schyr
	
	// Remove duplicate observations
	duplicates drop
	
	// Set the dataset up as a longitudinal/time series data set
	xtset tchid schyr
	
	// Show class level trends within a school
	xtline clsavg if distid == 1 & schid == 1, ov scheme(sdp2016a2)
	
	// Save the example
	gr export exampleGraphs/parallelCoordinates4.pdf, as(pdf) replace

// restore data to original state
restore, preserve

	// Keep a subset of variables
	keep distid schid schyr schpctmasters schpctlate schpctaltcert schpcthq  ///   
	schpctsped schpctell schpctfrl schpctasian schpctblack schpcthisp 		 ///   
	schpctnatam schpctwhite schavg schsize 
	
	// Keep data from a single year
	qui: keep if schyr == 2006
	
	// Remove duplicate observations
	qui: duplicates drop
	
	// Stores the variable names for the correlation matrix
	loc vars schpctmasters schpctlate schpctaltcert schpcthq schpctsped 	 ///   
	schpctell schpctfrl schpctasian schpctblack schpcthisp schpctnatam 		 ///   
	schpctwhite schavg schsize 
	
	// Get the correlations among all the school level variables
	qui: corr `vars'
	
	// Store the returned correlation matrix in a permanent matrix
	mat corr = r(C)
	
	// Define the column names based on the variables used for the correlation
	mat colnames corr = `vars'
	
	// Clear data from memory
	clear	
	
	// Create a data set from a matrix and name the variables based on column names
	qui: svmat corr, names(col)
	
	// Create a y variable that identifies the rows of the matrix
	qui: g byte y = _n

	// Loop over the variable name indices
	forv i = 1/`: word count `vars'' {
	
		// Define y variable value labels
		la def y `i' "`: word `i' of `vars''", add
		
		// Define x variable value labels in the opposite direction
		la def x `= `= `c(N)' + 1' - `i'' "`: word `i' of `vars''", add
		
		// Rename the variables in the opposite direction (e.g., 1st variable
		// will be z13, last variable will be z1, etc...)
		qui: rename `: word `i' of `vars'' z`= `= `c(N)' + 1' - `i''
		
	} // End Loop over variables
	
	// Label the y variable values
	la val y y
	
	// Normalize the dataset
	qui: reshape long z, i(y) j(x)
	
	// Label the x variable values
	la val x x
	
	// Store the number of variables
	loc end `: word count `vars''
	
	// Creates a heatmap using the correlation coefficients
	tw contour z y x, heatmap scheme(sdp2016a) ysca(range(1(1)`end')) 		 ///   
	ylab(#`end') xsca(range(1(1)`end')) xlab(#`end', angle(45))				 ///   
	ccut(-1 -0.8 -0.6 -0.4 -0.2 0 0.2 0.4 0.6 0.8 1) xti("") yti("")		 ///   
	ti("Correlation Heatmap") sc(orange) ec(blue) crule(lin) zti("Correlation")

	// Export to a pdf 
	gr export exampleGraphs/correlationHeatmap.pdf, as(pdf) replace
	
// restore data to original state
restore 	
	
// Most under rated visualization (in my opinion at least)
gr dot (min) min = testscore (p25) pct25 = testscore						 ///   
(p50) median = testscore (p75) pct75 = testscore (max) max = testscore if 	 ///   
distid == 1, over(schyr)  asyvars scheme(sdp2016a) blabel(none) 			 ///   
legend(label(1 "Minimum") label(2 "25th %ile") label(3 "50th %ile") 		 ///   
label(4 "75th %ile") label(5 "Maximum")) by(schid, 							 ///   
ti("Tukey's Five Number Summary") subti("Test Scores by School Over Time"))

// Save the example
gr export exampleGraphs/theDotPlot.pdf, as(pdf) replace


