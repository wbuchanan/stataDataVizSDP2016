{smcl}
{* *! version 0.0.1 09may2016}{...}

{hline}
Command for accessing and cleaning MSAS Data
{hline}

{marker brewtitle}{title:help for msas}

{title:Syntax}

{p 8 16 2}
{cmd:msas} [{opt using}] [{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Cleaning, Loading, and Preparing Data}
{synopt :{opt perf}[{opt (filename)}]}Loads performance data if no filename specified or saves a copy of the parsed/cleaned data as a Stata formatted file after loading.{p_end}
{synopt :{opt partic}[{opt (filename)}]}Loads participation data if no filename specified or saves a copy of the parsed/cleaned data as a Stata formatted file after loading.{p_end}
{syntab:Data Acquisition}
{synopt :{opt dlf:ile(filename)}} Specifies file name to use when saving the data to your computer.{p_end}

{title:Description}
{pstd}
{cmd:msas} is used to access, clean/parse, and load results from the Mississippi Statewide Accountability System for use in the {hi:Becoming A Better Data Communicator: Stata Data Visualization} session at the Strategic Data Project's 2016 convening.{p_end}

{title:Examples}

{pstd}Download copy of file and save it as msas.xlsx{p_end}
{phang2}{stata msas, dlf(msas)}{p_end}

{pstd}Parse and clean the performance data from the previous download{p_end}
{phang2}{stata msas using msas.xlsx, perf}{p_end}

{pstd}Download, parse/clean, and save participation data{p_end}
{phang2}{stata msas, dlf(msas) partic(participationData)}{p_end}

{title:Author}{break}
{p 4 4 8}William R. Buchanan, Ph.D.{p_end}
{p 4 4 8}Data Scientist{p_end}
{p 4 4 8}{browse "http://mpls.k12.mn.us":Minneapolis Public Schools}{p_end}
{p 4 4 8}William.Buchanan at mpls [dot] k12 [dot] mn [dot] us{p_end}

