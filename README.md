# Becoming a Better Data Communicator: Stata Data Visualization
This repository contains materials for the _Becoming a Better Data Communicator: Stata Data Visualization_ session at the [Strategic Data Project's 2016 Spring Convening](http://sdp.cepr.harvard.edu/event/beyond-numbers-convening).  Additionally, if there are resources you think others may find helpful, please feel free to share them here as well via `pull` requests.  

# Getting the resources locally
In addition to the Stata package installer that would allow you to install all of the Stata example scripts and programs created for this session, you can also use [Git](http://www.git-scm.com) to create a copy of all the materials here to your computer.  

In addition to getting all of the other files (e.g., the .pdfs, etc...) using [Git](http://git-scm.com) has significant advantages.  For example, if you're using any *nix-based system you can copy all of the material by opening a terminal (Terminal.app for OSX users) and entering :

```
cd  ~/Desktop && git clone https://github.com/wbuchanan/stataDataVizSDP2016.git
```

Or if you're using another operating system, open the GitBash application and enter:

```
cd /c/Users/username/Desktop
git clone https://github.com/wbuchanan/stataDataVizSDP2016.git
```

If there are ever any changes in the future (e.g., examples added afterwards based on your feedback) you can update everything with:

```
cd ~/Desktop/stataDataVizSDP2016 && git pull
```

# Pre-Session Reading
[brewscheme](http://wbuchanan.github.io/brewscheme/brewscheme.pdf) 

# Additional resources
In conversations with a few friends from Cohort 5, I thought there might be some other resources that I could reference that might be useful to others.  In one of these conversations we started discussing some of the issues with alpha transparency and issues with the underlying algorithms used to implement the perceived transparency that rely on layer order.  This grew out of a talk from [Aneesh Karve at the 2016 Strata + Hadoop World Conference](http://www.visualmagnetic.com/portfolio/visualization-is-distortion/); to get to this part of the discussion you can move to 5:30 in the video.  This presentation ended up being based quite heavily on the work of [Kindlmann, G., & Scheidegger, C. (2014).  An Algebraic Process for Visualization Design.  IEEE Transactions on Visualization and Computer Graphics.](https://www.researchgate.net/profile/Gordon_Kindlmann/publication/265470662_An_Algebraic_Process_for_Visualization_Design/links/541030e10cf2df04e75b7707.pdf).  These two resource provide a really helpful framework for thinking about issues in data visualization, codifying said issues based on the type of effect it has for the user of the visualization, and ultimately providing a framework that we can use to evaluate, refine, and improve existing visualizations.


## Optional
This is an excellent and condensed review of the literature related to data visualization.  It's a quick/easy read that is definitely worth the time if you have a few minutes to kill.  _Note: although the title mentions 30 minutes, that was a reference to the talk from which the blog post was derived not the amount of time it would take to read the post._
[39 studies about human perception in 30 minutes](https://medium.com/@kennelliott/39-studies-about-human-perception-in-30-minutes-4728f9e31a73#.e7q4hqv13)

# Prework
Prior to attending the session, participants should install the `brewscheme` package; the `jsonio` package is optional, but will be useful if you ever need to work with JSON data or are interested in using [D3js](https://www.d3js.org) from Stata.  To make sure you have the most recent version of the program you can install it using (_Note, this program does require Stata 13 or later._):

```Stata
net install brewscheme, from("http://wbuchanan.github.io/brewscheme/")
```

# Other helpful/useful visualization packages

If you are also interested in developing web-based data visualizations and/or integrating [D3.js](https://d3js.org) into your work flow you should also install the programs below:  

## jsonio
This program provides Input/Output functions for working with JSON data Unlike saving a CSV file, the serializer will also include your variable labels, value labels, and other metadata related to the data set in the JSON file itself.  This makes it easier to write more flexible code since you won't need to hardcode the meta data into the source code. It also flattens arbitrarily complex JSON structures so you can load any JSON file as either a two column data set (key-value) or as a single record (e.g., row-value).

```Stata
net install jsonio, from("http://wbuchanan.github.io/StataJSON/")
```

## libhtml
This package has a single .ado file called libhtml that downloads and compiles all of the Mata source code into a Mata library for you.  Then you can create HTML elements within Stata.  To place content between the tags, each HTML object has a method called setClassArgs() that handles inserting the content for you.

```Stata
net install libhtml, from("http://wbuchanan.github.io/matahtml/")
```

## libd3
This is the package that you're probably most interested in.  It is a Mata wrapper around the D3.js library.  With few exceptions it mirrors the D3 library as exactly as possible, but also includes some "syntactic sugar" to make it easier for you you to do things like insert text, numbers, or references to other javascript variables; the other notable exception is that all functions in the D3js library must be followed with parentheses:

```Stata
// Start Mata interpreter
mata:

// Create a d3 object
d = d3()

// Initialize the object with a JS variable name.  
// Equivalent of - var myvar = d3.
d.init("myvar")

// This would fail because .svg is a reference to a member of a class and would 
// not call a self referencing function
d.svg.axis()

// This would work:
// d.svg.axis()
d.svg().axis()

// To reference a JavaScript variable use:
// d3.svg.axis(existingVar)
d.svg().axis("obj_existingVar")

// There is also a method to enter arbitrary javascript code:
// svg.select('p').enter().data()
d.init().jsfree("svg.select('p').enter().data()")
```

For additional information about the [libd3](https://wbuchanan.github.io/d3mata) package, you should check the package repository and/or project page.

```Stata
net inst libd3, from("http://wbuchanan.github.io/d3mata")
```

# Workshop package

```Stata
net from "http://wbuchanan.github.io/stataDataVizSDP2016/"
net inst sdp2016, replace

// This will put the .do files in your current working directory
net get sdp2016, replace

// If you want to save the example scripts somewhere else on your computer use:
net set other "C:/Users/username/Desktop/whereToSaveScripts"

// Now the ancillary files (e.g., .do file scripts) will be saved where you wanted
net get sdp2016, replace
```


## msas.ado Examples
You can view similar examples and additional details about this convenience program using:

```Stata
help msas

// OR 

h msas

// Download the data and save copies of the performance and participation data to disk
msas, perf(exdata/performance.dta) partic(exdata/participation.dta) dlf(msas.xlsx)

// Can load the Stata file normally, or you can load it by processing the MS Excel file
// This would load the performance (e.g., assessment and graduation rate) data
msas using msas.xlsx, perf

// This would load the participation rate data
msas using msas.xlsx, partic

```

## irtsim.ado
The workshop package also includes a small/simple simulation tool to simulate item responses to illustrate some of the visualizations used with IRT.  To view the help file.  The example below would simulate 9 items for 5000 observations using a Rasch model (_The Rasch model is a special case of the 1PL model where the discrimination parameter is constrained to a value of 1)


```Stata
help irtsim

// OR 

h irtsim

// Simulate responses on items with difficulties of -2, -1.5, -1, -0.5, 0, .5, 
// 1, 1.5, and 2 for 5000 examinees with an average ability of 0 and SD of 1.5
irtsim, th(0 1.5) nob(5000) discrim(1) diff(-2(0.5)2) scalef(1) pseudog(0)
```

If you are interested in IRT, there is also some work that I started a while ago to integrate [jMetrik](http://www.itemanalysis.com) in Stata and can be used in Stata 13; _currently only the Joint Maximum Likelihood Estimator for a Rasch Model is supported, but it does provide In-Fit and Out-Fit statistics_.

## schsim.ado
In order to have some data that could be used for nested subjects, there is also a simulation tool that generates data for "students" nested within classrooms, schools, and districts.  For sample sizes, you tell the program the minimum and maximum number of units to sample, and for effects you specify the mean and standard deviation (there is an assumption that all the random effects are normally distributed and the effect for time is treated independently of all other sampling units).  There are also places where you can specify the proportion of observations with specific characteristics (e.g., charter schools within district, whether teachers have masters degrees, were late hires, ethnoracial characteristics of students, EL/Disability/FRL status, etc...) and the coefficient for each of those characteristics.  

Additionally, the simulation also creates different class, school, and district level aggregates and also imposes some cross-classified effects (i.e., a district level effect for the % of teachers with a masters degree or higher).  

```Stata
help schsim

// OR 

h schsim

// Simulate data for test scores of students nested in classes, schools, and
// districts
schsim, avgsc(100 15) dist(3) disteff(0 .15) asi(0.065 7) bl(0.375 -7.5)	 ///   
hisp(0.2 -5.25) natam(0.03 -9.5) white(0.33 4.75) sex(0.51 3.75) 			 ///   
sp(0.11 -14.5) el(0.175 -8.5) mast(0.8 0.0125) lateh(0.225 -2.5) 			 ///   
altc(0.075 -1.5) hq(0.95 0.001) frl(0.65 -4.5) chart(0.085 0.75) 			 ///   
sch(1 15) educ(10 35) stud(18 34) yea(4) attr(0.2285) time(0 1) 			 ///   
scheff(0 1) edeff(0 5) steff(0 10) seed(7779311) 
```

# Participant driven programs/examples

## distrograph.ado
This is essentially a wrapper around the histogram command.  The difference is  a single option `reflines` that accepts a number list.  The numbers passed to this parameter are used to create reference lines based on standard deviations from the mean.

```Stata
help distrograph

// OR 

h distrograph

// Load the performance data
msas using msas.xlsx, perf

// Create a distribution plot of graduation rates with the references mentioned 
// in the request above:
distrograph gradrate if schnm != "District Level", reflin(-2 -1 1 2)

// Like the other graphs, we can also pass a scheme file to the command
distrograph gradrate if schnm != "District Level", reflin(-2 -1 1 2) scheme(sdp2016a)
```

## semiDynamic.do
Wasn't able to get the .ado wrapper working, but this .do file generates a series of district specific scatterplots of reading proficiency vs reading growth of the low 25% students of the schools within it.  It uses the code in dynamicPage1.mata to then generate an HTML page that allows you to select a district to view the graph.  
