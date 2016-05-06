// Clear any data from memory
clear

/*
Copy of Anscombe's Quartets from 

TABLE.  Four data sts, each comprising 11 (x, y) pairs. (pp. 19)

Anscombe, F. J. (1973).  Graphs in Statistical Analysis.  The American 
	Statistician, 27(1), pp 17-21.
*/
input byte(figures id) double(x y)
1 1 10.0 8.04
1 2 8.0 6.95
1 3 13.0 7.58
1 4 9.0 8.81
1 5 11.0 8.33
1 6 14.0 9.96
1 7 6.0 7.24
1 8 4.0 4.26 
1 9 12.0 10.84
1 10 7.0 4.82 
1 11 5.0 5.68
2 3 10.0 9.14 
2 2 8.0 8.14 
2 3 13.0 8.74 
2 4 9.0 8.77 
2 5 11.0 9.26 
2 6 14.0 8.10 
2 7 6.0 6.13 
2 8 4.0 3.10 
2 9 12.0 9.13 
2 10 7.0 7.26 
2 12 5.0 4.74 
3 1 10.0 7.46 
3 2 8.0 6.77 
3 3 13.0 12.74 
3 4 9.0 7.11 
3 5 11.0 7.81 
3 6 14.0 8.84 
3 7 6.0 6.08 
3 8 4.0 5.39 
3 9 12.0 8.15 
3 10 7.0 6.42 
3 13 5.0 5.73 
4 1 8.0 6.58 
4 2 8.0 5.76 
4 3 8.0 7.71 
4 4 8.0 8.84 
4 5 8.0 8.47 
4 6 8.0 7.04 
4 7 8.0 5.25 
4 8 19.0 12.50 
4 9 8.0 5.56 
4 10 8.0 7.91 
4 11 8.0 6.89
end

// Define value labels for the figures variable
la def figures 	1 "Figure 1 (pp. 19)" 2 "Figure 2 (pp. 19)"					 ///   
				3 "Figure 3 (pp. 20)" 4 "Figure 4 (pp. 20)"
				
// Apply the value labels
la val figures figures

// Recreate the original quartet 
tw lfit y x, lc(black) || scatter y x,  ylab(0(5)10, angle(0) nogrid) 		 ///   
xlab(0(5)20) ymti(0(1)13) xmti(0(1)20) graphr(sty(background)) 				 ///   
plotr(sty(background)) scheme(s1mono) msym(o) mc(black) xti("") 			 ///   
by(figures, note(" ") legend(off) ti("Anscombe's (1973) Quartet", c(black) 	 ///   
size(large) span)) xsize(9) ysize(6.5) name(anscombesQuartet, replace)

gr export ~/Desktop/Programs/StataPrograms/s/sdp2016/exampleGraphs/anscombesQuartet.eps, as(eps) replace


