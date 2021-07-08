* Encoding: UTF-8.

************************************** Minimum Acceptable Diet - Sample Syntax v05.11.2015 **************************************

*For calcuation of proportion of children aged 6-23 months who meet requirements for a minimum acceptable diet.

*Syntax provided here is a SAMPLE ONLY. Should be modified at CO level where needed to adapt to the local context and align with 
in-country data collection tools and platforms. 

*The Minimum Acceptable Diet (MAD) indicator was designed to measure the proportion of children who receive a minimum acceptable diet.  
*The MAD indicator is made up of two separate indicators: dietary diversity and meal frequency, and takes into account 
the child's age and whether he/she is breastfed to determine whether the MAD threshold for diet acceptability has been reached.

*The methodology is based on the guidance document: "Indicators for assessing infant and young child feeding practices part 2: measurement" 
from the World Health Organization. Dept. of Child and Adolescent Health and Development, 2010.

*Syntax developed by WFP Nutrition HQ with assistance from South Sudan CO and based on "MICS5 NU-08 v02 - 2014-03-05" syntax provided 
by Unicef at http://www.childinfo.org/mics5_processing.html .

*Variable names are based on IYCF survey module, which can be found at this link: 
http://whqlibdoc.who.int/publications/2010/9789241599290_eng.pdf?ua=1 .

*Syntax edited Nov 2015 to reflect revision to Nutrition M&E guidance on the allocation of SNFs to the Flesh Food category (previously counted under Grains, Roots, and Tubers) . 

* Minimum dietary diversity (for both breastfed and non-breastfed children):
     Children who received food from at least 4 of the food groups listed above.

* Minimum meal frequency:
    a) If currently breastfed:
       i) Age 6-8 months: Solid, semi-solid, or soft foods at least two times (IYCF14>=2)
      ii) Age 9-23 months: Solid, semi-solid, or soft foods at least three times (IYCF14>=3)
   b) If not currently breastfed: 
	Must receive at least 2 milk feeds:  (IYCF11B + IYCF11C + IYCF11F >= 2) 
	Must consume solid, semi-solid, or soft foods (of which at least 2 are milk feeds), at least 4 times: (IYCF11B + IYCF11C + IYCF11F + IYCF14 >= 4) .

* Minimum acceptable diet:
   a) Currently breastfed:
      Children who received the minimum dietary diversity and the minimum meal frequency as per age groups defined above
   b) Currently not breastfed:
      Children who received the minimum meal frequency, at least 2 milk feeds, and the minimum dietary diversity (calculated based 
      on 6 food groups only - dairy excluded).



**********************************************************************************************************************************************.


get file = "PCMADRepeat623.sav".

*Recode missing values to zero.  
recode   PCIYCInfFormNb PCIYCDairyMiNb  PCIYCDairyYoNb PCIYCStapPoNb(sysmis=0).

SELECT IF (MAD_resp_age >=6 AND MAD_resp_age <24).

*Minimum dietary diversity - create variables for each food group.

*Minimum dietary diversity - create variables for each food group.

compute grainsRootsTubers = any(1, PCMADStapCer, PCMADStapRoo) .
IF MISSING(grainsRootsTubers) grainsRootsTubers=0.

compute legumesNuts = any(1, PCMADPulse) .
IF MISSING(legumesNuts) legumesNuts=0.

do if (PCIYCBreastF = 1) .
+ compute dairyProducts = any(1, PCMADDairy) .
end if.
IF (PCIYCBreastF=0 or MISSING(dairyProducts)) dairyProducts=0.

compute fleshFoods = any(1, PCMADPrMeatO, PCMADPrMeatF, PCMADPrEgg, PCMADSnfChild, PCMADSnfPowd, PCMADSnfLns) .
IF MISSING(fleshFoods) fleshFoods=0.

compute eggs = any(1, PCMADPrEgg) .
IF MISSING(eggs) eggs=0.

compute vitaminA = any(1, PCMADVegOrg, PCMADVegGre, PCMADFruitOrg, PCMADFatRpalm) .
IF MISSING(vitaminA) vitaminA=0.

compute other = any(1, PCMADVegFruitOth) .
IF MISSING(other) other=0.

compute minimumDietaryDiversity = sum(grainsRootsTubers, legumesNuts, dairyProducts, fleshFoods, eggs, vitaminA, other) >= 4 .
IF MISSING(minimumDietaryDiversity) minimumDietaryDiversity=0.

variable labels minimumDietaryDiversity "Min dietary diversity".
value labels minimumDietaryDiversity
  0 "Does not meet Min Diet Diversity"
  1 "Meets Min Diet Diversity".


*Minimum meal frequency for breastfed children.

do if (PCIYCBreastF  = 1) .
+ do if (MAD_resp_age >= 6.00 and MAD_resp_age <= 8.99).
+   compute minimumMealFrequency = PCIYCMeals>=2 .
+ else .
+   compute minimumMealFrequency = PCIYCMeals>=3 .
+ end if.
end if.

*Minimum meal frequency for non-breastfed children (must meet requirements for milk feeds and number of meals).

do if (PCIYCBreastF  = 0) .
+   compute atLeast2Milk = (PCIYCInfFormNb + PCIYCDairyMiNb +PCIYCDairyYoNb +PCIYCStapPoNb) >= 2 .
+   do if (atLeast2Milk).
+   compute minimumMealFrequency = (PCIYCInfFormNb + PCIYCDairyMiNb +PCIYCDairyYoNb +PCIYCStapPoNb) >= 4 .
+ end if.
end if.

IF MISSING(atLeast2Milk) atLeast2Milk=0.
IF MISSING(minimumMealFrequency) minimumMealFrequency=0.


variable labels minimumMealFrequency "Minimum Meal Frequency".
value labels minimumMealFrequency
  0 "Does not meet Min Meal Frequency"
  1 "Meets Min Meal Frequency".

variable labels atLeast2Milk "At least 2 milk feeds".
value labels atLeast2Milk
  0 "Does not meet at least 2 milk feeds"
  1 "Meets at least 2 milk feeds".


* Minimum acceptable diet for breastfed and non-breastfed children.

compute minimumAcceptableDiet = minimumDietaryDiversity & minimumMealFrequency .

variable labels minimumAcceptableDiet "Minimum Acceptable Diet".
value labels minimumAcceptableDiet
  0 "Does not meet Min Acceptable Diet"
  1 "Meets Min Acceptable Diet".



***************************************************Output tables****************************************************************************.

* Age by category.
recode MAD_resp_age
  (6.0 thru 11.999 = 1)
  (12.0 thru 17.999 = 2)
  (else = 3) into ageCat.
variable labels ageCat "Age".
value labels ageCat
  1 "6-11 months"
  2 "12-17 months"
  3 "18-23 months".


* Table - Proportion of children meeting MAD for each age group.

CTABLES
  /VLABELS VARIABLES=ageCat minimumAcceptableDiet DISPLAY=LABEL
  /TABLE ageCat [C] BY minimumAcceptableDiet [C][COUNT F40.0, ROWPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=ageCat ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES LABEL='Total, 6-23 mos' POSITION=AFTER
  /CATEGORIES VARIABLES=minimumAcceptableDiet ORDER=A KEY=VALUE EMPTY=INCLUDE.



