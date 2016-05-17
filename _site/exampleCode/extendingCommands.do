/* 
Sometimes the functionality exists, but it can be a pain to code what we want 
each time.  If, for example, there is a single modification we want to make to 
an existing program, we can create a "wrapper" program.  This basically means 
that our command would wrap all of the code needed to call the existing command 
with the correct options specified.  

For example, one of the responses to the pre-work survey contained a really 
good request for this type of approach:

	I'd like to create a distribution graph overlaid with markers at -2 [SD], 
	-1 [SD] +1 [SD] and +2 [SD], along with a data label that gives the value at 
	each of those markers.

So the existing command would likely be 'histogram'.  However, instead of 
hardcoding the values for -2, -1, 1, and 2 standard deviations from the mean 
into the wrapper, we could make this a bit more generalizable.  To do this, I 
add what amounts to a single option for calling histogram that gets used to 
compute values that are # SD units from the mean.  So if you wanted 6, 2, or 37 
reference lines, the same bit of code should work. */

// Load the performance data
msas using msas.xlsx, perf

// Create a distribution plot of graduation rates with the references mentioned 
// in the request above:
distrograph gradrate if schnm != "District Level", reflin(-2 -1 1 2)

// Save a copy of the graph created with the default scheme
gr export exampleGraphs/distroGraphEx1.pdf, as(pdf) replace

// Like the other graphs, we can also pass a scheme file to the command
distrograph gradrate if schnm != "District Level", reflin(-2 -1 1 2) scheme(sdp2016a)

// Save a copy of the graph created with the default scheme
gr export exampleGraphs/distroGraphEx2.pdf, as(pdf) replace
