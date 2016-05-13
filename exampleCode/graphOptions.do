// Load the performance data
msas using msas.xlsx, perf

// 1. Start trying to create a simple graph
tw (scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co") /// 
(scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") ///
& distnm == "Desoto Co")(scatter rlagrol rlapro if schnm == "Olive Branch MS")

// Export copy of graph to disk
qui: gr export exampleGraphs/scatterIter1.pdf, as(pdf) replace

// 2. Now adjust the labels to be a bit more meaningful/useful
tw (scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co") /// 
(scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") ///
& distnm == "Desoto Co")(scatter rlagrol rlapro if schnm == "Olive Branch MS", ///   
legend(label(1 "All Other Schools") label(2 "Desoto County") label(3 "Olive Branch MS")))

// Export copy of graph to disk
qui: gr export exampleGraphs/scatterIter2.pdf, as(pdf) replace

// 3. Now adjust the rendering of the axes
tw (scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co") /// 
(scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") ///
& distnm == "Desoto Co")(scatter rlagrol rlapro if schnm == "Olive Branch MS", ///   
legend(label(1 "All Other Schools") label(2 "Desoto County") label(3 "Olive Branch MS")) ///   
ylab(#11, angle(0) nogrid) xlab(#10) ymti(0(1)100) xmti(0(1)100) )

// Export copy of graph to disk
qui: gr export exampleGraphs/scatterIter3.pdf, as(pdf) replace

// 4. Try to make the different groups contrast against one another a bit more
tw (scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co", mc(orange)) /// 
(scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") ///
& distnm == "Desoto Co", mc(purple))(scatter rlagrol rlapro if schnm == "Olive Branch MS", ///   
legend(label(1 "All Other Schools") label(2 "Desoto County") label(3 "Olive Branch MS")) ///   
ylab(#11, angle(0) nogrid) xlab(#10) ymti(0(1)100) xmti(0(1)100) mc(blue))

// Export copy of graph to disk
qui: gr export exampleGraphs/scatterIter4.pdf, as(pdf) replace

// 5. Color contrast is good, but overall could be better to tell the story of 1 school
tw (scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co", mc(orange) msize(small) mlc(black) mlw(vthin)) /// 
(scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") ///
& distnm == "Desoto Co", mc(purple) msize(medium) mlc(black) mlw(vthin))(scatter rlagrol rlapro if schnm == "Olive Branch MS", ///   
legend(label(1 "All Other Schools") label(2 "Desoto County") label(3 "Olive Branch MS")) ///   
ylab(#11, angle(0) nogrid) xlab(#10) ymti(0(1)100) xmti(0(1)100) mc(blue) msize(large) mlc(black) mlw(vthin))

// Export copy of graph to disk
qui: gr export exampleGraphs/scatterIter5.pdf, as(pdf) replace

// 6. Now get rid of all the background noise and move the legend
tw (scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co", mc(orange) msize(small) mlc(black) mlw(vthin)) /// 
(scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") ///
& distnm == "Desoto Co", mc(purple) msize(medium) mlc(black) mlw(vthin))(scatter rlagrol rlapro if schnm == "Olive Branch MS", ///   
legend(label(1 "All Other Schools") label(2 "Desoto County") label(3 "Olive Branch MS") pos(12) region(lc(white)) rows(1) size(medsmall) span) ///   
ylab(#11, angle(0) nogrid) xlab(#10) ymti(0(1)100) xmti(0(1)100) mc(blue) msize(large) mlc(black) mlw(vthin) ///   
graphr(ic(white) fc(white) lc(white)) plotr(ic(white) fc(white) lc(white)))

// Export copy of graph to disk
qui: gr export exampleGraphs/scatterIter6.pdf, as(pdf) replace

// 7. Realize some type of smoother could help things, so now this gets added
tw (fpfitci rlagrol rlapro if schnm != "District Level", lc(black) lw(medthin) fc(green)) ///
(scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co", mc(orange) msize(small) mlc(black) mlw(vthin)) /// 
(scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") ///
& distnm == "Desoto Co", mc(purple) msize(medium) mlc(black) mlw(vthin))(scatter rlagrol rlapro if schnm == "Olive Branch MS", ///   
legend(label(1 "All Other Schools") label(2 "Desoto County") label(3 "Olive Branch MS") pos(12) region(lc(white)) rows(1) size(medsmall) span) ///   
ylab(#11, angle(0) nogrid) xlab(#10) ymti(0(1)100) xmti(0(1)100) mc(blue) msize(large) mlc(black) mlw(vthin) ///   
graphr(ic(white) fc(white) lc(white)) plotr(ic(white) fc(white) lc(white)))

// Export copy of graph to disk
qui: gr export exampleGraphs/scatterIter7.pdf, as(pdf) replace

// 8. Finally something decent enough for export
tw (fpfitci rlagrol rlapro if schnm != "District Level", lc(black) lw(medthin) fc(green)) ///
(scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co", mc(orange) msize(small) mlc(black) mlw(vthin)) /// 
(scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") ///
& distnm == "Desoto Co", mc(purple) msize(medium) mlc(black) mlw(vthin))(scatter rlagrol rlapro if schnm == "Olive Branch MS", ///   
legend(order(3 4 5) label(3 "All Other Schools") label(4 "Desoto County") label(5 "Olive Branch MS") pos(12) region(lc(white)) rows(1) size(medsmall) span) ///   
ylab(#11, angle(0) nogrid) xlab(#10) ymti(0(1)100) xmti(0(1)100) mc(blue) msize(large) mlc(black) mlw(vthin) ///   
graphr(ic(white) fc(white) lc(white)) plotr(ic(white) fc(white) lc(white)))

// Export copy of graph to disk
qui: gr export exampleGraphs/scatterIter8.pdf, as(pdf) replace

/* 
From above we can see all the iterations/effort that went into creating this 
type of graph in a format where it is ready to be used/useful.  

But, by using brewscheme to create customized schemefiles we can avoid all of the 
clutter caused by specifying the graph aesthetics above and generally get results 
that are a few minor adjustments away from production quality and are nearly 
instantaneously ready for any type of draft/internal presentation.
*/

// How the graph looks using the brewscheme scheme that we just created in 2 steps
tw fpfitci rlagrol rlapro if schnm != "District Level" || ///   
scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co" ||  ///   
scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") & distnm == "Desoto Co" || ///   
scatter rlagrol rlapro if schnm == "Olive Branch MS", yti("Reading Growth Low 25%") ylab(#11) xlab(#11) ///   
legend(order(3 4 5) label(3 "All Other Schools") label(4 "Desoto County") label(5 "Olive Branch MS")) ///   
scheme(sdp2016a2)

// Export to file
qui: gr export exampleGraphs/scatterBrewscheme1.pdf, as(pdf) replace

// Same graph, but using the scheme that includes glyph shape nominal encoding
tw fpfitci rlagrol rlapro if schnm != "District Level" || ///   
scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co" ||  ///   
scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") & distnm == "Desoto Co" || ///   
scatter rlagrol rlapro if schnm == "Olive Branch MS", yti("Reading Growth Low 25%") ylab(#11) xlab(#11) ///   
legend(order(3 4 5) label(3 "All Other Schools") label(4 "Desoto County") label(5 "Olive Branch MS")) ///   
scheme(sdp2016b)

// Export to file
qui: gr export exampleGraphs/scatterBrewscheme2.pdf, as(pdf) replace

// Why brewscheme can be useful
brewproof, scheme(sdp2016a2): ///
tw fpfitci rlagrol rlapro if schnm != "District Level" || ///   
scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co" ||  ///   
scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") & distnm == "Desoto Co" || ///   
scatter rlagrol rlapro if schnm == "Olive Branch MS", yti("Reading Growth Low 25%") ylab(#11) xlab(#11) ///   
legend(order(3 4 5) label(3 "All Other Schools") label(4 "Desoto County") label(5 "Olive Branch MS"))

// Export to file
qui: gr export exampleGraphs/scatterBrewproof.pdf, as(pdf) replace

// Bad colors in previous example, but since creating schemes is so fast and we 
// have a second scheme we can look at the other scheme we created
brewproof, scheme(sdp2016a2): ///
tw fpfitci rlagrol rlapro if schnm != "District Level" || ///   
scatter rlagrol rlapro if schnm != "District Level" & distnm != "Desoto Co" ||  ///   
scatter rlagrol rlapro if !inlist(schnm, "District Level", "Olive Branch MS") & distnm == "Desoto Co" || ///   
scatter rlagrol rlapro if schnm == "Olive Branch MS", yti("Reading Growth Low 25%") ylab(#11) xlab(#11) ///   
legend(order(3 4 5) label(3 "All Other Schools") label(4 "Desoto County") label(5 "Olive Branch MS"))


// Export to file
qui: gr export exampleGraphs/scatterBrewproof2.pdf, as(pdf) replace


