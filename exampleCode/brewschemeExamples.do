// You can see the online documentation for other examples, but these should 
// give you some ideas of what you can do to create different types of schemes 
// using the default themes

// This will use the category 10 palette from D3 with a color intensity of 60
// for all graph types
brewscheme, scheme(sdp2016a) allsty(category10) allc(10) allsat(60)

// If you primarily create bar, pie, and line graphs, you can specify palettes
// for only those types of graphs.  We'll assume that bar graphs are used for 
// ordinal scale data, pie graphs for nominal scale data, and individual lines 
// would be used for different dimensions of a single measure/fact
brewscheme, scheme(sdp2016b) piesty(spectral) piec(5) barsty(blues) barc(8)  ///   
linesty(category10) linec(10) somesty(oranges) somec(6) 					 ///   
symbols(circle diamond plus square triangle X)

// If, however, your organization has style guides that require graph legends
// to appear in the right margin of a graph, we can easily create variants of 
// the schemes above by generating custom themes that we pass to brewscheme
brewtheme sdp2016theme, clockdir("legend_position 3") numsty("legend_cols 1" ///   
"legend_rows 0" "zyx2rows 0" "zyx2cols 1") barlabelsty("bar none") 			 ///   
graphsi("x 5.5" "y 4")

// Now the same two schemes from above can be generated with settings modified 
// in a way that affects all graph types (with the exception of the bar label style)
brewscheme, scheme(sdp2016a2) allsty(category10) allc(10) allsat(60) 		 ///   
themef(sdp2016theme)

brewscheme, scheme(sdp2016b2) piesty(spectral) piec(5) barsty(blues) barc(8) ///   
linesty(category10) linec(10) somesty(oranges) somec(6) themef(sdp2016theme)
