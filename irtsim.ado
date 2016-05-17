/*******************************************************************************
*                                                                              *
* Description -                                                                *
*       Wrapper around Mata code used to simulate item response data for SDP   *
*       convening session.                                                     *
*                                                                              *
* Returns - Copies of the matrices of probabilities of a keyed response and    *
*           the matrix containing theta, sum score, and keyed responses.       *
*                                                                              *
*******************************************************************************/

*! irtsim
*! 13may2016
*! v 0.0.1

// Defines program to do quick simulation of IRT data for visualization purposes
cap prog drop irtsim

// Defines command to simulate item responses 
prog def irtsim, rclass

	// Minimum version of Stata required
	version 12
	
	// Defines syntax for calling/using program
	syntax, THeta(numlist min=2 max=2) NOBservations(real) 					 ///   
			DIFFiculty(numlist min = 1) [ DISCRIMination(numlist min = 1)	 ///   
			PSEUDOGuessing(numlist min = 1) NITems(real -1) 				 ///   
			SCALEFactor(real -1.701) DEVmode ]
			
	// Clears any existing returned results		
	ret clear		
	
	// Get mean theta
	loc mutheta `: word 1 of `theta''

	// Get SD of theta
	loc sigtheta `: word 2 of `theta''
			
	// Drop the mata functions if already loaded		
	cap mata: mata drop irtBinProb()
	cap mata: mata drop irtBinKey()
	
	// If development mode not triggered will search for the mata file on the path
	if `"`devmode'"' == "" {
	
		// Locate and run the Mata source
		cap findfile irtSim.mata
		cap run `"`r(fn)'"'
	
	} // End IF Block for development mode
	
	// For local development only
	else cap run ./irtSim.mata
	
	// If the number of items is set at the default count the number of alpha 
	// parameter values
	if `nitems' == -1 loc nitems `: word count `difficulty''
			
	// Creates formatted string that will be interpreted as a rowvector of reals
	loc beta "(`: subinstr loc difficulty `" "' `", "', all')"	
	
	// If the same number of discrimination parameter values as items are passed
	if `"`discrimination'"' != "" & 										 ///   
						(`: word count `discrimination'' == `nitems' | 		 ///   
						`: word count `discrimination'' == 1) {
						
		// Parses and formats the beta parameters				
		loc alpha "(`: subinstr loc discrimination `" "' `", "', all')"
		
	} // End of IF block for beta parameter
	
	// If no discrimination, set the value of the local beta to missing
	else loc alpha .
	
	// If same number of pseudo guessing parameter values as items are passed
	if `"`pseudoguessing'"' != "" &											 ///   
						(`: word count `pseudoguessing'' == `nitems' | 		 ///   
						`: word count `pseudoguessing'' == 1) {
						
		// Parses and formats the c parameters				
		loc pseudog "(`: subinstr loc pseudoguessing `" "' `", "', all')"
		
	} // End IF Block for pseudo guessing parameter values
	
	// If no pseudo guessing, set the value of the local pseudog to missing
	else loc pseudog .
	
	clear
	
	// Calls Mata function that simulates the item response probabilities
	qui: mata: probs = irtBinProb(`mutheta', `sigtheta', `nobservations', 	 ///   
							`beta', `alpha', `pseudog', `nitems', `scalefactor')
	
	// Calls the Mata function that estimates the keyed responses from the 
	// probabilities
	qui: mata: resp = irtBinKey(probs[., 1], probs[., 2..`= `nitems' + 1'], 1)
	
	mata: st_matrix("itemprob", probs)
	mata: st_matrix("itemresp", resp)
	
	ret mat probabilities = itemprob
	ret mat responses = itemresp
	
end
