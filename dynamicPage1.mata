// Now we need to use a bit of Mata to construct the HTML/JavaScript needed 
// To create the image browser
mata:

// mata drop makePage()
// mata drop writePage()

// This function will build the HTML page to display the images
string scalar makePage(string scalar rootdir, string scalar distlist, 		 ///   
						| string scalar fmt) {

	// Declare all of the variable used by the function
	class doctype scalar doc
	class meta scalar metatag
	class head scalar headtag
	class body scalar bodytag
	class div scalar divtag
	class p scalar dropdownContainer, imageContainer
	class img scalar imgtag 
	class stselect scalar dropdown
	class option scalar opt
	class script scalar js
	string scalar options
	string rowvector distnames
	real scalar i	
	
	// Defaults to referencing .png files if no format is passed
	if (args() != 3) fmt = ".png"
	
	// Otherwise makes sure the format begins with a .
	else if (substr(fmt, 1, 1) != ".") fmt = "." + fmt
	
	// JavaScript call back that gets fired when a the drop down is changed
	js.setClassArgs("function swapImage(select) {" + char((10)) +			 ///   
	`"  var image = document.getElementsByName("Sch")[0];"' + char((10)) +   ///   
	"  image.src = select.options[select.selectedIndex].value;" + 			 ///   
	char((10)) + "}")
	
	// Add the Javascript code to the head element
	headtag.setClassArgs(js.print())
	
	// The image will be displayed and have an id called schoolGraph
	// we're also trying to make the image reasonably sized as well
	imgtag.setSrc("").setId("Graph").setName("Sch").setStyle("height:400px;width:600px")
	
	// Put the image inside of a container element (using paragraphs here but 
	// you could just as easily use a div)
	imageContainer.setClassArgs(imgtag.print())

	// Set the character encoding 
	metatag.setCharset("utf-8")
	
	// Set the document type
	doc.setDocType("html")
	
	// This tells the server what to do when the dropdown is changed
	dropdown.setName("districtSelector").setOnchange("swapImage(this);")

	// Get all of the district names from the local macro we created above
	distnames = tokens(st_local(distlist))
	
	// Set the null value that will just tell the user what to do
	opt.setValue("").setClassArgs("Select a District")
	
	// Add this option to the string containing all of the options
	options = opt.print() 
	
	// Loop over the district names
	for(i = 1; i <= cols(distnames); i++) {
	
		// This will be the path to the image
		opt.setValue(rootdir + "/" + distnames[1, i] + fmt)
		
		// This will make the option show the district name instead of the path
		opt.setClassArgs(distnames[1, i])
		
		// And this will add the option to the string containing the other options
		options = options + opt.print()
		
	} // End Loop over district names
	
	// Now, we'll add all of the option elements to the select element (dropdown)
	dropdown.setClassArgs(options)
	
	// And put the dropdown in its own container 
	dropdownContainer.setClassArgs(dropdown.print())
	
	// Now we populate the div tag (that will be in the body) with the containers
	// for the dropdown menu and the image
	divtag.setClassArgs(dropdownContainer.print() + char((10)) + imageContainer.print())
	
	// And now the div tag gets placed in the body tag
	bodytag.setClassArgs(divtag.print())
	
	// And the last step is to add all of the elements to the document
	doc.setClassArgs(metatag.print() + char((10)) + headtag.print() + char((10)) + bodytag.print())
	
	// Then we return the formatted string
	return(doc.print())	
	
} // End function declaration

// Define a function to handle writing the page to a file
void writePage(string scalar filenm, | string scalar contents, 				 ///   
			   string scalar rootdir, string scalar distlist, string scalar fmt) {
	
	// Declares the member variable used to store the file handle/connection
	real scalar fh

	// Opens the file for writing
	fh = fopen(filenm + ".html", "w")

	// If two arguments passed it assumes contents have been passed and writes 
	// those contents to the file
	if (args() == 2) fwrite(fh, contents)
	
	// Otherwise it will call the makePage function for you
	else fwrite(fh, makePage(rootdir, distlist, fmt))
	
	// Closes the opened file connection
	fclose(fh)

} // End Function definition


// End of Mata block
end
