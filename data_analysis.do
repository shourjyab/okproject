***********
*********histogram for distribution of test scores*
***********

use temp_final

histogram m_mn_all3 
graph export "C:\Users\Shourjya Deb\Dropbox\Oklahoma GA project\data\hisogram maths3.png", as(png) replace

histogram m_mn_all5
graph export "C:\Users\Shourjya Deb\Dropbox\Oklahoma GA project\data\hisogram maths5.png", as(png) replace

histogram m_mn_all8
graph export "C:\Users\Shourjya Deb\Dropbox\Oklahoma GA project\data\hisogram maths8.png", as(png) replace

histogram e_mn_all3
graph export "C:\Users\Shourjya Deb\Dropbox\Oklahoma GA project\data\hisogram eng3.png", as(png) replace

histogram e_mn_all5
graph export "C:\Users\Shourjya Deb\Dropbox\Oklahoma GA project\data\hisogram eng5.png", as(png) replace

histogram e_mn_all8
graph export "C:\Users\Shourjya Deb\Dropbox\Oklahoma GA project\data\hisogram eng8.png", as(png) replace

clear



***********
*********descriptive statistics to fix restriction for N*
***********

use temp_final 

sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst 
 
//restricting for year 2010-14
generate restrict=0

move restrict year 
replace  restrict=1 if year==2009 | year==2015

count if year==. 

replace restrict=1 if year==.

sort restrict
 
sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst ///
if restrict==0 
 

 

sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst ///
if restrict==0 & m_mn_all3!=. & num_imp==0 & num10==0


sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst ///
if restrict==0 & m_mn_all5!=. & num_imp==0 & num10==0


sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst ///
if restrict==0 & e_mn_all3!=. & num_imp==0 & num10==0


sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst ///
if restrict==0 & e_mn_all5!=. & num_imp==0 & num10==0



sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst ///
if restrict==0 & e_mn_all8!=. & num_imp==0 & num10==0

clear


***********
*********finalizing restrictions for the dataset*
***********
//will also be fixing the problem with elmtch
use temp_final 

sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst 


//restricting for year 2010-14 and when year value is missing
//restrict =1 for years - 2009,15 and . 
generate restrict=0

move restrict year 
replace  restrict=1 if year==2009 | year==2015

count if year==. 

replace restrict=1 if year==.

sort restrict

//this is table 2  
sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst ///
if restrict==0 

//creating variables for standardization 
generate sm3=(m_mn_all3-226.9358)/10.2141 
generate sm5=(m_mn_all5-243.3247)/11.82733
generate sm8=(m_mn_all8-270.9148)/14.20373 

generate se3=(e_mn_all3-203.6377)/13.30238 
generate se5=(e_mn_all5-224.002)/12.09418 
generate se8=(e_mn_all8-258.2511)/10.84145


//creating the sample restriction - code is solid - 1 change

generate sample=1

foreach var in m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind ///
perfrl perell perspeced totenrl stutch_all perelem ppexp_inst {

replace sample=0 if `var'==.
}


//from table 2 we create the variable sample
move sample restrict

sort sample

sum m_mn_all3 m_mn_all5 e_mn_all3 e_mn_all5 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst ///
if sample==1 

save, replace
clear

***********
*********creating graphs of years vs. number of schools with 4 day week*
***********


use temp_final 

//this is what i need to show in the graph
count if num_dup==1 & year==2010
//0
count if num_dup==1 & year==2011
//18
count if num_dup==1 & year==2012
//20
count if num_dup==1 & year==2013
//27
count if num_dup==1 & year==2014
//32

generate frequency=0

replace frequency=0 if num_dup==1 & year==2010
replace frequency=18 if num_dup==1 & year==2011
replace frequency=20 if num_dup==1 & year==2012
replace frequency=27 if num_dup==1 & year==2013
replace frequency=32 if num_dup==1 & year==2014

twoway (bar frequency year) if restrict==0, title("years vs. number of schools with four day week")

save, replace
clear


***********
*********fix problem of duplicates in the sample==1*
***********
// issue is important because I can't run the xtset command 

//stsrting with num10 

use temp_final

sum m_mn_all3 m_mn_all5 m_mn_all8 e_mn_all3 e_mn_all5 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst ///
if sample==1 

keep if sample==1

duplicates tag leaidC year, generate(same)

move same sample

gsort -same leaidC

//manually dropping the observations that are duplicated
drop in 1
drop in 2
drop in 3
drop in 4
drop in 5
drop in 6

save sample1

clear

***********
*********regressions on sample1*
***********
//increase the mmatsize for this section because generic matsize is set at 400
//set to 1000 and seems to work 
//set more off because output in pretty much endless

set matsize 1000
set more off

use sample1

xtset leaidC year



//with non-standardized-num10

//3rd grade math
xtreg m_mn_all3 num10 i.year if sample==1, fe cluster(leaidC)

xtreg m_mn_all3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg m_mn_all3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg m_mn_all3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using num10_math3, excel dec(3) e(all)

//5th grade math
xtreg m_mn_all5 num10 i.year if sample==1, fe cluster(leaidC)

xtreg m_mn_all5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg m_mn_all5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg m_mn_all5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using num10_math5, excel dec(3) e(all)

//8th grade math
xtreg m_mn_all8 num10 i.year if sample==1, fe cluster(leaidC)

xtreg m_mn_all8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg m_mn_all8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg m_mn_all8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using num10_math8, excel dec(3) e(all)

//3rd grade english
xtreg e_mn_all3 num10 i.year if sample==1, fe cluster(leaidC)

xtreg e_mn_all3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg e_mn_all3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg e_mn_all3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using num10_eng3, excel dec(3) e(all)

//5th grade english
xtreg e_mn_all5 num10 i.year if sample==1, fe cluster(leaidC)

xtreg e_mn_all5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg e_mn_all5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg e_mn_all5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using num10_eng5, excel dec(3) e(all)

//8th grade english
xtreg e_mn_all8 num10 i.year if sample==1, fe cluster(leaidC)

xtreg e_mn_all8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg e_mn_all8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg e_mn_all8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using num10_eng8, excel dec(3) e(all)


//with standardized

//3rd grade math
xtreg sm3 num10 i.year if sample==1, fe cluster(leaidC)

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using s_math3, excel dec(3) e(all)

//5th grade math
xtreg sm5 num10 i.year if sample==1, fe cluster(leaidC)

xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using s_math5, excel dec(3) e(all)

//8th grade math
xtreg sm8 num10 i.year if sample==1, fe cluster(leaidC)

xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using s_math8, excel dec(3) e(all)

//3rd grade english
xtreg se3 num10 i.year if sample==1, fe cluster(leaidC)

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using s_eng3, excel dec(3) e(all)

//5th grade english
xtreg se5 num10 i.year if sample==1, fe cluster(leaidC)

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using s_eng5, excel dec(3) e(all)

//8th grade english
xtreg se8 num10 i.year if sample==1, fe cluster(leaidC)

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample==1, fe cluster(leaidC)

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample==1, fe cluster(leaidC)  

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample==1, fe cluster(leaidC)  

outreg2 using s_eng8, excel dec(3) e(all)

clear

***********
*********descriptive statistics treated vs. non-treated*
***********

set matsize 1000
set more off

use sample1

xtset leaidC year

sort leaidC num10

sort num10

list leaidC if num10==1
/*
4022650  
4012300 
4017760 
4032940 
4012300 

4003570
4032940 
4022770 
4030870 
4030870 
     
4032940
4025170 
4003300 
4025500 
4003570 
     
4025500 
4012300 
4012060 
4009780 
4025500 
     
4017760
*/

generate treatment=num10

replace treatment=1 if leaidC==4003300 | leaidC==4003570 | leaidC==4003660  | leaidC==4009780 | leaidC==4012060 
replace treatment=1 if leaidC==4012300 | leaidC==4017760 | leaidC==4021030  | leaidC==4022650 | leaidC==4022770 
replace treatment=1 if leaidC==4025170 | leaidC==4025500 | leaidC==4027960  | leaidC==4030870 | leaidC==4032940

sort treatment 
 
move treatment num10

count if num10==1
count if treatment==1

save, replace
 
 sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst if treatment==1
 
 sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst if treatment==0
 
 
regress perwht treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress perblk treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress perasn treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress perhsp treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress perind treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress perfrl treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress perell treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress perspeced treatment
outreg2 using tvsnt, excel dec(3) e(all)


regress totenrl treatment
outreg2 using tvsnt, excel dec(3) e(all)


regress perfrl treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress stutch_all treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress perelem treatment
outreg2 using tvsnt, excel dec(3) e(all)

regress ppexp_inst treatment
outreg2 using tvsnt, excel dec(3) e(all)


***********
*********tables 1-2-3-4 for grade 3+5 and grade 8*
***********


use temp_final

generate sample35=1

foreach var in m_mn_all3 m_mn_all5 e_mn_all3 e_mn_all5 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind ///
perfrl perell perspeced totenrl stutch_all perelem ppexp_inst {

replace sample35=0 if `var'==.
}

// sample 1 for the sample we want to use
sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst if sample35==1

keep if sample35==1

sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst

duplicates tag leaidC year, generate(same35)

move same35 sample

gsort -same35 leaidC


//manually dropping the observations that are duplicated
drop in 1
drop in 2
drop in 3
drop in 4
drop in 5
drop in 6

save sample35

clear
//for 35
//table 1 for 35
use sample35

sum sm3 sm5 se3 se5 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst

list leaidC if num10==1

generate treatment=num10

replace treatment=1 if leaidC==4003300 | leaidC==4003570 | leaidC==4003660  | leaidC==4009780 | leaidC==4012060 
replace treatment=1 if leaidC==4012300 | leaidC==4017760 | leaidC==4021030  | leaidC==4022650 | leaidC==4022770 
replace treatment=1 if leaidC==4025170 | leaidC==4025500 | leaidC==4027960  | leaidC==4030870 | leaidC==4032940

sort treatment 
 
move treatment num10

count if num10==1
count if treatment==1

//table 2
sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst if treatment==1
 
sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst if treatment==0


regress perwht treatment
outreg2 using t2_35, excel dec(3) e(all)

regress perblk treatment
outreg2 using t2_35, excel dec(3) e(all)

regress perhsp treatment
outreg2 using t2_35, excel dec(3) e(all)

regress perasn treatment
outreg2 using t2_35, excel dec(3) e(all)

regress perind treatment
outreg2 using t2_35, excel dec(3) e(all)

regress perfrl treatment
outreg2 using t2_35, excel dec(3) e(all)

regress perell treatment
outreg2 using t2_35, excel dec(3) e(all)

regress perspeced treatment
outreg2 using t2_35, excel dec(3) e(all)

regress totenrl treatment
outreg2 using t2_35, excel dec(3) e(all)

regress stutch_all treatment
outreg2 using t2_35, excel dec(3) e(all)

regress perelem treatment
outreg2 using t2_35, excel dec(3) e(all)

regress ppexp_inst treatment
outreg2 using t2_35, excel dec(3) e(all)

//table 3

generate trend3=(trend*trend*trend)


set matsize 1000
set more off

xtset leaidC year


//3rd grade english
xtreg se3 num10 i.year if sample35==1, fe cluster(leaidC)

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample35==1, fe cluster(leaidC)

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample35==1, fe cluster(leaidC)  

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample35==1, fe cluster(leaidC)  

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend3##i.leaidC if sample35==1, fe cluster(leaidC)  

outreg2 using s35_eng3, excel dec(3) e(all)

//5th grade english
xtreg se5 num10 i.year if sample35==1, fe cluster(leaidC)

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample35==1, fe cluster(leaidC)

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample35==1, fe cluster(leaidC)  

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample35==1, fe cluster(leaidC)  

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend3##i.leaidC if sample35==1, fe cluster(leaidC)  

outreg2 using s35_eng5, excel dec(3) e(all)


//3rd grade math
xtreg sm3 num10 i.year if sample35==1, fe cluster(leaidC)

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample35==1, fe cluster(leaidC)

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample35==1, fe cluster(leaidC)  

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample35==1, fe cluster(leaidC)  

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend3##i.leaidC if sample35==1, fe cluster(leaidC)  

outreg2 using s35_math3, excel dec(3) e(all)

//5th grade math
xtreg sm5 num10 i.year if sample35==1, fe cluster(leaidC)

xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample35==1, fe cluster(leaidC)

xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample35==1, fe cluster(leaidC)  

xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample35==1, fe cluster(leaidC)  

xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend3##i.leaidC if sample35==1, fe cluster(leaidC)  

outreg2 using s35_math5, excel dec(3) e(all)

save, replace

//table 4

generate t_frl=treatment*perfrl
generate t_sped=treatment*perspeced
generate t_ell=treatment*perell



xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_frl i.year if sample35==1, fe cluster(leaidC)

xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_sped i.year if sample35==1, fe cluster(leaidC)

xtreg sm5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_ell i.year if sample35==1, fe cluster(leaidC)

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_frl i.year if sample35==1, fe cluster(leaidC)

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_sped i.year if sample35==1, fe cluster(leaidC)

xtreg sm3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_ell i.year if sample35==1, fe cluster(leaidC)

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_frl i.year if sample35==1, fe cluster(leaidC)

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_sped i.year if sample35==1, fe cluster(leaidC)

xtreg se5 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_ell i.year if sample35==1, fe cluster(leaidC)

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_frl i.year if sample35==1, fe cluster(leaidC)

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_sped i.year if sample35==1, fe cluster(leaidC)

xtreg se3 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_ell i.year if sample35==1, fe cluster(leaidC)



outreg2 using s35_int, excel dec(3) e(all)

save, replace

clear

//for 8
use temp_final

generate sample8=1

foreach var in m_mn_all8 e_mn_all8 ///
num num_dup num10 num_imp ///
perwht perblk perhsp perasn perind ///
perfrl perell perspeced totenrl stutch_all perelem ppexp_inst {

replace sample8=0 if `var'==.
}

//keep only sample8 

count if sample8==1

count if sample8==0

keep if sample8==1


// sample 8 for the sample we want to use
sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst if sample8==1

keep if sample8==1

sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst

duplicates tag leaidC year, generate(same8)

move same8 sample

gsort -same8 leaidC

//manually dropping the observations that are duplicated
drop in 1
drop in 2
drop in 3
drop in 4
drop in 5
drop in 6

save sample8

clear

use sample8

//table 1

sum se8 sm8 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst

//table 2

list leaidC if num10==1

generate treatment=num10

replace treatment=1 if leaidC==4003300 | leaidC==4003570 | leaidC==4003660  | leaidC==4009780 | leaidC==4012060

replace treatment=1 if leaidC==4012300 | leaidC==4017760 | leaidC==4018660  | leaidC==4022650 | leaidC==4022770 

replace treatment=1 if leaidC==4025170 | leaidC==4025500 | leaidC==4030870 | leaidC==4032940



//table 2
sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst if treatment==1
 
sum perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst if treatment==0


regress perwht treatment
outreg2 using t2_8, excel dec(3) e(all)

regress perblk treatment
outreg2 using t2_8, excel dec(3) e(all)

regress perhsp treatment
outreg2 using t2_8, excel dec(3) e(all)

regress perasn treatment
outreg2 using t2_8, excel dec(3) e(all)

regress perind treatment
outreg2 using t2_8, excel dec(3) e(all)

regress perfrl treatment
outreg2 using t2_8, excel dec(3) e(all)

regress perell treatment
outreg2 using t2_8, excel dec(3) e(all)

regress perspeced treatment
outreg2 using t2_8, excel dec(3) e(all)

regress totenrl treatment
outreg2 using t2_8, excel dec(3) e(all)

regress stutch_all treatment
outreg2 using t2_8, excel dec(3) e(all)

regress perelem treatment
outreg2 using t2_8, excel dec(3) e(all)

regress ppexp_inst treatment
outreg2 using t2_8, excel dec(3) e(all)


//table 3

generate trend3=(trend*trend*trend)


set matsize 1000
set more off

xtset leaidC year


generate t_frl=treatment*perfrl
generate t_sped=treatment*perspeced
generate t_ell=treatment*perell



//8th grade english
xtreg se8 num10 i.year if sample8==1, fe cluster(leaidC)

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample8==1, fe cluster(leaidC)

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample8==1, fe cluster(leaidC)  

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample8==1, fe cluster(leaidC)  

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend3##i.leaidC if sample8==1, fe cluster(leaidC)  

outreg2 using s8_eng8, excel dec(3) e(all)

//8th grade maths
xtreg sm8 num10 i.year if sample8==1, fe cluster(leaidC)

xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year if sample8==1, fe cluster(leaidC)

xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend##i.leaidC if sample8==1, fe cluster(leaidC)  

xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend2##i.leaidC if sample8==1, fe cluster(leaidC)  

xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst i.year c.trend3##i.leaidC if sample8==1, fe cluster(leaidC)  

outreg2 using s8_math8, excel dec(3) e(all)

//table 4


xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_frl i.year if sample8==1, fe cluster(leaidC)

xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_sped i.year if sample8==1, fe cluster(leaidC)

xtreg sm8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_ell i.year if sample8==1, fe cluster(leaidC)

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_frl i.year if sample8==1, fe cluster(leaidC)

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_sped i.year if sample8==1, fe cluster(leaidC)

xtreg se8 num10 perwht perblk perhsp perasn perind perfrl perell perspeced totenrl stutch_all perelem ppexp_inst t_ell i.year if sample8==1, fe cluster(leaidC)


outreg2 using s8_int, excel dec(3) e(all)

save, replace

clear



























  

