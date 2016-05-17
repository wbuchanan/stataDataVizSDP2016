# Becoming a Better Data Communicator: Stata Data Visualization
This repository contains materials for the _Becoming a Better Data Communicator: Stata Data Visualization_ session at the [Strategic Data Project's 2016 Spring Convening](http://sdp.cepr.harvard.edu/event/beyond-numbers-convening).  Additionally, if there are resources you think others may find helpful, please feel free to share them here as well via `pull` requests.  

# Prereadings
[brewscheme](http://wbuchanan.github.io/brewscheme/brewscheme.pdf) 

## Optional
This is an excellent and condensed review of the literature related to data visualization.  It's a quick/easy read that is definitely worth the time if you have a few minutes to kill.  _Note: although the title mentions 30 minutes, that was a reference to the talk from which the blog post was derived not the amount of time it would take to read the post._
[39 studies about human perception in 30 minutes](https://medium.com/@kennelliott/39-studies-about-human-perception-in-30-minutes-4728f9e31a73#.e7q4hqv13)

# Prework
Prior to attending the session, participants should install the `brewscheme` package; the `jsonio` package is optional, but will be useful if you ever need to work with JSON data or are interested in using [D3js](https://www.d3js.org) from Stata.  To make sure you have the most recent version of the program you can install it using:

```Stata
// This package will be used in several of the examples in the session
net install brewscheme, from("http://wbuchanan.github.io/brewscheme/")

// If you want to try integrating D3js type graphs install the packages below as well
net install jsonio, from("http://wbuchanan.github.io/StataJSON/")
net install libhtml, from("http://wbuchanan.github.io/matahtml/")
net install libd3, from("http://wbuchanan.github.io/d3mata/")
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
```


```Stata
// Download the data and save copies of the performance and participation data to disk
msas, perf(exdata/performance.dta) partic(exdata/participation.dta) dlf(msas.xlsx)

// Can load the Stata file normally, or you can load it by processing the MS Excel file
// This would load the performance (e.g., assessment and graduation rate) data
msas using msas.xlsx, perf

// This would load the participation rate data
msas using msas.xlsx, partic

```

## irtsim.ado
The workshop package also includes a small/simple simulation tool to generate item responses in order to look at more types of data.  You can use:

```Stata
help irtsim
```

To view the helpfile.  The example data generated for the workshop slides was created with:

```Stata
irtsim, th(0 1.5) nob(5000) discrim(1) diff(-2(0.5)2) scalef(1) pseudog(0)
```

# Other example programs/utilities

## distrograph.ado
This is essentially a wrapper around the histogram command.  The difference is  a single option `reflines` that accepts a number list.  The numbers passed to this parameter are used to create reference lines based on standard deviations from the mean.

```Stata
// Load the performance data
msas using msas.xlsx, perf

// Create a distribution plot of graduation rates with the references mentioned 
// in the request above:
distrograph gradrate if schnm != "District Level", reflin(-2 -1 1 2)

// Like the other graphs, we can also pass a scheme file to the command
distrograph gradrate if schnm != "District Level", reflin(-2 -1 1 2) scheme(sdp2016a)
```

