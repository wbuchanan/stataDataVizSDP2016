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

```Stata
net from "http://wbuchanan.github.io/stataDataVizSDP2016/"
net inst sdp2016, replace
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




