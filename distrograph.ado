/*******************************************************************************
*                                                                              *
* Description -                                                                *
*       Essentially a wrapper around the histogram command with options to add *
*       arbitrary reference lines based on standard deviation units from the   *
*       mean of the distribution.                                              *
*                                                                              *
* Returns - Scalars containing the mean/standard deviation of the variable     *
*           1 Scalar with the value of each reference line named linelocation# *
*                                                                              *
*******************************************************************************/

*! distrograph
*! 13may2016
*! v 0.0.1

// Drops the program from memory if already loaded
cap prog drop distrograph

// Tells Stata we're about to define a program
prog def distrograph, rclass

	// Minimum version required.  The session participant who mentioned this in 
	// the survey indicated they work on version 12 so this was a way to make 
	// sure they could take something away from session directly
	version 12
	
	// Defines the syntax used to call the program
	syntax varname(numeric) [if] [in] [fw] [, DIScrete Bin(passthru) 		 ///   
	STart(passthru)	Width(passthru) DENsity FRACtion FREQuency PERcent 		 ///   
	KDENsity NORMal	ADDLabels BARWidth(passthru) HORizontal 				 ///   
	REFLINes(numlist sort) * ]
	
	// Puts the weight option back together again if specified
	if `"`weight'"' != "" loc theweight [`weight' `exp']
	
	// Or creates a blank macro
	else loc theweight 
	
	// Handles if/in option by creating a new tempvar/expression that you name
	// nearly everyone uses the name touse for this purpose
	marksample touse
	
	// Get the summary stats for the variable with all the necessary options
	qui: su `varlist' if `touse' `theweight'
	
	// Stores the mean in the local macro named mid
	loc mid `= r(mean)'
	
	// Stores the standard deviations in the local macro named unit
	loc unit `= r(sd)'
	
	// Returns the mean of the distribution
	ret sca mean = `mid'
	
	// Returns the standard deviation of the distribution
	ret sca sd = `unit'

	// If the horizontal option is used
	if `"`horizontal'"' != "" {
	
		// The reference lines will all by ylines
		loc lt yline
		
		// Need to add a second yaxis
		loc axisopts yaxis(1 2) ysca(noline axis(2)) ytic(, noticks axis(2)) ///   
		ymtick(, noticks axis(2)) 
		
		// And need for format the reference for the labels on that axis
		loc extlab ylabel

		// Local that gets rid of the axis title on the added axis
		loc extti yti("", axis(2))		
		
	} // End IF Block for horizontal case
	
	// If the option is not specified
	else {
	
		// Extra lines will be vertical (e.g., from the x-axis)
		loc lt xline
		
		// To add the additional axis as an xaxis
		loc axisopts xaxis(1 2) xsca(noline axis(2)) xtic(, noticks axis(2)) ///   
		xmtick(, noticks axis(2)) 
		
		// Reference where the axis labels will be placed
		loc extlab xlabel

		// Local that gets rid of the axis title on the added axis
		loc extti xti("", axis(2))
		
	} // End ELSE Block for vertical case
	
	// Loops over each of the reference line values passed by the user
	forv i = 1/`: word count `reflines'' {
	
		// Gets the individual value of interest
		loc dist `: word `i' of `reflines''
		
		// Location = Mean + (# * SD) this macro stores that value
		loc linelocation `= `mid' + `= `unit' * `dist'''
		
		// The value is also returned to the user as a scalar with the name 
		// linelocation#
		ret sca linelocation`i' = `linelocation'

		// This constructs the labels.  They are two lines long with the number 
		// of units in SD from the mean on the first line and the value at 
		// that point on the second line
		loc labels `labels' `linelocation' `""`dist' SD" "(`: di %5.3f `linelocation'')""' 
		
		// Constructs the reference lines themselves
		loc distlines `distlines' `lt'(`linelocation', axis(1)) 
		
	} // End of the loop
	
	// Now calls the histogram command with all the available options and adds 
	// the references lines we wanted to see
	qui: histogram `varlist' if `touse' `theweight', `discrete' `start'		 ///   
	`width' `density' `fraction' `frequency' `percent' `kdensity' `normal'   ///   
	`addlabels' `barwidth' `horizontal' `options' `axisopts' `extti' `bin'   ///   
	`extlab'(`labels', axis(2)) `distlines' 
	
// End of program definition	
end
	
	
