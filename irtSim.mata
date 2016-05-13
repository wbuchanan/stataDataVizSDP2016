// Starts mata interpreter
mata:

/* Defines function used to simulate item response data for binary scored items
Allows users to pass the mean and SD for theta, number of observations, and 
requires at least a value for the alpha parameter be specified.  
If a single value for alpha is passed the vector will be scaled using the number 
of items, and if multiple values for alpha are passed they will be used to set 
the number of items (if the parameter is missing).  There are also parameters 
available to specify the beta, pseudo-guessing parameters, and the scaling 
factor. */
real matrix irtBinProb(real scalar mutheta, real scalar sigtheta, 			 ///   
				   real scalar nobs, real matrix beta, | real matrix alpha,  ///   
				   real matrix pseudog,	 real scalar items, real scalar D) {

	// If only 1 value passed for alpha and the number of items is non-missing
	if (rows(beta) == 1 & cols(beta) == 1 & !missing(items)) {
	
		// Create a row vector with random values in [0, 1] for alpha
		beta = J(1, items, runiform(1, 1, 0, 1))
		
	} // End IF Block 
	
	// If the number of items isn't specified set value based on number of alpha 
	// parameter values
	if (cols(beta) != 1 & missing(items) == 1) items = cols(beta)
	
	// If beta is missing set the value to 0 for all items
	if ((rows(alpha) == 0 & cols(alpha) == 0) | missing(alpha) == 1) alpha = J(1, items, 1)
	
	else if (rows(alpha) == 1 & cols(alpha) == 1) alpha = J(1, items, alpha[1, 1])
	
	// If the pseudo guessing parameter is missing set a value of 0 for all items
	if ((rows(pseudog) == 0 & cols(pseudog) == 0) | missing(pseudog) == 1) pseudog =  J(1, items, 0)

	else if (rows(pseudog) == 1 & cols(pseudog) == 1) pseudog = J(1, items, pseudog[1, 1])
		
	// If no scaling parameter specified use -1.701
	if (missing(D) == 1) D = 1.701
	
	// Decare function variables
	real matrix theta, probs
	
	// Used for iteration in loops below
	real scalar i, j
		
	// Creates a column vector of theta values
	theta = rnormal(nobs, 1, mutheta, sigtheta)
	
	// Initializes a null matrix where the probabilities will be saved
	probs = J(nobs, items, .)
	
	// Start loop over observations
	for(i = 1; i <= nobs; i++) {
	
		// Start loop over items
		for(j = 1; j <= items; j++) {
		
			// Estimate the probability of a keyed response for the ith subject 
			// responding to the jth item:
			//						   (exp(1.701 * a(theta - b))) 
			// P(1) = c + (1 - c) 	---------------------------------
			//						(1 + exp(1.701 * a(theta - b))) 
			probs[i, j] = pseudog[1, j] + (1 - pseudog[1, j]) *				 /// 
						 exp(D * alpha[1, j] * (theta[i, 1] - beta[1, j])) / ///
						 (1 + exp(D * alpha[1, j] * (theta[i, 1] - beta[1, j])))
	
		} // End Loop over items
	
	} // End Loop over observations
	
	// Returns the matrix with the values of theta in [n, 1] of the matrix
	return((theta, probs))
	
} // End Function definition

/* Defines a function used to generate the keyed item responses given a column 
vector of theta parameters and an [n, m] matrix of item response probabilities. */  
real matrix irtBinKey(real matrix theta, real matrix probabilities, | 		 ///   
					  real scalar toStata) {

	// Declares a matrix to store the keyed responses				  
	real matrix keyedResponses
	
	// Estimates keyed response using the probabilities from a binomial distribution
	keyedResponses = rbinomial(1, 1, 1, probabilities)
	
	// If the toStata parameter gets an argument
	if (!missing(toStata) == 1) {
	
		// Declare a scalar to use for iteration
		real scalar i
		
		// Set the number of observations in the data set
		st_addobs(rows(theta))
		
		// Add a double variable for the value of theta
		st_addvar("double", "theta")
		
		// Add a long variable for the total score (unlikely to use this much 
		// storage, but is still "possible")
		st_addvar("long", "total")
		
		// Loop over the number of columns of item probabilities
		for(i = 1; i <= cols(probabilities); i++) {
		
			// Add a byte variable for each item
			st_addvar("byte", "item" + strofreal(i))
			
		} // End Loop over the item probabilities
		
		// Loads the data into Stata
		st_store(., ., (theta, (rowsum(keyedResponses)), keyedResponses))
		
	} // End IF Block for condition where data are loaded directly into Stata
	
	// Returns the matrix of data
	return((theta, (rowsum(keyedResponses)), keyedResponses))

} // End of Function declaration

// End of Mata 
end	
