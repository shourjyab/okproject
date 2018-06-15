/*controls is the file with the year and district*/
/*test_scores is the file with the subject, grade, year, district observation*/
//controls data set is also called the covariate data set
/*crosswalk data set is the merger of leaid and dist id data sets*/
/*treatment data sets are in the district folder - will update later*/


***********
*********checking for merger*
***********
//following lines fo code were to check if they merge
//not of signficance for later work


use controls
merge 1:m leaidC year using test_scores
drop _merge
save merge1, replace
clear

use crosswalk
rename leaid leaidC
 
merge m:m leaidC using merge1
save ok_cons, replace
clear


***********
*********changing format of test_scores data set*
***********

use test_scores

//data is using only grades 3,5,8 for analysis

keep if grade==3| grade==5| grade==8

//to check the grades retained
unique grade

//list of variables needed from this test_scores data set
//->leaidC leaname fips stateabb grade year subject totgyb_all mn_all mn_wag mn_wbg mn_whg

keep leaidC leaname fips stateabb grade year subject totgyb_all mn_all mn_wag mn_wbg mn_whg


//lots of data missing here - just to keep track - 14803
count if mn_wag==.
//14256
count if mn_wbg==.
//13856
count if mn_whg==.
//13167

save temp_ts, replace
clear

//creating a temp file to reshape and then merge the two subjects

use temp_ts

sort leaidC year grade subject 


        
//do this twice to have the necessary format - the move command ie
move year leaidC

//just reshaping maths first
drop if subject=="ela"

reshape wide subject totgyb_all mn_all mn_wag mn_wbg mn_whg, i(leaidC year) j(grade)

//some formatting post reshaping

//not required - just 
drop subject3 subject8 subject5

move leaname totgyb_all3
move fips totgyb_all3
move stateabb totgyb_all3

//renaming variables to indicate that these are math scores

rename totgyb_all3 m_totgyb_all3
rename mn_all3 m_mn_all3
rename mn_wag3 m_mn_wag3
rename mn_wbg3 m_mn_wbg3
rename mn_whg3 m_mn_whg3
rename totgyb_all5 m_totgyb_all5
rename mn_all5 m_mn_all5
rename mn_wag5 m_mn_wag5
rename mn_wbg5 m_mn_wbg5
rename mn_whg5 m_mn_whg5
rename totgyb_all8 m_totgyb_all8
rename mn_all8 m_mn_all8
rename mn_wag8 m_mn_wag8
rename mn_wbg8 m_mn_wbg8
rename mn_whg8 m_mn_whg8

save test_maths, replace

clear

//to get the descriptions of the variables 
use test_scores

keep leaidC leaname fips stateabb grade year subject totgyb_all mn_all mn_wag mn_wbg mn_whg

/*
leaidC          NCES ID - Geographic School Districts
leaname         District (LEA) Name
fips            State FIPS Code
stateabb        State Abbreviation
grade           Tested Grade (g)
year            Spring of Tested Year (y)
subject         Tested Subject (b)
totgyb_all      Sample Size for All Estimates (number of tests in gyb)
mn_all          Geo Dist gyb Ach Mean, All Students, NAEP
mn_wag          Geo Dist gyb Estimated White-Asian Gap, NAEP
mn_wbg          Geo Dist gyb Estimated White-Black Gap, NAEP
mn_whg          Geo Dist gyb Estimated White-Hispanic Gap, NAEP
*/

clear

//adding variable labels
use test_maths

label variable m_totgyb_all3 "Maths,grade 3 - Sample Size for All Estimates (number of tests in gyb)"
label variable m_mn_all3 "Maths,grade 3 - Geo Dist gyb Ach Mean, All Students, NAEP"
label variable m_mn_wag3 "Maths,grade 3 - Geo Dist gyb Estimated White-Asian Gap, NAEP"
label variable m_mn_wbg3 "Maths,grade 3 - Geo Dist gyb Estimated White-Black Gap, NAEP"
label variable m_mn_whg3 "Maths,grade 3 - Geo Dist gyb Estimated White-Hispanic Gap, NAEP"

label variable m_totgyb_all5 "Maths,grade 5 - Sample Size for All Estimates (number of tests in gyb)"
label variable m_mn_all5 "Maths,grade 5 - Geo Dist gyb Ach Mean, All Students, NAEP"
label variable m_mn_wag5 "Maths,grade 5 - Geo Dist gyb Estimated White-Asian Gap, NAEP"
label variable m_mn_wbg5 "Maths,grade 5 - Geo Dist gyb Estimated White-Black Gap, NAEP"
label variable m_mn_whg5 "Maths,grade 5 - Geo Dist gyb Estimated White-Hispanic Gap, NAEP"

label variable m_totgyb_all8 "Maths,grade 8 - Sample Size for All Estimates (number of tests in gyb)"
label variable m_mn_all8 "Maths,grade 8 - Geo Dist gyb Ach Mean, All Students, NAEP"
label variable m_mn_wag8 "Maths,grade 8 - Geo Dist gyb Estimated White-Asian Gap, NAEP"
label variable m_mn_wbg8 "Maths,grade 8 - Geo Dist gyb Estimated White-Black Gap, NAEP"
label variable m_mn_whg8 "Maths,grade 8 - Geo Dist gyb Estimated White-Hispanic Gap, NAEP"

save, replace
clear


//repeating the same for the ela subject 

//using the temp file we had created

use temp_ts

sort leaidC year grade subject 
      
//do this twice to have the necessary format - the move command ie
move year leaidC

//reshaping eng now
keep if subject=="ela"

reshape wide subject totgyb_all mn_all mn_wag mn_wbg mn_whg, i(leaidC year) j(grade)

//some formatting post reshaping

//not required - just 
drop subject3 subject8 subject5

move leaname totgyb_all3
move fips totgyb_all3
move stateabb totgyb_all3

//renaming variables to indicate that these are math scores

rename totgyb_all3 e_totgyb_all3
rename mn_all3 e_mn_all3
rename mn_wag3 e_mn_wag3
rename mn_wbg3 e_mn_wbg3
rename mn_whg3 e_mn_whg3
rename totgyb_all5 e_totgyb_all5
rename mn_all5 e_mn_all5
rename mn_wag5 e_mn_wag5
rename mn_wbg5 e_mn_wbg5
rename mn_whg5 e_mn_whg5
rename totgyb_all8 e_totgyb_all8
rename mn_all8 e_mn_all8
rename mn_wag8 e_mn_wag8
rename mn_wbg8 e_mn_wbg8
rename mn_whg8 e_mn_whg8

//adding variable labels

label variable e_totgyb_all3 "Eng,grade 3 - Sample Size for All Estimates (number of tests in gyb)"
label variable e_mn_all3 "Eng,grade 3 - Geo Dist gyb Ach Mean, All Students, NAEP"
label variable e_mn_wag3 "Eng,grade 3 - Geo Dist gyb Estimated White-Asian Gap, NAEP"
label variable e_mn_wbg3 "Eng,grade 3 - Geo Dist gyb Estimated White-Black Gap, NAEP"
label variable e_mn_whg3 "Eng,grade 3 - Geo Dist gyb Estimated White-Hispanic Gap, NAEP"

label variable e_totgyb_all5 "Eng,grade 5 - Sample Size for All Estimates (number of tests in gyb)"
label variable e_mn_all5 "Eng,grade 5 - Geo Dist gyb Ach Mean, All Students, NAEP"
label variable e_mn_wag5 "Eng,grade 5 - Geo Dist gyb Estimated White-Asian Gap, NAEP"
label variable e_mn_wbg5 "Eng,grade 5 - Geo Dist gyb Estimated White-Black Gap, NAEP"
label variable e_mn_whg5 "Eng,grade 5 - Geo Dist gyb Estimated White-Hispanic Gap, NAEP"

label variable e_totgyb_all8 "Eng,grade 8 - Sample Size for All Estimates (number of tests in gyb)"
label variable e_mn_all8 "Eng,grade 8 - Geo Dist gyb Ach Mean, All Students, NAEP"
label variable e_mn_wag8 "Eng,grade 8 - Geo Dist gyb Estimated White-Asian Gap, NAEP"
label variable e_mn_wbg8 "Eng,grade 8 - Geo Dist gyb Estimated White-Black Gap, NAEP"
label variable e_mn_whg8 "Eng,grade 8 - Geo Dist gyb Estimated White-Hispanic Gap, NAEP"


save test_eng, replace

clear

//merging the test_maths+test_eng datasets

use test_maths

merge 1:1 leaidC year using test_eng
//30 observations unmatched 

sort _merge

//some investigation into unmatched observations
unique leaidC
//452 unique school districts
unique year
//7 years

/* there should have been 452*7=3164 observations there are 2837
we are missing year observations - might be a reason for the so
many unmatched values*/

drop _merge

save testscores_c, replace
clear



***********
*********trimming the control data set*
***********

use controls 

//trimming down to the variables to be used 

keep leaidC leaname year fips stateabb countyid countyname urban ///
perind perasn perhsp perblk perwht perfrl perrl perell perspeced ///
totenrl nsch ncharters gslo gshi elmtch tottch aides stutch_all ///
percharter_all ppexp_tot ppexp_inst pprev_tot baplus_all poverty517_all ///
singmom_all snap_all samehouse_all unemp_all inc50all incrat9010all ///
incrat9050all giniall teenbirth_all sesall

//just checking for the mergers 
unique leaidC
//537 unique school districts
unique year
//7 years
//should have been 537*7=3759 observations

merge 1:1 leaidC year using testscores_c

sort _merge

drop _merge

save test_controls_c, replace

clear


***********
********* distict level files merged with crosswalk*
***********
//district level files contain the treatment data -num 

//merging cross walk with districts


foreach file in "2010_11" "2011_12" "2012_13" "2013_14" {
use `file', clear
merge m:m district_id using crosswalk
sort _merge
drop _merge
save c_`file', replace
clear
}


//appenind the files together 
use c_2010_11
append using c_2011_12
append using c_2012_13
append using c_2013_14

save cross_trt, replace
clear 

//cross_trt has district id +leaid 



***********
********* merging test+contols+treatment+crosswalk*
***********
use cross_trt
//rename leaid leaidC
unique leaidC
//Number of unique values of leaidC is  609
move leaidC district_id
move year county_name
move num district_name
sort leaidC year
//unmatched investigation 

count if district_id=="" | leaidC==.
/* total observations 2801 - 304 don't have district id's in the corresponding 
leaidc and 358 don't have leaidc in the cooresponding district id*/

save, replace
clear

use test_controls_c
//problem found - 2009, 10, 11 ,12, 13 14 15 but the cross_trt has values of 2011, 12 , 13, 14
merge m:m leaidC year using cross_trt

/*not matched                         2,329
        from master                     1,609  (_merge==1)
        from using                        720  (_merge==2)

    matched                             2,081  (_merge==3)
*/
count if year==2009
// 536
sort leaidC year
move district_id leaname
move year leaname
move num leaname
drop _merge

save temp_final, replace
clear


***********
********* creating the three different treatment variables*
***********


use temp_final

generate num_dup=num
move num_dup num 
sort num 
replace num_dup=1 if num>0 & num<4


//creates the variables num10
//num10 will have num =0 for the year 2010

clonevar num10=num_dup 
move num10 num_dup

count if year==2010

count if num==. & year==2010

replace num10=0 if year==2010



//creates the variables num_imp
//num_imp will have imputed num values for 2011 to 2010
clonevar num_imp=num_dup 

move num_imp num10

sort leaidC year

//for imputing 2011 values into 2010
count if num==. & year==2010
//534

count if year==2010
//534

replace num_imp = num_imp[_n+1] if year==2010
//522 real changes 

//12 changes extra in num10
sort num10  

replace num10=. if num_imp==. & num10==0

count if num_imp==. & num10==0




//creating labels for the two new treatment variables

label variable num10 "treatment variable where 2010 has 0 treatment"
label variable num_imp "treatment variable imputed from 2011"
label variable num_dup "treatment variable where observation is 1 yes/0 no"
save, replace
clear



***********
*********leaid - highest grade*
***********

use test_scores
keep if subject=="ela"
bys leaidC: egen gd_e = max(grade)
count if gd_e!=8


keep leaidC gd_e year

save eng_gd
clear

use test_scores
keep if subject=="math"
bys leaidC: egen gd_m = max(grade)
keep leaidC gd_m year

save math_gd
clear

use eng_gd
merge m:m leaidC year using math_gd

sort _merge
drop _merge

save grade_detail
clear


***********
*********fixing district id for year 2010*
***********
use temp_final 

replace district_id="." if year==2010

replace district_id = district_id[_n+1] if district_id=="."

save, replace
clear


***********
*********trimming the data set*
***********
use temp_final

drop m_mn_wag3 m_mn_wbg3 m_mn_whg3 m_mn_wag5 m_mn_wbg5 m_mn_whg5 ///
m_mn_wag8 m_mn_wbg8 m_mn_whg8 e_mn_wag3 e_mn_wbg3 e_mn_whg3 e_mn_wag5 ///
e_mn_wbg5 e_mn_whg5 e_mn_wag8 e_mn_wbg8 e_mn_whg8

save, replace
clear



***********
*********fixing the issue slementary school teachers*
***********
use temp_final

generate perelem=(elmtch/tottch)

label variable perelem "percentage of elementary schools"

save, replace
clear


***********
*********trend and trend square variable*
***********

use temp_final

generate trend=year-2009

generate trend2=trend*trend


save, replace
clear










