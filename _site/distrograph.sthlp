{smcl}
{* *! version 0.0.1 13may2016}{...}

{hline}
Command to graph the distribution of continuous variable with reference lines
{hline}

{marker irtsim}{title:help for distrograph}

{title:Syntax}

{p 8 16 2}
{cmd:distrograph} {varname} {ifin} {weight} {cmd:[, options]} 

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Optional}
{synopt :{cmdab:reflin:es}{opt (numlist)}} used to define reference lines as units of standard deviations from the mean.{p_end}
{synopt :{cmdab:*}} for all other options users should see {help histogram}{p_end}

{title:Description}{break}
{pstd}
{cmd:distrograph} is a wrapper around the histogram command that makes it easier to add one or more reference lines to the graph.{p_end}

{title:Options}{break}
{phang}{cmdab:reflin:es} allows you to define which reference lines to add to the graph as units of standard deviations from the means.  For example, {cmdab:reflin:es(-2 -1 1 2)} would add reference lines at -2, -1, 1, and 2 standard deviations from the mean of the variable being graphed..{p_end}

{title:Examples}{break}

{pstd}Load the auto data set and create a graph of the distribution of miles per gallon with reference lines at -2, -1, 1, and 2 standard deviations from the mean.{p_end}
{phang2}{stata sysuse auto.dta, clear}{p_end}
{phang2}{stata distrograph mpg, reflin(-2 -1 1 2)}{p_end}

{title:Author}{break}
{p 4 4 8}William R. Buchanan, Ph.D.{p_end}
{p 4 4 8}Data Scientist{p_end}
{p 4 4 8}{browse "http://mpls.k12.mn.us":Minneapolis Public Schools}{p_end}
{p 4 4 8}William.Buchanan at mpls [dot] k12 [dot] mn [dot] us{p_end}

