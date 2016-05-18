// Simulate some data
schsim, avgsc(100 15) dist(3) disteff(0 .15) asi(0.065 7) bl(0.375 -7.5)	 ///   
hisp(0.2 -5.25) natam(0.03 -9.5) white(0.33 4.75) sex(0.51 3.75) 			 ///   
sp(0.11 -14.5) el(0.175 -8.5) mast(0.8 0.0125) lateh(0.225 -2.5) 			 ///   
altc(0.075 -1.5) hq(0.95 0.001) frl(0.65 -4.5) chart(0.085 0.75) 			 ///   
sch(1 15) educ(10 35) stud(18 34) yea(4) attr(0.2285) time(0 1) 			 ///   
scheff(0 1) edeff(0 5) steff(0 10) seed(7779311) 

// You can graph overlaying distributions by using the || operator or placing 
// the twoway graph commands in parentheses.
tw kdensity testscore if distid == 1 & centyear == 0 ||						 ///   
kdensity testscore if distid == 1 & schid == 1 & centyear == 0, 			 ///   
scheme(sdp2016b) legend(label(1 "District") label(2 "School"))				 ///   
xti("Standardized Test Scores") ti("Distribution of Student Test Scores")

// Save the graph
gr export exampleGraphs/nestedDistro1.pdf, as(pdf) replace

// Can do the same with percentile values and can overlay multiple schools
tw kdensity nce if distid == 1 & centyear == 0 ||							 ///   
kdensity nce if distid == 1 & centyear == 0 & schid == 1 || 				 ///   
kdensity nce if distid == 1 & centyear == 0 & schid == 2 || 				 ///   
kdensity nce if distid == 1 & centyear == 0 & schid == 3 || 				 ///   
kdensity nce if distid == 1 & centyear == 0 & schid == 4, lw(thick)			 ///   
scheme(sdp2016a) legend(label(1 "District NCE") label(2 "School 1 NCE")		 ///   
label(3 "School 2 NCE") label(4 "School 3 NCE") label(5 "School 4 NCE"))	 ///   
xti("Percentile Score") ti("Percentile Distribution of Student Test Scores")

// Save the graph
gr export exampleGraphs/nestedDistro2.pdf, as(pdf) replace

