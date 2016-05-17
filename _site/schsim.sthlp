{smcl}
{* *! version 0.0.1 15may2016}{...}

{hline}
Command to simulate data for value added and multilevel visualizations display
{hline}

{marker schsim}{title:help for schsim}

{title:Syntax}

{p 8 16 2}
{cmd:schsim} {cmd:,} {it:options} [{it:options}]

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required}
{synopt :{cmdab:dist:ricts}{opt (integer)}} number of districts to simulate.{p_end}
{synopt :{cmdab:disteff:ect}{opt (numlist)}} the mean and standard deviation of the district level random effect.{p_end}
{synopt :{cmdab:avgsc:ore}{opt (numlist)}} mean and standard deviation of test scores.{p_end}
{synopt :{cmdab:asi:an}{opt (numlist)}} proportion of Asian students and effect.{p_end}
{synopt :{cmdab:bl:ack}{opt (numlist)}} proportion of Black students and effect.{p_end}
{synopt :{cmdab:hisp:anic}{opt (numlist)}} proportion of Hispanic/Latino(a) students and effect.{p_end}
{synopt :{cmdab:natam:er}{opt (numlist)}} proportion of Native American/First Nations students and effect.{p_end}
{synopt :{cmdab:whi:te}{opt (numlist)}} proportion of White students and effect.{p_end}
{synopt :{cmd:sex}{opt (numlist)}} proportion of females and effect.{p_end}
{synopt :{cmdab:sp:ed}{opt (numlist)}} proportion of students with disabilities and effect.{p_end}
{synopt :{cmdab:el:l}{opt (numlist)}} proportion of English learner students and effect.{p_end}
{synopt :{cmdab:mast:ers}{opt (numlist)}} proportion of educators with masters degrees or higher and effect.{p_end}
{synopt :{cmdab:lateh:ire}{opt (numlist)}} proportion of educators hired late and effect.{p_end}
{synopt :{cmdab:altc:ert}{opt (numlist)}} proportion of educators certified through alternate certification programs and effect.{p_end}
{synopt :{cmd:hq}{opt (numlist)}} proportion of educators meeting Title II Highly Qualified requirements and effect.{p_end}
{synopt :{cmd:frl}{opt (numlist)}} proportion of students qualifying for free/reduced price lunch and effect.{p_end}
{synopt :{cmdab:chart:er}{opt (numlist)}} proportion of schools that are charter schools and a charter school effect.{p_end}
{syntab:Optional}
{synopt :{cmdab:sch:ools}{opt (numlist)}} lower and upper bounds on the number of schools per district.{p_end}
{synopt :{cmdab:educ:ators}{opt (numlist)}} lower and upper bounds on the number of educators per school.{p_end}
{synopt :{cmdab:stud:ents}{opt (numlist)}} lower and upper bounds on the number of students per educator.{p_end}
{synopt :{cmdab:yea:rs}{opt (integer)}} number of years of data to simulate.{p_end}
{synopt :{cmdab:attr:ition}{opt (real)}} attrition rate specified as a proportion.{p_end}
{synopt :{cmd:time}{opt (numlist)}} the mean and standard deviation of an independent time random effect.{p_end}
{synopt :{cmdab:steff:ect}{opt (numlist)}} the mean and standard deviation of the student-level random effect.{p_end}
{synopt :{cmdab:edeff:ect}{opt (numlist)}} the mean and standard deviation of the educator-level random effect.{p_end}
{synopt :{cmdab:scheff:ect}{opt (numlist)}} the mean and standard deviation of the school-level random effect.{p_end}
{synopt :{cmd:seed}{opt (integer)}} used to set the pseudo random number generator seed.{p_end}


{title:Description}{break}
{pstd}
{cmd:schsim} is a command used to simulate educational data.{p_end}

{title:Examples}{break}

{pstd}Simulate data{p_end}
{p 4 4 8}{hi:schsim, avgsc(100 15) dist(7) disteff(0 .15) asi(0.065 7) bl(0.375 -7.5)	 ///}{p_end}
{p 4 4 8}{hi:hisp(0.2 -5.25) natam(0.03 -9.5) white(0.33 4.75) sex(0.51 3.75) 			 ///}{p_end}
{p 4 4 8}{hi:sp(0.11 -14.5) el(0.175 -8.5) mast(0.8 0.0125) lateh(0.225 -2.5) 			 ///}{p_end}
{p 4 4 8}{hi:altc(0.075 -1.5) hq(0.95 0.001) frl(0.65 -4.5) chart(0.085 0.75) 			 ///}{p_end}
{p 4 4 8}{hi:sch(1 15) educ(10 35) stud(18 34) yea(4) attr(0.2285) time(0 1) 			 ///}{p_end}
{p 4 4 8}{hi:scheff(0 1) edeff(0 5) steff(0 10) seed(7779311)}{p_end}

{title:Author}{break}
{p 4 4 8}William R. Buchanan, Ph.D.{p_end}
{p 4 4 8}Data Scientist{p_end}
{p 4 4 8}{browse "http://mpls.k12.mn.us":Minneapolis Public Schools}{p_end}
{p 4 4 8}William.Buchanan at mpls [dot] k12 [dot] mn [dot] us{p_end}

