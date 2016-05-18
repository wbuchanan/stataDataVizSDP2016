/* Examples to show what different graphical components are labeled as 
in Stata graphs. */

// Create a single data point and a single x,y coordinate pair
clear
set obs 2
qui: g x = 0.5
qui: g y = 0.5
qui: g byte group = _n

// Shows all of the major text options
tw scatter y x, scheme(sdp2016a) mc(white) ti("This is the main title")		 ///   
subti("And this is a subtitle") note("This is a note")						 ///   
caption("This is a caption") t1title("This is a t1title")					 ///   
t2title("This is a t2title") b1title("This is a b1title")					 ///   
b2title("This is a b2title") l1title("This is a l1title")					 ///   
l2title("This is a l2title") r1title("This is a r1title")					 ///   
r2title("This is a r2title") yti("This is the y-axis title")				 /// 
xti("And the x-axis title") ylab(none) xlab(none)

// Save the example
gr export exampleGraphs/graphAnatomy1.pdf, as(pdf) replace

// Can all be made to be multiline elements by enclosing each line in a space
tw scatter y x, scheme(sdp2016a) mc(white) ti("This is the" "main title")	 ///   
subti("And this is" "a subtitle") note("This is" "a note")					 ///   
caption("This is" "a caption") t1title("This is" "a t1title")				 ///   
t2title("This is" "a t2title") b1title("This is" "a b1title")				 ///   
b2title("This is" "a b2title") l1title("This is" "a l1title")				 ///   
l2title("This is" "a l2title") r1title("This is" "a r1title")				 ///   
r2title("This is" "a r2title") yti("This is the" "y-axis title")			 /// 
xti("And the" "x-axis title") ylab(none) xlab(none)

// Save the example
gr export exampleGraphs/graphAnatomy2.pdf, as(pdf) replace

// Can adjust horizontal alignment with the justification option (or span) 
tw scatter y x, scheme(sdp2016a) mc(white) ylab(none) xlab(none)			 ///
ti("This is the main title (centered)", span)								 ///   
subti("And this is a subtitle (centered)", span) 							 /// 
note("This is a note (right aligned)", justification(right) bexpand)		 ///   
caption("This is a caption (left aligned)", justification(left) bexpand)	 /// 
t1title("This is a t1title (left aligned)", justification(left) bexpand)	 /// 
t2title("This is a t2title (right aligned)", justification(right) bexpand)	 /// 
b1title("This is a b1title (left aligned)", justification(left) bexpand)	 ///   
b2title("This is a b2title (right aligned)", justification(right) bexpand)	 /// 
l1title("This is a l1title (left aligned)", justification(left) bexpand)	 ///   
l2title("This is a l2title (right aligned)", justification(right) bexpand)	 /// 
r1title("This is a r1title (left aligned)", justification(left) bexpand)	 ///   
r2title("This is a r2title (right aligned)", justification(right) bexpand)	 /// 
yti("This is the y-axis title (right aligned)", justification(right) bexpand) /// 
xti("And the x-axis title (left aligned)", justification(right) bexpand) 

// Save the example
gr export exampleGraphs/graphAnatomy3.pdf, as(pdf) replace

// Can adjust vertical alignment with the alignment option
tw scatter y x, scheme(sdp2016a) mc(white) ylab(none) xlab(none)			 ///
ti("This is the main title (middle)", alignment(middle))					 ///   
subti("And this is a subtitle (baseline)", alignment(baseline)) 			 /// 
note("This is a note (top aligned)", alignment(top))						 ///   
caption("This is a caption (bottom aligned)", alignment(bottom))			 /// 
t1title("This is a t1title (bottom aligned)", alignment(bottom))			 /// 
t2title("This is a t2title (top aligned)", alignment(top))					 /// 
b1title("This is a b1title (bottom aligned)", alignment(bottom))			 ///   
b2title("This is a b2title (top aligned)", alignment(top))					 /// 
l1title("This is a l1title (bottom aligned)", alignment(bottom))			 ///   
l2title("This is a l2title (top aligned)", alignment(top))					 /// 
r1title("This is a r1title (bottom aligned)", alignment(bottom))			 ///   
r2title("This is a r2title (top aligned)", alignment(top))					 /// 
yti("This is the y-axis title (top aligned)", alignment(top))				 /// 
xti("And the x-axis title (bottom aligned)", alignment(top)) 

// Save the example
gr export exampleGraphs/graphAnatomy4.pdf, as(pdf) replace

// Position is for clock, ring is for distance from center ring = 0 is inside
tw scatter y x, mc(white) ylab(none) xlab(none)								 ///
graphr(ic(white) fc(white) lc(white)) plotr(ic(white) fc(white) lc(white))   ///   
ti("This is the main title (pos 12, ring 0)", ring(0) position(12))			 ///   
subti("And this is a subtitle (pos 0, ring 0)", ring(0) position(0))  

// Save the example
gr export exampleGraphs/graphAnatomyRing1.pdf, as(pdf) replace

// As long as position is not zero the elements are in the plot region
tw scatter y x, mc(white) ylab(none) xlab(none)								 ///
graphr(ic(white) fc(white) lc(white)) plotr(ic(white) fc(white) lc(white))   ///   
ti("This is the main title (pos 12, ring 0)", ring(0) position(12))			 ///   
subti("And this is a subtitle (pos 6, ring 0)", ring(0) position(6))  

// Save the example
gr export exampleGraphs/graphAnatomyRing2.pdf, as(pdf) replace

// As soon as ring has a positive value, the element is no long in the plot region
tw scatter y x, mc(white) ylab(none) xlab(none)								 ///
graphr(ic(white) fc(white) lc(white)) plotr(ic(white) fc(white) lc(white))   ///   
ti("This is the main title (pos 12, ring 0)", ring(0) position(12))			 ///   
subti("And this is a subtitle (pos 6, ring 1)", ring(1) position(6))  

// Save the example
gr export exampleGraphs/graphAnatomyRing3.pdf, as(pdf) replace

// The greater the value of ring, the furter away it will be placed
tw scatter y x, mc(white) ylab(none) xlab(none)								 ///
graphr(ic(white) fc(white) lc(white)) plotr(ic(white) fc(white) lc(white))   ///   
ti("This is the main title (pos 12, ring 10)", ring(10) position(12))		 ///   
subti("And this is a subtitle (pos 3, ring 7)", ring(7) position(3))  

// Save the example
gr export exampleGraphs/graphAnatomyRing4.pdf, as(pdf) replace

// To keep the title centered on the entire image you need to use the span option
tw scatter y x, mc(white) ylab(none) xlab(none)								 ///
graphr(ic(white) fc(white) lc(white)) plotr(ic(white) fc(white) lc(white))   ///   
ti("This is the main title (pos 12, ring 10)", ring(10) position(12) span)	 ///   
subti("And this is a subtitle (pos 3, ring 7)", ring(7) position(3))  

// Save the example
gr export exampleGraphs/graphAnatomyRing5.pdf, as(pdf) replace

// Position is for clock, ring is for distance from center ring = 0 is inside
tw scatter y x, mc(white) ylab(none) xlab(none)								 ///
graphr(ifc(yellow) fc(blue) lc(orange) ilc(purple) lw(thick) ilw(thick)) 	 ///
plotr(ic(white) fc(white) lc(white))  										 ///   
ti("Graph Region Options", ring(1) position(12) span c(black) size(large))	 ///   
text(0.5 0.5 "Orange line = Outer Region Line"								 ///
"Blue line = Outer Region Fill" "Purple Line = Inner Region Line"			 ///   
"Yellow Line = Inner Region Line", place(c) width(60) 						 ///
justification(center) alignment(middle))

// Save the example
gr export exampleGraphs/graphGraphRegions.pdf, as(pdf) replace

// As long as position is not zero the elements are in the plot region
tw scatter y x, mc(yellow) ylab(none) xlab(none)							 ///
graphr(ic(white) fc(white) lc(white))										 ///   
plotr(ifc(yellow) fc(blue) lc(orange) ilc(purple) lw(thick) ilw(thick)) 	 ///
ti("Plot Region Options", ring(1) position(12) span c(black) size(large))	 ///   
text(0.5 0.5 "Orange line = Outer Region Line"								 ///
"Blue line = Outer Region Fill" "Purple Line = Inner Region Line"			 ///   
"Yellow Line = Inner Region Line", place(c) width(60) 						 ///
justification(center) alignment(middle))

// Save the example
gr export exampleGraphs/graphPlotRegions.pdf, as(pdf) replace

// All options together:
tw scatter y x, mc(green) ylab(none) xlab(none)								 ///
graphr(ifc(gs9) fc(blue) lc(orange) ilc(purple) lw(thick) ilw(thick)) 		 ///
plotr(ifc(green) fc(brown) lc(cyan) ilc(yellow) lw(thick) ilw(thick)) 		 ///
text(0.5 0.5 "Orange line = Graph Outer Region Line"						 ///
"Blue line = Graph Outer Region Fill"										 ///   
"Purple Line = Graph Inner Region Line"										 ///   
"Grey Line = Graph Inner Region Line" 										 ///
"Cyan line = Plot Outer Region Line"										 ///
"Brown line = Plot Outer Region Fill"										 ///   
"Yellow Line = Plot Inner Region Line"										 ///   
"Green Line = Plot Inner Region Line"										 ///   
"(this is all contained in a text box"										 ///   
"using the added text options)", place(c) width(75) box bc(white) blc(black) ///   
blw(vthick) m(medium) justification(center) alignment(middle) )

// Save the example
gr export exampleGraphs/graphAllRegions.pdf, as(pdf) replace

// Shows all of the major text options
tw scatter y x, mc(white) ti("This is the main title", c(black))			 ///   
subti("And this is a subtitle", nobox) note("This is a note")				 ///   
caption("This is a caption") t1title("This is a t1title")					 ///   
t2title("This is a t2title") b1title("This is a b1title")					 ///   
b2title("This is a b2title") l1title("This is a l1title")					 ///   
l2title("This is a l2title") r1title("This is a r1title")					 ///   
r2title("This is a r2title") yti("This is the y-axis title")				 /// 
xti("And the x-axis title") ylab(none, nogrid) xlab(none)					 ///   
by(group, ti("This is a by-graph Title", c(black))  						 ///   
subti("This is a by-graph Sub-title")										 ///   
note("This is a by-graph note")  											 ///   
caption("This is a by-graph caption")										 ///   
t1title("This is a by-graph t1title") 										 ///   
t2title("This is a by-graph t2title") 										 ///    
b1title("This is a by-graph b1title") 										 ///    
b2title("This is a by-graph b2title") 										 ///    
l1title("This is a by-graph l1title") 										 ///    
l2title("This is a by-graph l2title") 										 ///    
r1title("This is a by-graph r1title") 										 ///    
r2title("This is a by-graph r2title") graphr(c(white)) plotr(c(white)))

// Save the example
gr export exampleGraphs/byGraphAnatomy1.pdf, as(pdf) replace
