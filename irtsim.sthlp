{smcl}
{* *! version 0.0.1 12may2016}{...}

{hline}
Command to simulate Item Response Data
{hline}

{marker irtsim}{title:help for irtsim}

{title:Syntax}

{p 8 16 2}
{cmd:irtsim} {cmd:,} {it:options} [{it:options}]

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required}
{synopt :{cmdab:th:eta}{opt (numlist)}} used to specify the mean and standard deviation of theta (ability).{p_end}
{synopt :{cmdab:nob:servations}{opt (real)}} used to specify the number of observations (test takers).{p_end}
{synopt :{cmdab:diff:iculty}{opt (numlist)}} used to specify the difficulty of the items.{p_end}
{syntab:Optional}
{synopt :{cmdab:discrim:ination}{opt (numlist)}} used for the discrimination parameter values for items.{p_end}
{synopt :{cmdab:pseudog:uessing}{opt (numlist)}} used for the pseudoguessing parameter values for items.{p_end}
{synopt :{cmdab:nit:ems}{opt (real)}} used to specify the number of items.{p_end}
{synopt :{cmdab:scalef:actor}{opt (real)}} used to specify the scaling constant{p_end}

{title:Description}{break}
{pstd}
{cmd:irtsim} is a command used to simulate a data set of item responses for the 2016 SDP Convening session on data visualization in Stata.{p_end}

{title:Options}{break}
{phang}{cmdab:th:eta} pass two numbers to this parameter.  The two numbers are used to simulate values of theta from a normal distribution with the first value defining the mean and second number defining the standard deviation.{p_end}

{phang}{cmdab:nob:servations} the value passed to this parameter will define the number of observations to use in the simulation.{p_end}

{phang}{cmdab:diff:iculty} a set of numeric values defining the difficulty (b) parameter for the items that will be simulated.{p_end}

{phang}{cmdab:discrim:ination} values defining the discrimination value used to simulate the response probabilities.  This defaults to a value of 1 if no arguments are passed to the parameter.{p_end}

{phang}{cmdab:pseudog:uessing} values defining the pseudo-guessing parameter values used when simulating the response probabilities.  These shift the lower asymptote (e.g., the left most portion of the item characteristic curves) to adjust for potential guessing.  If no value is supplied this defaults to a value of 0.{p_end}

{phang}{cmdab:nit:ems} if a single value of passed to the {cmdab:diff:iculty} parameter, specify the number of items to simulate here.  If multiple values are passed to the {cmdab:diff:iculty} parameter, the number of items will be inferred from the number of parameter values passed to that parameter.{p_end}

{phang}{cmdab:scalef:actor} used to specify the scaling constant/factor used when simulating the response probabilities.  This defaults to a value of 1.701, but should be set to 1 when simulating responses from a Rasch model.{p_end}

{title:Examples}{break}

{pstd}Simulate data from a Rasch model{p_end}
{phang2}{stata irtsim, th(0 1) nob(2500) diff(-.4 -.1 0.025 .575 .78) discrim(1) pseudog(0) scalef(1)}{p_end}

{pstd}Simulate data from a 1PL model with high discrimination{p_end}
{phang2}{stata irtsim, th(0 1) nob(2500) discrim(1.75) diff(-.4 -.1 0.025 .575 .78)}{p_end}

{title:References}{break}
{p 2 6 8}McDonald, R. P. (1999). {it:Test theory: a unified treatment}.  Mahwah, NJ: Lawrence Erlbaum Associates, Inc.{p_end}
{p 2 6 8}Meyer, J. P. (2014). {it:Applied measurement with jMetrik}.  New York City, NY:  Routledge.{p_end}

{title:Author}{break}
{p 4 4 8}William R. Buchanan, Ph.D.{p_end}
{p 4 4 8}Data Scientist{p_end}
{p 4 4 8}{browse "http://mpls.k12.mn.us":Minneapolis Public Schools}{p_end}
{p 4 4 8}William.Buchanan at mpls [dot] k12 [dot] mn [dot] us{p_end}

