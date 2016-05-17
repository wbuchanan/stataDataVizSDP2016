cap prog drop schsim

prog def schsim

	version 12
	
	syntax , DISTricts(integer) DISTEFFect(numlist min=2 max=2) 			 ///   
	AVGSCore(numlist min=2 max=2) ASIan(numlist min=2 max=2) 				 ///   
	BLack(numlist min=2 max=2) HISPanic(numlist min=2 max=2) 				 ///   
	NATAMer(numlist min=2 max=2) WHIte(numlist min=2 max=2) 				 ///   
	sex(numlist min=2 max=2) SPed(numlist min=2 max=2) 						 ///   
	ELl(numlist min=2 max=2) MASTers(numlist min=2 max=2) 					 ///   
	LATEHire(numlist min=2 max=2) ALTCert(numlist min=2 max=2) 				 ///   
	hq(numlist min=2 max=2) frl(numlist min=2 max=2) 						 ///   
	CHARTer(numlist min=2 max=2) [ SCHools(numlist min=2 max=2 sort) 		 ///   
	EDUCators(numlist min=2 max=2 sort) STUDents(numlist min=2 max=2 sort) 	 ///   
	YEArs(integer 2) ATTRition(real 0.175) TIME(numlist min=2 max=2) 		 ///   
	STEFFect(numlist min=2 max=2) EDEFFect(numlist min=2 max=2) 			 ///   
	SCHEFFect(numlist min=2 max=2) seed(integer -1) ] 
	
	if `seed' != -1 set seed `seed'
	
	// Check for egen more package
	cap which _gxtile
	
	// If not installed install it
	if _rc != 0 qui: ssc inst egenmore
	
	// Parse ethnoracial parameters
	loc asian_pop `: word 1 of `asian''
	loc black_pop `: word 1 of `black''
	loc hisp_pop `: word 1 of `hispanic''
	loc natam_pop `: word 1 of `natamer''
	loc white_pop `: word 1 of `white''
	loc sex_pop `: word 1 of `sex''
	loc sped_pop `: word 1 of `sped''
	loc ell_pop `: word 1 of `ell''
	loc frl_pop `: word 1 of `frl''
	
	// Tests to make sure the proportions sum to 1
	if `asian_pop' + `black_pop' + `hisp_pop' + `natam_pop' + `white_pop' != 1 {
		
		// If not tell user
		di as err "The ethnoracial proportions do not sum to 1."
		
		// Throw error code
		err 198
		
	} // End IF Block
	
	// Or
	else {
	
		// Create threshold locals to be used later
		loc asian_min = 0
		loc asian_max = `asian_pop'
		loc black_min = `asian_max'
		loc black_max = `asian_max' + `black_pop'
		loc hisp_min = `black_max'
		loc hisp_max = `black_max' + `hisp_pop'
		loc natam_min = `hisp_max'
		loc natam_max = `hisp_max' + `natam_pop'
		loc white_min = `natam_max'
		loc white_max = 1
		
	}
	
	// Parsing student level covariate coefficients
	loc asian_coef `: word 2 of `asian''
	loc black_coef `: word 2 of `black''
	loc hisp_coef `: word 2 of `hispanic''
	loc natam_coef `: word 2 of `natamer''
	loc white_coef `: word 2 of `white''
	loc sex_coef `: word 2 of `sex''
	loc sped_coef `: word 2 of `sped''
	loc ell_coef `: word 2 of `ell''
	loc frl_coef `: word 2 of `frl''

	// Parsing educator level covariate coefficients
	loc mast_pop `: word 1 of `masters''
	loc mast_coef `: word 2 of `masters''
	loc late_pop `: word 1 of `latehire''
	loc late_coef `: word 2 of `latehire''
	loc alt_pop `: word 1 of `altcert''
	loc alt_coef `: word 2 of `altcert''
	loc hq_pop `: word 1 of `hq''
	loc hq_coef `: word 2 of `hq''

	// School level variable and coefficient
	loc charter_pop `: word 1 of `charter''
	loc charter_coef `: word 2 of `charter''
	
	// Parameters used to simulate the grand mean
	loc scoremu `: word 1 of `avgscore''
	loc scoresig `: word 2 of `avgscore''
	
	// Clear data from memory
	clear
	
	// Set the number of districts
	qui: set obs `districts'
	
	// Get the lower bound for number of schools
	loc sch1 `: word 1 of `schools''
	
	// Get the lower bound for number of educators
	loc edu1 `: word 1 of `educators''
	
	// Get the lower bound for number of educators
	loc std1 `: word 1 of `students''
	
	// If user specifies upper bound for schools
	if `: word 2 of `schools'' != . loc sch2 `: word 2 of `schools''
	
	// Else default sampling
	else loc sch2 `= 10 + int((50 - 10 + 1) * runiform())'
	
	// If user specifies upper bound for educators
	if `: word 2 of `educators'' != . loc edu2 `: word 2 of `educators''
	
	// Else default sampling
	else loc edu2 `= 15 + int((43 - 15 + 1) * runiform())'

	// If user specifies upper bound for students
	if `: word 2 of `students'' != . loc std2 `: word 2 of `students''
	
	// Else default sampling
	else loc std2 `= 16 + int((35 - 16 + 1) * runiform())'

	// Make sure the upper bound for schools is greater than the lower bound
	if `sch2' < `sch1' loc sch2 = `sch2' + `sch1'

	// Make sure the upper bound for educators is greater than the lower bound
	if `edu2' < `edu1' loc edu2 = `edu2' + `edu1'

	// Make sure the upper bound for students is greater than the lower bound
	if `std2' < `std1' loc std2 = `std2' + `std1'
	
	/* Parse Mean of Effects */
	loc dmu `: word 1 of `disteffect''
	loc smu `: word 1 of `scheffect''
	loc emu `: word 1 of `edeffect''
	loc imu `: word 1 of `steffect''
	loc tmu `: word 1 of `time''

	/* Parse Variance of Effects */
	if `: word 2 of `disteffect'' != . loc dsig `: word 2 of `disteffect''
	else loc dsig `= 5 * runiform()'
	if `: word 2 of `scheffect'' != . loc ssig `: word 2 of `scheffect''
	else loc ssig `= 7.5 * runiform()'
	if `: word 2 of `edeffect'' != . loc esig `: word 2 of `edeffect''
	else loc esig `= 12 * runiform()'
	if `: word 2 of `steffect'' != . loc isig `: word 2 of `steffect''
	else loc isig `= 25 * runiform()'
	if `: word 2 of `time'' != . loc tsig `: word 2 of `time''
	else loc tsig `= 2.5 * runiform()'
	
	// Creates a district ID
	qui: g byte distid = _n
	
	// District level random effect
	qui: g u_ijkl = rnormal(`dmu', `dsig')
	
	// The number of years data will be generated for
	qui: g years = `years'
	
	// The number of schools within districts
	qui: g nsch = `sch1' + int((`sch2' - `sch1' + 1) * runiform())
	
	// Expands to school level records
	qui: expandcl nsch, gen(schid) cl(distid)
	
	// School level random effect
	qui: g u_ijk = rnormal(`smu', `ssig') 
	
	// Creates school type indicator
	qui: g charter = rbinomial(1, `charter_pop')
	
	// Number of educators within schools
	qui: g nedu = `edu1' + int((`edu2' - `edu1' + 1) * runiform())
	
	// Expands to teacher level observations
	qui: expandcl nedu, gen(tchid) cl(distid schid)
	
	// Teacher level random effect
	qui: g u_ij = rnormal(`emu', `esig')
	
	// Creates indicator for whether or not educator has a masters or higher
	qui: g byte masters = rbinomial(1, `mast_pop')
	
	// Creates indicator for whether or not educator was hired late or not
	qui: g byte latehire = rbinomial(1, `late_pop')
	
	// Creates indicator if certification was from alternate certification program
	qui: g byte altcert = rbinomial(1, `alt_pop')
	
	// Creates indicator for highly qualified status
	qui: g byte highlyqual = rbinomial(1, `hq_pop')
	
	// Number of students in each teacher's class
	qui: g nstd = `std1' + int((`std2' - `std1' + 1) * runiform())
	
	// Expands to student level data
	qui: expandcl nstd, gen(stdid) cl(distid schid tchid)
	
	// Student level random effect
	qui: g u_i = rnormal(`imu', `isig')
	
	// Creates a student sex indicator
	qui: g byte sex = rbinomial(1, `sex_pop')
	
	// Creates a special education indicator
	qui: g byte sped = rbinomial(1, `sped_pop')
	
	// Creates an ELL indicator
	qui: g byte ell = rbinomial(1, `ell_pop')
	
	// Creates an FRL indicator
	qui: g byte frl = rbinomial(1, `frl_pop')
	
	// Creates a random uniform variable for race which will be used to get 
	// the correct proportion of students for each race
	qui: g race = runiform()
	
	// Categorizes the random uniform variable to get the correct proportions
	qui: replace race = cond(inrange(race, `asian_min', `asian_max'), 1,	 ///   
						cond(inrange(race, `black_min', `black_max'), 2, 	 ///   
						cond(inrange(race, `hisp_min', `hisp_max'), 3,		 ///   
						cond(inrange(race, `natam_min', `natam_max'), 4, 5))))
						
	// Defines a value label set for ethnoracial identity
	la def race 1 "Asian" 2 "Black or African American" 					 ///   
				3 "Hispanic/Latino(a)" 4 "First Nations" 5 "White"
	
	// Defines sex value labels
	la def sex 0 "Male" 1 "Female"
	
	// Defines special ed value labels
	la def sped 0 "Students w/o Disabilities" 1 "Students w/Disabilities"
	
	// Defines ell value labels
	la def ell 0 "Native English Speaker" 1 "English Learner"
	
	// Defines frl value labels
	la def frl 0 "Full-Price Lunch" 1 "Free/Reduced Price Lunch Eligible"
	
	// Value labels for charter school indicator
	la def charter 0 "Traditional School" 1 "Charter School"

	// value labels for educator degree
	la def masters 0 "Does not have a Masters or Higher" 1 "Has a Masters Degree or Higher"

	// value labels for educator hiring
	la def latehire 0 "Not a Late Hire" 1 "Hired Late"

	// value label for alternative certification
	la def altcert 0 "Traditional Certification" 1 "Alternative Certification"
	
	// value label for highly qualified status
	la def highlyqual 0 "Not Highly Qualified" 1 "Highly Qualified"

	// Applies value labels to the ethnoracial ID variable
	foreach v of var race sex sped ell frl masters latehire altcert 		 ///   
	highlyqual charter {
	
		// Applies value labels to variables
		la val `v' `v'
		
	} // End Loop
	
	// Adds a variable label to the variable
	la var race "Student Ethnoracial Identity"
	
	// Expands student level observations for years number of years
	qui: expandcl years, gen(stdyr) cl(distid schid tchid stdid)
	
	// Creates time random effect
	qui: g u_t = rnormal(`tmu', `tsig')
	
	// Creates variables that contain the various effects specified by the 
	// user
	qui: g race_effect = cond(race == 1, `asian_coef', 						 ///   
						 cond(race == 2, `black_coef',						 ///   
						 cond(race == 3, `hisp_coef',						 ///   
						 cond(race == 4, `natam_coef', `white_coef'))))	
	qui: g sex_effect = sex * `sex_coef'
	qui: g sped_effect = sped * `sped_coef'
	qui: g ell_effect = ell * `ell_coef'
	qui: g frl_effect = frl * `frl_coef'
	qui: g masters_effect = masters * `mast_coef'
	qui: g latehire_effect = latehire * `late_coef'
	qui: g altcert_effect = altcert * `alt_coef'
	qui: g highlyqual_effect = highlyqual * `hq_coef'
	qui: g charter_effect = charter * `charter_coef'
	
	// Creates a school year variable
	qui: bys stdid: g int schyr = 2005 + _n
	
	// Creates centered school year variable
	qui: bys stdid: g byte centyear = schyr - 2006
	
	// Apply attrition rate for students
	qui: bys schyr: g double todrop = runiform()
	
	// Change the sort order
	qui: sort todrop
	
	// replace the random uniform variable
	qui: replace todrop = runiform()
	
	// Drop records below the attrition threshold
	qui: drop if todrop <= `attrition'
	
	// Create a district size indicator
	qui: bys distid schyr: g distsize = _N
	
	// Create a school size indicator
	qui: bys distid schid schyr: g schsize = _N
	
	// Create a class size indicator
	qui: bys distid schid tchid schyr: g clsize = _N
	
	// District level demographic aggregates
	qui: bys distid schyr: egen distpctmasters = mean(masters)
	qui: bys distid schyr: egen distpctlate = mean(latehire)
	qui: bys distid schyr: egen distpctaltcert = mean(altcert)
	qui: bys distid schyr: egen distpcthq = mean(highlyqual)
	qui: bys distid schyr: egen distpctcharter = mean(charter)
	qui: bys distid schyr: egen distpctsped = mean(sped)
	qui: bys distid schyr: egen distpctell = mean(ell)
	qui: bys distid schyr: egen distpctfrl = mean(frl)

	// School level demographic aggregates
	qui: bys distid schid schyr: egen schpctmasters = mean(masters)
	qui: bys distid schid schyr: egen schpctlate = mean(latehire)
	qui: bys distid schid schyr: egen schpctaltcert = mean(altcert)
	qui: bys distid schid schyr: egen schpcthq = mean(highlyqual)
	qui: bys distid schid schyr: egen schpctsped = mean(sped)
	qui: bys distid schid schyr: egen schpctell = mean(ell)
	qui: bys distid schid schyr: egen schpctfrl = mean(frl)

	// Class level demographic aggregates
	qui: bys distid schid tchid schyr: egen clspctsped = mean(sped)
	qui: bys distid schid tchid schyr: egen clspctell = mean(ell)
	qui: bys distid schid tchid schyr: egen clspctfrl = mean(frl)
	
	loc races asian black hisp natam white
	qui: ta race, gen(r)
	forv i = 1/5 {
		
		loc proplab `: di proper("`: word `i' of `races''")'
		loc rvar `: word `i' of `races''
		qui: bys distid schyr: egen distpct`rvar' = mean(r`i')
		qui: bys distid schid schyr: egen schpct`rvar' = mean(r`i')
		qui: bys distid schid tchid schyr: egen clspct`rvar' = mean(r`i')
		la var distpct`rvar' "District % `proplab' Students"
		la var schpct`rvar' "School % `proplab' Students"
		la var clspct`rvar' "Class % `proplab' Students"
		
	}
	
	qui: xtset stdid schyr
	
	// Generate average score variable
	qui: g score = rnormal(`scoremu', `scoresig')
	
	qui: g tempscore1 = 0.1 * L1.score
	qui: g tempscore2 = 0.075 * L2.score
	qui: replace tempscore1 = 0 if mi(tempscore1)
	qui: replace tempscore2 = 0 if mi(tempscore2)
	
	// Create final score variable
	qui: g testscore = score + race_effect + sped_effect + ell_effect + 	 ///   
	frl_effect + masters_effect + latehire_effect + altcert_effect + 		 ///   
	highlyqual_effect + charter_effect + u_t + u_i + u_ijkl + u_ijk + u_ij + ///   
	tempscore1 + tempscore2 + 0.02 * distpctsped +							 ///   
	0.01 * distpctell + 0.125 * distpctfrl + 0.05 * schpctsped +			 /// 
	0.0275 * schpctell + 0.275 * schpctfrl + 0.33 * clspctsped +			 ///   
	0.175 * clspctell + 0.75 * clspctfrl + 0.175 * schpctmasters +			 ///   
	0.001 * schpcthq + (-0.15 * schpctaltcert) + (-0.25 * schpctlate) +		 ///   
	(-0.1 * distpctcharter) * (-0.375 * distpctaltcert) +					 ///   
	(-0.475 * distpctlate) + 0.0025 * distpctmasters + 0.0001 * distpcthq
	
	qui: egen nce = xtile(testscore), n(100) by(schyr)
	qui: egen distpctile = xtile(testscore), n(100) by(distid schyr)
	
	// Define proficiency level variable
	qui: g proflevel = 	cond(inrange(nce, 0, 27), 1,						 ///   
						cond(inrange(nce, 28, 53), 2, 						 ///   
						cond(inrange(nce, 54, 81), 3, 4)))
		
	la def proflevel 1 "Minimal" 2 "Basic" 3 "Proficient" 4 "Advanced"
	
	la val proflevel proflevel
	
	qui: bys distid schyr: egen distavg = mean(testscore)
	qui: bys distid schid schyr: egen schavg = mean(testscore)
	qui: bys distid schid tchid schyr: egen clsavg = mean(testscore)
	
	la var distpctmasters "Districtwide % Educators with Masters degree or higher"
	la var distpctlate "Districtwide % Educators Hired Late"
	la var distpctaltcert "Districtwide % Educators with Alternative Certifications"
	la var distpcthq "Districtwide % Educators Meeting Title II Highly Qualified Status"
	la var schpctmasters "Schoolwide % Educators with Masters degree or higher"
	la var schpctlate "Schoolwide % Educators Hired Late"
	la var schpctaltcert "Schoolwide % Educators with Alternative Certifications"
	la var schpcthq "Schoolwide % Educators Meeting Title II Highly Qualified Status"
	la var distpctcharter "Districtwide % of Schools that are Charter Schools"
	la var proflevel "Proficiency Level"
	la var nce "Normal Curve Equivalent"
	la var distpctile "Within district percentile score"
	
	loc lev District School Class
	loc pref dist sch cls
	loc suff sped ell frl
	loc suflab "Students with Disabilities" "English Learners" "Free/Reduced Price Lunch Eligible"

	forv i = 1/3  {
		
		loc levlab `: word `i' of `lev''
		loc varstart `: word `i' of `pref''
		la var `varstart'avg "`levlab' Average Score"
	
		forv j = 1/3 {
	
			loc subgr `: word `j' of `suflab''
			loc varend `: word `j' of `suff''
			la var `varstart'pct`varend' `"`levlab' % `subgr'"'
			
		}
		
	}
	
	// Labels the variables
	la var race "Student ethnoracial identity"
	la var sex "Student sex"
	la var sped "Students with disabilities indicator"
	la var ell "English learner indicator"
	la var frl "Lunch status indicator"
	la var charter "Charter school indicator"
	la var masters "Highest degree obtained by educator"
	la var latehire "Was educator hired after school began?"
	la var altcert "Teaching certificate obtained via alternate program"
	la var highlyqual "Educator satisfies highly qualified criteria of Title II"
	la var distid "District ID"
	la var schid "School ID"
	la var tchid "Teacher ID"
	la var stdid "Student ID"
	la var schyr "Academic Year Ending"
	la var testscore "Test score"
	la var centyear "School year centered on 2006"
	la var distsize "Number of students in the district within year"
	la var schsize "Number of students in the school within year"
	la var clsize "Number of students in the class room within year"
	
	// Drops unneeded variables
	qui: drop score *effect u_* years stdyr nstd nedu nsch todrop r1 r2 r3 	 ///   
	r4 r5 tempscore1 tempscore2
	
	// Sets the display order of the data
	order distid schid charter tchid masters latehire altcert highlyqual 	 ///   
	stdid schyr centyear race sex sped ell frl testscore
	
end

	
	
