// Defines ado wrapper around mata library to create HTML content
prog def dynpage1

	// Minimum version of Stata required
	version 12
	
	// Defines syntax used to call the command
	syntax [, devmode FILEnm(string asis) DIRectory(string asis)			 ///  
			  LISTContainer(string asis) IMGFormat(string asis) ]
	
	cap mata: mata drop makePage()
	cap mata: mata drop writePage()
	
	// If development mode not triggered will search for the mata file on the path
	if `"`devmode'"' == "" {
	
		// Locate and run the Mata source
		cap findfile dynamicPage1.mata
		cap run `"`r(fn)'"'
	
	} // End IF Block for development mode
	
	// For local development only
	else cap run ./dynamicPage1.mata
	
	cap confirm new file `"`filenm'.html"'
	
	if _rc != 0 erase `"`filenm'.html"'

	// Calls mata function to write the HTML contents to disk
	mata: c = makePage(`"`directory'"', `listcontainer', "`imgformat'")
	
	mata: writePage(`"`filenm'"', "", `"`directory'"', `listcontainer', "`imgformat'")
	
// End of program 	
end

