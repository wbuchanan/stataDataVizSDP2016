# Becoming a Better Data Communicator: Stata Data Visualization
This repository contains materials for the _Becoming a Better Data Communicator: Stata Data Visualization_ session at the [Strategic Data Project's 2016 Spring Convening](http://sdp.cepr.harvard.edu/event/beyond-numbers-convening).  Additionally, if there are resources you think others may find helpful, please feel free to share them here as well via `pull` requests.  

# Prereadings
[brewscheme](http://wbuchanan.github.io/brewscheme/brewscheme.pdf) 

# Prework
Prior to attending the session, participants should install the `brewscheme` package; the `jsonio` package is optional, but will be useful if you ever need to work with JSON data or are interested in using [D3js](https://www.d3js.org) from Stata.  To make sure you have the most recent version of the program you can install it using:

```Stata
net install brewscheme, from("http://wbuchanan.github.io/brewscheme/")
net install jsonio, from("http://wbuchanan.github.io/StataJSON/")
```

# Data used for graph examples - Mississippi Statewide Accountability System Results
Since these data are already vetted and contain variables from each of the measurement scales, this would be a good data set to work with for examples.  

There is a Stata executable `msas.ado` in the exampleCode subdirectory.  I'll 
create a Stata package that can be installed as well, but you can download/copy 
that file then use:

```Stata
adopath ++ /Where/You/Saved/msas.ado
```

To be able to the program from Stata.  It will download a copy of the data mentioned above and has options to save pre-cleaned Stata formatted files or to load/clean the file from disk:

## msas.ado Examples

```Stata
// Download the data and save copies of the performance and participation data to disk
msas, perf(exdata/performance.dta) partic(exdata/participation.dta) dlf(msas.xlsx)

// Can load the Stata file normally, or you can load it by processing the MS Excel file
// This would load the performance (e.g., assessment and graduation rate) data
msas using msas.xlsx, perf

// This would load the participation rate data
msas using msas.xlsx, partic

```




