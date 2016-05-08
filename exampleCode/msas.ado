/*******************************************************************************
*                                                                              *
* Description -                                                                *
*       Program used to simplify the acquisition, cleaning, and preparation of *
*       data used for SDP 2016 Convenining talk on Stata Data visualizaitons.  *  
*       Can download the data from the site or use copy from disk and has 	   *
*       options that allow the Stata formatted data to be saved to disk or     *
*       loaded from the MS Excel file at run time.                             *
*                                                                              *
* Dependencies - Internet connection if using the dlfile option                *
*                                                                              *
* Returns - Copy of statewide accountability system data with options to build *
*       cleaned/prepped Stata formatted files of the same data.                *
*                                                                              *
*******************************************************************************/

*! msas
*! 08may2016
*! v 0.0.1

// Drop the program from memory if previously loaded
cap prog drop msas

// Define the executable program
prog def msas

	// Define the minimum version of Stata needed to execute the program
	version 13
	
	// Defines syntax for calling the program w/o optional arg for performance 
	// or participation, will just load the data, w/optional args will save the 
	// cleaned data to disk in the location passed to the parameter
	syntax [using/] [, PERF PERF2(string) PARTIC PARTIC2(string) DLFile(string asis) ]

	// To build URL to location of data set
	loc root "http://reports.mde.k12.ms.us/xls/a/2013-14/"
	loc flink "2014%20Accountability%20District%20and%20School%20Results%20File.xlsx"

	// Copies the data set to your local working directory with a shorter filename
	if `"`dlfile'"' != "" & `"`using'"' == "" {								    
		
		// Create a reference for the location of the file 
		loc thefile `: subinstr loc dlfile ".xlsx" "", all'.xlsx

		// Download the file and save to disk
		copy `"`root'`flink'"' `"`thefile'"'
		
	} // End IF Block for downloading the file	
		
	// If using and download file are specified or neither specified
	else if (`"`dlfile'"' == "" & `"`using'"' == "") |						 ///   
	(`"`dlfile'"' != "" & `"`using'"' != "") {
	
		// Prints error message to screen 
		di as err "Either need to specify where to save the downloaded file" ///  
		" OR specify where the file is saved."
		
		// Throws error code
		err 198
		
	} // End ELSEIF Block for incorrect value specification
	
	// For all other cases
	else {
		
		// Reference the using file for the file
		loc thefile `using'
		
	} // End ELSE Block	

	// Calls the performance data subroutine if option specified
	if `"`perf'`perf2'"' != "" perfdata using `"`thefile'"', sa(`perf2')
	
	// Calls the participation data subroutine if option specified
	if `"`partic'`partic2'"' != "" particdata using `"`thefile'"', sa(`partic2')
	
// Ends main program definition	
end	

// Drops subroutine from memory if already loaded
cap prog drop particdata

// Defines subroutine for performance data handling
prog def particdata

	// Version required
	version 13.1
	
	// Defines syntax used to call subroutine
	syntax using , [ SAve(string asis) ]
	
	// Stores the worksheet names
	loc sheet "Participation Reading" "Participation Math" "Participation Science"
	
	// Reserve name space for tempfiles to assemble the data
	tempfile sub1 sub2 sub3
	
	// Loop over the subject areas
	forv i = 1/3 {
	
		// Load district level participation rate data
		import excel `using', sheet(`"`: word `i' of "`sheet'"'"') first case(l) clear
		
		// Rename the variables in the data set
		rename (district allstudents studentswdisabilities 					 ///   
		limitedenglishproficiency economicallydisadvantaged asian 			 ///   
		blackorafricanamerican hispanicorlatino americanindianoralaskannativ ///   
		white female male)(distnm partic1 partic2 partic3 partic4 partic5 	 ///   
		partic6 partic7 partic8 partic9 partic10 partic11)
		
		// Calls subroutine to standardize district names
		stddistnm

		// Normalize the data
		qui: reshape long partic, i(distnm) j(amo)
		
		// Define value labels for the AMO reporting groups
		la def amo 1 "All Students" 2 "Students w/Disabilities" 			 ///   
		3 "English Learners" 4 "Economically Disadvantaged" 5 "Asian" 		 ///   
		6 "Black or African American" 7 "Hispanic or Latino(a)"				 ///   
		8 "American Indian or Alaskan Native" 9 "White" 10 "Female" 11 "Male"
		
		// Recast data to numeric values with encoded missing values
		unmask
		
		// Create a subject area code
		qui: g byte sub = `i'
		
		// Define subject area value label
		la def sub 1 "Reading" 2 "Math" 3 "Science"
		
		// Apply value labels 
		la val amo amo
		la val sub sub
		
		// Create variable labels
		la var distnm "District Name" 
		la var amo "Annual Measurable Objective Subgroup"
		la var sub "Subject area"
		la var partic "Participation Rate"
		
		// Save a tempfile
		save `sub`i''.dta, replace
		
	} // End Loop over subject areas/sheets
	
	// Load the first worksheet
	qui: use `sub1'.dta, clear
	
	// Append the other two subject area worksheets
	qui: append using `sub2'.dta
	qui: append using `sub3'.dta
	
	// Make district names capitalized
	qui: replace distnm = proper(distnm)
	
	// Sort the data by district, subgroup, and subject area
	qui: sort distnm amo sub
	
	// Check for save option
	if `"`save'"' != "" qui: save `"`save'"', replace
	
// End subroutine for participation rate data
end	
	
// Drops subroutine from memory if already loaded
cap prog drop perfdata

// Defines subroutine for performance data handling
prog def perfdata

	// Version required
	version 13.1
	
	// Defines syntax used to call subroutine
	syntax using , [ SAve(string asis) ]
	
	// There's a small amount of cleaning needed to use the data
	// The reason for the cleaning is to make the data suitable for our use vs 
	// creating a publicly consumable file format
	// Load the school performance data
	import excel `using', sheet("District Performance") first 	 ///   
	case(l) clear

	// Rename variables (I prefer shorter variable names w/o underscores)
	rename (district officialgrade finalgrade wowaivergrade totalpoints 	 ///   
	participationrate growread growmath growreadlow25 growmathlow25 		 ///   
	proficiencyread proficiencymath proficiencyscience proficiencyhistory 	 ///   
	gradrate09cohort)(distnm offgrade fingrade wowaive totpts partic rlagro  ///   
	mthgro rlagrol mthgrol rlapro mthpro scipro hispro grad)

	// Create a school variable to identify district level observations
	qui: g schnm = "District Level"

	// Calls subroutine to standardize district names
	stddistnm

	// Reserve namespace for tempfiles
	tempfile schperf distgrad schgrad

	// preserve data in memory
	preserve

		// Load the school level data
		import excel `using', sheet("School Performance") first case(l) clear

		// We'll rename some of the variables to make the names less verbose
		rename (district school officialgrade finalgrade wowaivergrade 		 ///   
		totalpoints participationrate growread growmath growreadlow25  		 ///   
		growmathlow25 proficiencyread proficiencymath proficiencyscience  	 ///   
		proficiencyhistory gradrate09cohort)(distnm schnm offgrade fingrade  ///   
		wowaive totpts partic rlagro mthgro rlagrol mthgrol rlapro mthpro 	 ///   
		scipro hispro grad)

		// Calls subroutine to standardize district names
		stddistnm
		
		// Calls subroutine to standardize school names
		stdschnm

		// Verifies that district by school name is the primary key
		isid distnm schnm 
		
		// Save in a tempfile
		qui: save `schperf'.dta, replace
		
	// Restore data in memory and preserve it again
	restore, preserve

		// Load the school level data
		import excel `using', sheet("District Graduation Rates") first case(l) clear

		// Rename the variables to shorter names
		rename (district yeargraduationrate yearcompleterrate 				 ///   
		yeardropoutrate)(distnm gradrate comprate dropoutrate)
		
		// Add a school name variable
		qui: g schnm = cond(distnm != "* Mississippi", "District Level", 	 ///   
		"State Level")
		
		// Calls subroutine to standardize district names
		stddistnm

		// Save in a temp file
		qui: save `distgrad'.dta, replace
		
	// Restore data in memory and preserve it again
	restore, preserve

		// Load the school level data
		import excel `using', sheet("School Graduation Rates") first case(l) clear

		// Rename the variables to shorter names
		rename (district school yeargraduationrate yearcompleterrate 		 ///   
		yeardropoutrate) (distnm schnm gradrate comprate dropoutrate)
		
		// Calls subroutine to standardize district names
		stddistnm
		
		// Calls subroutine to standardize school names
		stdschnm

		// Append the district level graduation rates to the file
		append using `distgrad'.dta
		
		// Save in a temp file
		qui: save `schgrad'.dta, replace

	// Restore the data to memory
	restore

	// Union the school performance data
	append using `schperf'.dta

	// Join the graduation rate data
	merge 1:1 distnm schnm using `schgrad'.dta

	// Calls subroutine to recode data to numeric values
	unmask
	
	// Now we'll recode the grade values to numeric values
	qui: replace offgrade = cond(offgrade == "A", "5", 						 ///   
							cond(offgrade == "B", "4", 						 ///   
							cond(offgrade == "C", "3", 						 ///   
							cond(offgrade == "D", "2",					 	 ///   
							cond(offgrade == "F", "1", offgrade)))))

	// Define value labels (metadata) for the values
	la def offgrade .n "N/A" .e "Hold Harmless Waiver" .p "Pending" 		 ///   
					.s "< 10 Students" 1 "F" 2 "D" 3 "C" 4 "B" 5 "A"

	// Recast the grade variable to a numeric type
	destring offgrade, replace

	// Then apply the value labels
	la val offgrade offgrade

	// Store the variable label for the official grade in a macro so we can use it 
	// later:
	loc offgradelab `: var l offgrade'

	// We'll also modify the variable label a bit to make this version of the 
	// variable clearer to us
	la var offgrade `"`offgradelab' (Ordinal Scale Encoding)"'

	/* 
	Now we'll create a rank-based version of the same data
	Ordinal scales can be encoded as rank scales (assuming there aren't gaps in the 
	values) using:

			y = (1 + max(ordinal)) - ordinal

	In this case, the transformation will result in the grade A having a value of 1 
	and grade F having a value of 5. 

	You might also notice the use of the cond() function below.  Since "missing" 
	values in Stata are actually just reserved numeric ranges of values, we need to 
	apply the transformation only to cases where the data are not missing, and copy 
	the missing values verbatim.  Without using the cond() function, the missing 
	values would be coded as system missing values in the new variable.
	*/
	g offgraderank = cond(!mi(offgrade), 6 - offgrade, offgrade)

	// Copy the value label for the rank order variable
	la copy offgrade offgraderank

	// Now, we only need to modify the letter grades that have changed
	la def offgraderank 1 "A" 2 "B" 3 "C" 4 "D" 5 "F", modify

	// Then apply the value labels to the variable
	la val offgraderank offgraderank

	// And create a variable label
	la var offgraderank `"`offgradelab' (Rank Order Encoding)"'
	
	// Make the district names proper cased
	qui: replace distnm = proper(distnm)

	// Saves the data to disk if option is specified
	if `"`save'"' != "" save `"`save'"', replace
	
// End sub routine for performance data
end 

// Drops subroutine if already loaded in memory
cap prog drop unmask

// Defines the unmask subroutine
prog def unmask

	// Version of Stata required
	version 13.1
	
	// Get the list of all variables in the data set
	qui: ds, has(type string)

	// Now remove all of the text values that are best represented in Stata as 
	// extended missing values
	foreach v in `r(varlist)' {

		// Replace the N/A values with the .n extended missing value
		// Replace the P values (Pending) with the .p extended missing value
		// Replace the E values (Excellence for All Waiver Exemption) with .e 
		// Replace the <10 Students with the .s extended missing value
		qui: replace `v' = cond(`v' == "N/A", ".n", cond(`v' == "P", ".p", 	 	 ///   
						   cond(`v' == "E", ".e", cond(`v' == "<10 Students", ".s", `v'))))

		// Recast the data to numeric types without information loss
		qui: destring `v', replace

	} // End Loop over variables

// End of subroutine
end


// Drops program from memory if already loaded
cap prog drop stddistnm

// Defines subroutine to standardize district names
prog def stddistnm

	// Version of Stata required/ how source will be interpreted
	version 13.1
	
	// Standardize district names by making them all lower case
	qui: replace distnm = lower(distnm)

	// Remove equivalent of "stop words"
	qui: replace distnm = regexr(distnm, 									 ///   
	"(sch.*)|(dist.*)|(consol.*)|(munic.*)|(public.*)|(sep.*)|(sp mun.*)|(city.*)", "")

	// Standardize agricultural HS names
	qui: replace distnm = trim(itrim(regexr(distnm, "ag high", "ahs")))

// Ends subroutine
end


// Drops subroutine for school names from memory if previously loaded
cap prog drop stdschnm

// Defines subroutine for cleaning school names
prog def stdschnm

	// Version of Stata required
	version 13.1

	// Makes School names lower cased
	qui: replace schnm = lower(schnm)

	// Removes periods from school names
	qui: replace schnm = subinstr(schnm, ".", " ", .)
	
	// Removes "stop words"/grade range IDs that appear in school names
	qui: replace schnm = regexr(schnm,										 ///   
	"( \(+.*\)+[ ]?\$)|(sch.*)|(dist )|(district )|(acad.*)|(&)|( school.*)", "")
	
	// Substitutes spaces for hyphens or slashes
	qui: replace schnm = regexr(schnm, "([-/]+)", " ")
	
	// Standardizes use of county
	qui: replace schnm = regexr(schnm, "( county)", " co")

	// Standardizes references to agricultural high schools
	qui: replace schnm = regexr(schnm, "( agricul.*)", " ahs")
	
	// Standardizes references to Jr/Sr High Schools
	qui: replace schnm = regexr(schnm, "( jr sr.*)", " jshs")
	
	// Standardizes references to Jr High Schools
	qui: replace schnm = regexr(schnm, "( j.*r hi.*)", " jhs")
	
	// Standardizes references to Middle Schools
	qui: replace schnm = regexr(schnm, "( middle.*)", " ms")
	
	// Standardizes references to Elementary Schools
	qui: replace schnm = regexr(schnm, "( elem.*)", " es")
	
	// Standardizes references to Intermediate Schools
	qui: replace schnm = regexr(schnm, "( intermediate.*)", " int")
	
	// Standardizes references to Primary Schools
	qui: replace schnm = regexr(schnm, "( primary.*)", " prim")
	
	// Standardizes references to High Schools
	qui: replace schnm = regexr(schnm,										 ///   
	"( senior.*)|( hi[ ]?\$)|( high[ ]?\$)|( secondary.*)", " hs")

	// Removes erroneous white space and applies title/proper casing
	qui: replace schnm = proper(trim(itrim(schnm)))
	
	// Makes School Type identifiers appear in all capital letters
	qui: replace schnm = regexs(1) + upper(regexs(2)) if regexm(schnm,	 	 ///   
								"(.* )((Ahs)|(Hs)|(Ms)|(Es)|(Jhs)|(Ac)|(Jshs))")
	
// End of sub routine
end

