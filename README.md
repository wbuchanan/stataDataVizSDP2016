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

## Some Example data sets
There are some data used in some StataPress books that should look familiar and provide pretty good starting points for some visualization techniques.  You can install them using:

```Stata
// Tells Stata where to save/store ancillary files with packages
net set other `"`c(sysdir_personal)'"'

// Installs the package for Interpretting and Visualizing Regression Models 
net inst ivrm, from("http://www.stata-press.com/data/ivrm/") replace

// Gets the supplementary/ancillary files
net get ivrm, replace

// Installs the package for A Visual Guide to Stata Graphics (3rd Ed)
net inst vgsg3, from("http://www.stata-press.com/data/vgsg3/") replace

// Gets the supplementary/ancillary files
net get vgsg3, replace
```

