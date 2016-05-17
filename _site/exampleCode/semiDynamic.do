/* 
This example requires a bit more work/code.  
The first step will be to install the libhtml Mata library from the project repository:

net inst libhtml, from(http://wbuchanan.github.io/matahtml)

Once downloaded, you'll need to run the ado program that comes with it to get 
all of the source code and compile it on your system:

libhtml, rep lib c

Now if you run:

mata: mata mlib index

You should see an entry for libhtml.  This library provides Mata classes that 
emulate the HTML element tags defined under HTML5.  */

// Install libhtml package
net inst libhtml, from("http://wbuchanan.github.io/matahtml/") replace

// Build the library on your system:
libhtml, rep lib c

// Load example data
msas using msas.xlsx, perf

// Create a new subdirectory for these examples
mkdir dynamicex1

// Get the list of all the school district names:
qui: levelsof distnm if distnm != `"* Mississippi"' & !mi(rlapro) & 		 ///   
!mi(rlagrol) & schnm == "District Level", loc(dists)

// loop over district names to create school level scatterplots wihtin districts
foreach d of loc dists {

	// Store the code for the if option (will reduce amount of code needed
	loc ifopt `""District Level" & distnm == `"`d'"' & !mi(rlapro) & !mi(rlagrol)"'

	// Get the district level value for reading proficiency
	qui: su rlapro if schnm == `ifopt'
	
	// Store the result
	loc distpro = r(mean)
	
	// Get the district level value for reading growth of the low 25%
	qui: su rlagrol if schnm == `ifopt'
	
	// Store this result
	loc distgrol = r(mean)
	
	// If there are district level results should be school level too
	if `distpro' != . & `distgrol' != . {
	
		// Now create the scatter plot
		tw scatter rlapro rlagrol if schnm != `ifopt', scheme(sdp2016b) 	 ///   
		yline(`distpro') xline(`distgrol') ti(`"`d'"') ysca(range(0(10)100)  ///   
		subti("School Level Accountability Results") ylab(0(10)100)			 ///   
		xsca(range(0(10)110)) xlab(0(10)110) ymti(0(1)100) xmti(0(1)110)	 ///   
		note("Lines Show District Level Scores on the Same Outcomes")
		
		// Save the scatterplot to the newly created subdirectory
		gr export `"dynamicex1/`d'.png"', as(png) replace
	
	} // End IF Block for districts with results
	
} // End Loop over districts

// The ado wrapper I was working on didn't work as planned, but you can still 
// call the Mata libraries directly from your Stata script
// This line should work for most everyone other wise just point it to the location
// where the mata file is located
// run `"`c(sysdir_plus)'/d/dynamicPage1.mata"'
run ./dynamicPage1.mata

// The first argument is to reference the directory where the images are saved 
// relative to the html file referencing it.  I'm going to put the html file 
// in the same directory, so I'll use .. to get the self reference
// second argument is for the local macro that contains the list of names used 
// to name all of the files, and the third (optional) argument is to specify the 
// file extension used for the images
mata: c = makePage("..", "dists", ".png")

// Now that the HTML document is created and ready to go, we just need to write 
// it to disk.  
// The first argument tells the function what to call the file.  I want the file 
// to be called index.html to make it load automatically and also want to save 
// it in the same location as the image files.  
// The second argument is a reference to the contents we saved in the variable c 
// on the line above.  
mata: writePage("dynamicex1/index", c)
	
// The function also will call the makePage function if you pass it a different
// set of arguments
// mata: writePage("dynamicex1/index", "", "..", "dists", ".png")
