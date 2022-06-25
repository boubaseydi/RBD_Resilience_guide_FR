
**********************************************************************************************************************************************************************************
****************************************************************************************FCS, FCS-Nutrition *******************************************************************
**********************************************************************************************************************************************************************************..



** calculer le Score de Consommation Alimentaire (FCS)

compute FCS = sum(FCSStap*2, FCSPulse*3, FCSDairy*4, FCSPr*4, FCSVeg, FCSFruit, FCSFat*0.5, FCSSugar*0.5).
variable labels FCS "Score de Consommation Alimentaire".
EXECUTE.


*compute FCS = sum(FCS_cer*2, FCS_puls*3, FCS_milk*4, FCS_meat*4, FCS_veg, FCS_fruit, FCS_oil*0.5, FCS_sugar*0.5).
*variable labels FCS "Score de Consommation Alimentaire".
*EXECUTE.

*** Calculer  des groupes de consommation alimentaire à partir du score de consommation alimentaire - seuils 21/35 et 28/42s

recode FCS (0 thru 21 = 1) (21 thru 35 = 2) (35 thru highest = 3) into FCSCat21.
variable labels FCSCat21 "Groupes de Consommation Alimentaire - seuils 21/35".

recode FCS (0 thru 28 = 1) (28 thru 42 = 2) (42 thru highest = 3) into FCSCat28.
variable labels FCSCat28  "Groupes de Consommation Alimentaire  - seuils 28/42".

VALUE LABELS FCSCat21 FCSCat28 
1 "Pauvre"
2 "Limite"
3 "Acceptable".
EXECUTE.

*utiliser le seuil appropri? - 21 ou 28

RECODE FCSCat28 (1=4) (2=3) (3=1) INTO FCS_4pt.
VARIABLE LABELS FCS_4pt '4pt FCG'.
EXECUTE.

* Define Variable Properties.
*FCS_4pt.
VALUE LABELS FCS_4pt
 1.00 'acceptable'
 3.00 'limite'
 4.00 'pauvre'.
EXECUTE.

*% of hhs consuming more than 4 food groups per week.

do if  sum(FCSStap, FCSPulse, FCSDairy, FCSPr, FCSVeg, FCSFruit, FCSFat, FCSSugar)>3.
compute consume4fgrouporplus=1.
ELSE.
compute  consume4fgrouporplus=0. 
END IF.

VARIABLE LABELS consume4fgrouporplus "hhs consuming more than 4 food groups per week.".
EXECUTE. 

VALUE LABELS consume4fgrouporplus
 1 'Oui'
 0 'Non'.
EXECUTE.


** calculate Score de Consommation Alimentaire Nutrition (FCS-N)

compute FGVitA = sum(FCSDairy, FCSPrMeatO, FCSPrEgg, FCSVegOrg, FCSVegGre, FCSFruitOrg).
variable labels FGVitA "Consommation d'aliments riches en vitamine A".

compute FGProtein = sum(FCSPulse, FCSDairy, FCSPrMeatF, FCSPrMeatO, FCSPrFish, FCSPrEgg).
variable labels FGProtein "Consommation d'aliments riches en protiéine".

compute FGHIron = sum(FCSPrMeatF, FCSPrMeatO, FCSPrFish).
variable labels FGHIron "Consommation d'aliments riches en fer".

*** recoder en groupes basés sur la consommation 

RECODE FGVitA (0=1) (1 thru 6=2) (7 thru 42=3) INTO FGVitACat.
variable labels FGVitACat "Consommation d'aliments riches en vitamine A".

RECODE FGProtein (0=1) (1 thru 6=2) (7 thru 42=3) INTO FGProteinCat.
variable labels FGProteinCat "Consommation d'aliments riches en protiéine".

RECODE FGHIron (0=1) (1 thru 6=2) (7 thru 42=3) INTO FGHIronCat.
variable labels  FGHIronCat "Consommation d'aliments riches en fer".

*** define variables labels and properties for " FGVitACat FGProteinCat FGHIronCat ".

VALUE LABELS FGVitACat FGProteinCat FGHIronCat
1.00 '0 jours'
2.00 '1-6 jours'
3.00 '7 jours'.
EXECUTE.

**********************************************************************************************************************************************************************************
****************************************************************************Food Expenditure Share**************************************************************************
**********************************************************************************************************************************************************************************.


*recod all missing (NA) to zero

RECODE HHExpFCer_1M_MN HHExpFCer_1M_CRD HHExpFCer_1M_GiftAid HHExpFCer_1M_Own HHExpFTub_1M_MN HHExpFTub_1M_CRD HHExpFTub_1M_GiftAid HHExpFTub_1M_Own HHExpFPuls_1M_MN 
HHExpFPuls_1M_CRD HHExpFPuls_1M_GiftAid HHExpFPuls_1M_Own HHExpFVeg_1M_MN HHExpFVeg_1M_CRD HHExpFVeg_1M_GiftAid HHExpFVeg_1M_Own HHExpFFrt_1M_MN HHExpFFrt_1M_CRD 
HHExpFFrt_1M_GiftAid HHExpFFrt_1M_Own HHExpFAnimMeat_1M_MN HHExpFAnimMeat_1M_CRD HHExpFAnimMeat_1M_GiftAid HHExpFAnimMeat_1M_Own HHExpFAnimFish_1M_MN HHExpFAnimFish_1M_CRD 
HHExpFAnimFish_1M_GiftAid HHExpFAnimFish_1M_Own HHExpFFats_1M_MN HHExpFFats_1M_CRD HHExpFFats_1M_GiftAid HHExpFFats_1M_Own HHExpFDairy_1M_MN HHExpFDairy_1M_CRD HHExpFDairy_1M_GiftAid 
HHExpFDairy_1M_Own HHExpFAnimEgg_1M_MN HHExpFAnimEgg_1M_CRD HHExpFAnimEgg_1M_GiftAid HHExpFAnimEgg_1M_Own HHExpFSgr_1M_MN HHExpFSgr_1M_CRD HHExpFSgr_1M_GiftAid HHExpFSgr_1M_Own 
HHExpFBeverage_1M_MN HHExpFBeverage_1M_CRD HHExpFBeverage_1M_GiftAid HHExpFBeverage_1M_Own HHExpFOut_1M_MN HHExpFOut_1M_CRD HHExpFOut_1M_GiftAid HHExpFOut_1M_Own 
HHExpNFHyg_1M_GiftAid HHExpNFHyg_1M_MN HHExpNFHyg_1M_CRD HHExpNFTransp_1M_MN HHExpNFTransp_1M_CRD HHExpNFTransp_1M_GiftAid HHExpNFWat_1M_MN 
HHExpNFWat_1M_CRD,HHExpNFWat_1M_GiftAid,HHExpNFElec_1M_MN,HHExpNFElec_1M_CRD,HHExpNFElec_1M_GiftAid,HHExpNFEnerg_1M_MN,HHExpNFEnerg_1M_CRD,HHExpNFEnerg_1M_GiftAid,
HHExpNFDwelServ_1M_MN,HHExpNFDwelServ_1M_CRD,HHExpNFDwelServ_1M_GiftAid,HHExpNFPhone_1M_MN,HHExpNFPhone_1M_CRD,HHExpNFPhone_1M_GiftAid,HHExpNFAlcTobac_1M_MN,HHExpNFAlcTobac_1M_CRD,
HHExpNFAlcTobac_1M_GiftAid HHExpNFMedServ_6M_MN,HHExpNFMedServ_6M_CRD,HHExpNFMedServ_6M_GiftAid,HHExpNFMedGood_6M_MN,HHExpNFMedGood_6M_CRD,HHExpNFMedGood_6M_GiftAid,HHExpNFCloth_6M_MN,HHExpNFCloth_6M_CRD,
HHExpNFCloth_6M_GiftAid,HHExpNFEduFee_6M_MN,HHExpNFEduFee_6M_CRD,HHExpNFEduFee_6M_GiftAid,HHExpNFEduGood_6M_MN,HHExpNFEduGood_6M_CRD,HHExpNFEduGood_6M_GiftAid,HHExpNFRent_6M_MN,
HHExpNFRent_6M_CRD,HHExpNFRent_6M_GiftAid,HHExpNFHHSoft_6M_MN,HHExpNFHHSoft_6M_CRD,HHExpNFHHSoft_6M_GiftAid,HHExpNFSav_6M_Tot,HHExpNFDebt_6M_Tot,HHExpNFInsurance_6M_Tot(SYSMIS=0).
EXECUTE.

*compute 1 month food expenses

COMPUTE food_monthly=sum(HHExpFCer_1M_MN,HHExpFCer_1M_CRD,HHExpFCer_1M_GiftAid,HHExpFCer_1M_Own,HHExpFTub_1M_MN,HHExpFTub_1M_CRD,HHExpFTub_1M_GiftAid,HHExpFTub_1M_Own,HHExpFPuls_1M_MN,
HHExpFPuls_1M_CRD,HHExpFPuls_1M_GiftAid,HHExpFPuls_1M_Own,HHExpFVeg_1M_MN,HHExpFVeg_1M_CRD,HHExpFVeg_1M_GiftAid,HHExpFVeg_1M_Own,HHExpFFrt_1M_MN,HHExpFFrt_1M_CRD,
HHExpFFrt_1M_GiftAid,HHExpFFrt_1M_Own,HHExpFAnimMeat_1M_MN,HHExpFAnimMeat_1M_CRD,HHExpFAnimMeat_1M_GiftAid,HHExpFAnimMeat_1M_Own,HHExpFAnimFish_1M_MN,HHExpFAnimFish_1M_CRD,
HHExpFAnimFish_1M_GiftAid,HHExpFAnimFish_1M_Own,HHExpFFats_1M_MN,HHExpFFats_1M_CRD,HHExpFFats_1M_GiftAid,HHExpFFats_1M_Own,HHExpFDairy_1M_MN,HHExpFDairy_1M_CRD,HHExpFDairy_1M_GiftAid,
HHExpFDairy_1M_Own,HHExpFAnimEgg_1M_MN,HHExpFAnimEgg_1M_CRD,HHExpFAnimEgg_1M_GiftAid,HHExpFAnimEgg_1M_Own,HHExpFSgr_1M_MN,HHExpFSgr_1M_CRD,HHExpFSgr_1M_GiftAid,HHExpFSgr_1M_Own,
HHExpFBeverage_1M_MN,HHExpFBeverage_1M_CRD,HHExpFBeverage_1M_GiftAid,HHExpFBeverage_1M_Own,HHExpFOut_1M_MN,HHExpFOut_1M_CRD,HHExpFOut_1M_GiftAid,HHExpFOut_1M_Own).
VARIABLE LABELS food_monthly 'Dépenses alimentaires du ménage au cours du mois'.
EXECUTE.

*compute 1 month short term nonfood expenses

COMPUTE nonfood1_monthly=sum(HHExpNFHyg_1M_GiftAid,HHExpNFHyg_1M_MN,HHExpNFHyg_1M_CRD,HHExpNFTransp_1M_MN,HHExpNFTransp_1M_CRD,HHExpNFTransp_1M_GiftAid,HHExpNFWat_1M_MN,
HHExpNFWat_1M_CRD,HHExpNFWat_1M_GiftAid,HHExpNFElec_1M_MN,HHExpNFElec_1M_CRD,HHExpNFElec_1M_GiftAid,HHExpNFEnerg_1M_MN,HHExpNFEnerg_1M_CRD,HHExpNFEnerg_1M_GiftAid,
HHExpNFDwelServ_1M_MN,HHExpNFDwelServ_1M_CRD,HHExpNFDwelServ_1M_GiftAid,HHExpNFPhone_1M_MN,HHExpNFPhone_1M_CRD,HHExpNFPhone_1M_GiftAid,HHExpNFAlcTobac_1M_MN,HHExpNFAlcTobac_1M_CRD,
HHExpNFAlcTobac_1M_GiftAid).
VARIABLE LABELS nonfood1_monthly 'Dépenses à court terme non alimentaires des ménages au cours du mois '.
EXECUTE.

*compute 1 month longterm nonfood expenses

COMPUTE nonfood2_monthly=sum(HHExpNFMedServ_6M_MN,HHExpNFMedServ_6M_CRD,HHExpNFMedServ_6M_GiftAid,HHExpNFMedGood_6M_MN,HHExpNFMedGood_6M_CRD,HHExpNFMedGood_6M_GiftAid,HHExpNFCloth_6M_MN,HHExpNFCloth_6M_CRD,
HHExpNFCloth_6M_GiftAid,HHExpNFEduFee_6M_MN,HHExpNFEduFee_6M_CRD,HHExpNFEduFee_6M_GiftAid,HHExpNFEduGood_6M_MN,HHExpNFEduGood_6M_CRD,HHExpNFEduGood_6M_GiftAid,HHExpNFRent_6M_MN,
HHExpNFRent_6M_CRD,HHExpNFRent_6M_GiftAid,HHExpNFHHSoft_6M_MN,HHExpNFHHSoft_6M_CRD,HHExpNFHHSoft_6M_GiftAid,HHExpNFSav_6M_Tot,HHExpNFDebt_6M_Tot,HHExpNFInsurance_6M_Tot)/6.
VARIABLE LABELS nonfood2_monthly 'Dépenses à long terme non alimentaires des ménages au cours du mois'.
EXECUTE.

*compute food expenditure share and food expenditure share categories

COMPUTE FoodExp_share= food_monthly/sum(food_monthly, nonfood1_monthly, nonfood2_monthly).
VARIABLE LABELS FoodExp_share 'part des dépenses alimentaires des ménages'.

RECODE FoodExp_share (Lowest thru .49=1) (.50 thru .649=2) (.65 thru .749=3) (.75 thru Highest=4)
 INTO Foodexp_4pt.
VARIABLE LABELS Foodexp_4pt 'catégories de répartition des dépenses alimentaires'.

VALUE LABELS Foodexp_4pt
1 'moins de 50%'
2 'entre 50 et 65%'
3 'entre 65 et 75%'
4 'plus de 75%'.
EXECUTE.


**********************************************************************************************************************************************************************************
*****************************************************Reduced Consumption Score Index************************************************************************************
**********************************************************************************************************************************************************************************.

*** Calculer rCSI.
DATASET ACTIVATE DataSet5.
compute rCSI = sum(rCSILessQlty,rCSIBorrow*2,rCSIMealSize,rCSIMealAdult*3,rCSIMealNb).

Variable labels rCSI "rCSI".

*** chaque menage devrait avoir un rCSI entre 0 et 56

**********************************************************************************************************************************************************************************
*****************************************************************Livelihood based Cooping  Strategies Index*********************I*******************************************
**********************************************************************************************************************************************************************************.

*** creer une variable  pour montrer si les strategies de stress etaient  "Oui"" ou "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire".
do if (LhCSIStress1 = 2) | (LhCSIStress1 = 3) |
(LhCSIStress2 = 2) | (LhCSIStress2 = 3) |
(LhCSIStress3 = 2) | (LhCSIStress3 = 3) |
(LhCSIStress4 = 2) | (LhCSIStress4 = 3).
compute stress_coping = 1.
ELSE.
compute stress_coping = 0.
end if.
variable labels stress_coping "le ménage s'est-il engagé dans des stratégies  du stress ?".
value labels stress_coping
0 "Non"
1 "Oui".
*** creer une variable  pour montrer si les strategies de crises etaient  "Oui"" ou "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire"

do if (LhCSICrisis1 = 2) | (LhCSICrisis1 = 3) |
(LhCSICrisis2 = 2) | (LhCSICrisis2 = 3) |
(LhCSICrisis3 = 2) | (LhCSICrisis3 = 3).
compute crisis_coping = 1.
ELSE.
compute crisis_coping = 0.
end if.
variable labels crisis_coping "le ménage s'est-il engagé dans des stratégies d'adaptation aux crises ?".
value labels crisis_coping
0 "Non"
1 "Oui".

*** creer une variable  pour montrer si les strategies de urgences etaient  "Oui"" ou "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire".
do if (LhCSIEmergency1 = 2) | (LhCSIEmergency1  = 3) |
(LhCSIEmergency2 = 2) | (LhCSIEmergency2  = 3) |
(LhCSIEmergency3  = 2) | (LhCSIEmergency3 = 3).
compute emergency_coping = 1.
ELSE.
compute emergency_coping = 0.
end if.
variable labels emergency_coping "le ménage s'est-il engagé dans des stratégies d'adaptation d'urgence ?".
value labels emergency_coping
0 "Non"
1 "Oui".
*** recoder les variables pour calculer une variable de la stratégie d'adaptation la plus sévère utilisée.
recode stress_coping (0=0) (1=2).
recode crisis_coping (0=0) (1=3).
recode emergency_coping (0=0) (1=4).
compute LhCSICat=max(stress_coping, crisis_coping, emergency_coping).
recode LhCSICat (0=1).
Value labels LhCSICat 1 "Pasdestrategies" 2 "StrategiesdeStress" 3 "StrategiesdeCrise" 4 "StrategiesdUrgence".
Variable Labels LhCSICat = "Catégories de stratégies d'adaptation aux moyens d'existence - version léger  de CARI".
EXECUTE.

**********************************************************************************************************************************************************************************
*******Calcul du CARI.****************************************************************************************************************************************
**********************************************************************************************************************************************************************************.
DATASET ACTIVATE DataSet13.
recode FCSCat28 (3=1) (2=3) (1=4) into CARI_CS.
EXECUTE.
if (rCSI>=4 and FCSCat28=3) CARI_CS =2. 
EXECUTE.
VALUE LABELS CARI_CS
 1 'Food Secure'
 2 'Marginally Food Secure'
 3 'Moderately Food Insecure'
 4 'Severely Food Insecure'.
EXECUTE.

compute CARI_Inc_stat=Foodexp_4pt. 

VALUE LABELS CARI_Inc_stat
 1 'Food Secure'
 2 'Marginally Food Secure'
 3 'Moderately Food Insecure'
 4 'Severely Food Insecure'.
EXECUTE.

compute CARI_CC=RND(SUM(CARI_Inc_stat,LhCSICat)/2).
EXECUTE.

compute CARI=RND(SUM(CARI_CS,CARI_CC)/2).
EXECUTE.

VALUE LABELS CARI
 1 'Food Secure'
 2 'Marginally Food Secure'
 3 'Moderately Food Insecure'
 4 'Severely Food Insecure'.
EXECUTE.


**********************************************************************************************************************************************************************************
**********************************************Minimum Diet Diversity-Woman ************************************************************************************************
**********************************************************************************************************************************************************************************.

* Constitution des groupes alimentaires pour les FEMMES 15-49 ans

* Groupe des cereales et tubercules

do if (PWMDDWStapCer=1 or PWMDDWStapRoo=1).
compute GR_Certuber=1.
ELSE.
compute GR_Certuber=0.
end if.
EXECUTE.

     * Groupe des Légumineuses 

do if (PWMDDWPulse=1).
compute GR_Legumineuse=1.
ELSE.
compute GR_Legumineuse=0.
end if.
EXECUTE.

  * Groupe des graines

do if (PWMDDWNuts=1).
compute GR_Graine=1.
ELSE.
compute GR_Graine=0.
end if.
EXECUTE.

  * Groupe des produits laitiers

do if (PWMDDWDairy=1).
compute GR_Lait=1.
ELSE.
compute GR_Lait=0.
end if.
EXECUTE.

* Groupe Poisson, fruits de mer,  viande

do if (PWMDDWPrMeatO=1 or PWMDDWPrMeatF=1 or PWMDDWPrFish=1).
compute GR_Pois.Viand=1.
ELSE.
compute GR_Pois.Viand=0.
end if.
EXECUTE.

  * Groupe des Oeufs

do if (PWMDDWPrEgg=1).
compute GR_Oeufs=1.
ELSE.
compute GR_Oeufs=0.
end if.
EXECUTE.

  * Groupe des legumes-feuilles verts foncés

do if (PWMDDWVegGre=1).
compute GR_Legume.feuille=1.
ELSE.
compute GR_Legume.feuille=0.
end if.
EXECUTE.

* Groupe Fruits, Legumes riches en vitamine A

do if (PWMDDWVegOrg=1 or PWMDDWFruitOrg=1).
compute GR_Fruit.Leg.richvitA=1.
ELSE.
compute GR_Fruit.Leg.richvitA=0.
end if.
EXECUTE.

  * Groupe des autres legumes

do if (PWMDDWVegOth=1).
compute GR_autre.Legume=1.
ELSE.
compute GR_autre.Legume=0.
end if.
EXECUTE.

  * Groupe des autres fruits

do if (PWMDDWFruitOth=1).
compute GR_autre.Fruit=1.
ELSE.
compute GR_autre.Fruit=0.
end if.
EXECUTE.

* Calcul de la diversité alimentaire minimum pour les FEMMES 15-49 ans

COMPUTE W_MDD=sum(GR_Certuber,GR_Legumineuse,GR_Graine,GR_Lait,GR_Pois.Viand,GR_Oeufs,
    GR_Legume.feuille,GR_Fruit.Leg.richvitA,GR_autre.Legume,GR_autre.Fruit).
VARIABLE LABELS  W_MDD "Diversité Alimentaire Minimum pour les Femmes 15-49 ans".
EXECUTE.

*  Diversité alimentaire minimum des Femmes en CLASSES

RECODE W_MDD (0 thru 4=1) (5 thru 10=2) INTO W_MDD_class.
VARIABLE LABELS  W_MDD_class 'Diversité alimentaire minimum en 2 classes'.
EXECUTE.
variable labels W_MDD_class "Diversité alimentaire minimum en 2 classes".
value labels W_MDD_class
  1 "N'a pas atteint le MDD"
  2 "a atteint le MDD".
EXECUTE.


* Custom Tables.
CTABLES
  /VLABELS VARIABLES=FCSCat21 FCSCat28 consume4fgrouporplus FGVitACat FGProteinCat FGHIronCat 
    Foodexp_4pt LhCSICat W_MDD_class Section2_8 
    DISPLAY=LABEL
  /TABLE FCSCat21 [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + FCSCat28 [C][COUNT F40.0, COLPCT.COUNT 
    PCT40.1] + consume4fgrouporplus [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + FGVitACat [C][COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + FGProteinCat [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + FGHIronCat [C][COUNT 
    F40.0, COLPCT.COUNT PCT40.1] + Foodexp_4pt [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + LhCSICat 
    [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + W_MDD_class [C][COUNT F40.0, COLPCT.COUNT PCT40.1] BY 
    Section2_8 [C]
  /CATEGORIES VARIABLES=FCSCat21 FCSCat28 consume4fgrouporplus FGVitACat FGProteinCat FGHIronCat 
    Foodexp_4pt LhCSICat W_MDD_class Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES 
    POSITION=AFTER.




* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Section2_8 rCSI DISPLAY=LABEL
  /TABLE Section2_8 [C] BY rCSI [MEAN, STDDEV]
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.

**********************************************************************************************************************************************************************************
***********************************************************************MAD*****************************************************************************************************
**********************************************************************************************************************************************************************************.
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


*Recode missing values to zero.  
recode   PCIYCInfFormNb PCIYCDairyMiNb  PCIYCDairyYoNb PCIYCStapPoNb(sysmis=0).


USE ALL.
COMPUTE filter_$=(MAD_resp_age >= 6 & MAD_resp_age < 24).
VARIABLE LABELS filter_$ 'MAD_resp_age >= 6 & MAD_resp_age < 24 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

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

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Section2_8 minimumAcceptableDiet DISPLAY=LABEL
  /TABLE Section2_8 [C][COUNT F40.0, ROWPCT.COUNT PCT40.1] BY minimumAcceptableDiet [C]
  /CATEGORIES VARIABLES=Section2_8 minimumAcceptableDiet ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES 
    POSITION=AFTER.

USE ALL.
EXECUTE.







***********************************************************************************************************************************************************************************.
*****************************************************************Calcul du Shock exposure index***************************************************************************** .
***********************************************************************************************************************************************************************************.
*Le calcul de cet indicator sera différent de la manière dont il a été décrit. En effet dans le guide d'origine cet indicateur est égal à la moyenne pondérée des chocs subis par le ménage au cours des,.
* 12 derniers mois avec le poids correspondant à la gravtité du choc sur le revenu et la SAN du ménage.

 
****************.
MISSING VALUES GraviteImpactRevenusPluies GraviteImpactSANPluies (888,8888) .
EXECUTE.

*Calcul de la gravité du choc.
Compute GreviteshockPluies=sum(GraviteImpactRevenusPluies,GraviteImpactSANPluies).
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_pluies=Pluies_12m*GreviteshockPluies.
EXECUTE. 
****************.

MISSING VALUES GraviteImpactRevenusSecheresse GraviteImpactSANSecheresse  (888,8888) .
EXECUTE.

*Calcul de la gravité du choc.
Compute GreviteshockSecheresse=sum(GraviteImpactRevenusSecheresse,GraviteImpactSANSecheresse).
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_Secheresse=Secheresse_12m*GreviteshockSecheresse.
EXECUTE. 
****************.
MISSING VALUES GraviteImpactSANGlissementterrain  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_Glissementterrain=Glissementterrain_12m*GraviteImpactSANGlissementterrain.
EXECUTE. 

****************.

MISSING VALUES GraviteImpactSANMauvaisesHerb  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_Maladiescultures=Maladiescultures_12m*GraviteImpactSANMauvaisesHerb.
EXECUTE. 

****************.

MISSING VALUES GraviteImpactSANMauvaisesHerb  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_RavageursCultures=RavageursCultures_12m*GraviteImpactSANMauvaisesHerb.
EXECUTE. 

****************.

MISSING VALUES GraviteImpactSANMauvaisesHerb  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_MauvaisesHeres=MauvaisesHeres_12m*GraviteImpactSANMauvaisesHerb.
EXECUTE. 


****************.

MISSING VALUES GraviteImpactSANMaladiesBetails  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_MaladiesBetails=MaladiesBetails_12m*GraviteImpactSANMaladiesBetails.
EXECUTE. 


****************.

MISSING VALUES GraviteImpactSANEpidemies  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_Epidemies=Epidemies_12m*GraviteImpactSANEpidemies.
EXECUTE. 


****************.

MISSING VALUES GraviteImpactSANVolsDestructionBiens  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_VolsDestructionBiens=VolsDestructionBiens_12m*GraviteImpactSANVolsDestructionBiens.
EXECUTE. 


****************.

MISSING VALUES GraviteImpactSANVolBetails  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_VolBetails=VolBetails_12m*GraviteImpactSANVolBetails.
EXECUTE. 

****************.

MISSING VALUES GraviteImpactSANRetardsAideHumanitaire  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_RetardsAideHumanitaire=RetardsAideHumanitaire_12m*GraviteImpactSANRetardsAideHumanitaire.
EXECUTE. 

****************.

MISSING VALUES GraviteImpactSANAugPrixAliments  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_AugPrixAliments=AugPrixAliments_12m*GraviteImpactSANAugPrixAliments.
EXECUTE. 


****************.
MISSING VALUES GraviteImpactSANAugmPrixIntrants  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_AugmPrixIntrants=AugmPrixIntrants_12m*GraviteImpactSANAugmPrixIntrants.
EXECUTE. 

****************.
MISSING VALUES GraviteImpactSANBaissePrixAgriElev  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_BaissePrixAgriElev=BaissePrixAgriElev_12m*GraviteImpactSANBaissePrixAgriElev.
EXECUTE. 

****************.
MISSING VALUES GraviteImpactSANPertesTerres  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_PertesTerres=PertesTerres_12m*GraviteImpactSANPertesTerres.
EXECUTE. 

****************.
MISSING VALUES GraviteImpactSANChomagejeune  (888,8888) .
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_Chomagejeune=Chomagejeune_12m*GraviteImpactSANChomagejeune.
EXECUTE. 


****************.
MISSING VALUES GraviteImpactRevenusDecesMembreMenage GraviteImpactSANDecesMembreMenage (888,8888) .
EXECUTE.

*Calcul de la gravité du choc.
Compute GreviteshockDecesMembreMenage=sum(GraviteImpactRevenusDecesMembreMenage,GraviteImpactSANDecesMembreMenage).
EXECUTE.

*Calcul de la composante de l'indicateur Schock Eposure Index (SEI).
Compute SEI_DecesMembreMenage=DecesMembreMenage_12m*GreviteshockDecesMembreMenage.
EXECUTE. 

****************.

compute ShockExposureIdex1=sum(SEI_pluies,SEI_secheresse,SEI_Glissementterrain,SEI_Maladiescultures,SEI_RavageursCultures,SEI_MauvaisesHeres,SEI_MaladiesBetails,SEI_Epidemies,SEI_VolsDestructionBiens,SEI_VolBetails).
EXECUTE.
compute ShockExposureIdex2=sum(SEI_RetardsAideHumanitaire, SEI_AugPrixAliments,SEI_AugmPrixIntrants,SEI_BaissePrixAgriElev,SEI_PertesTerres,SEI_Chomagejeune,SEI_DecesMembreMenage).
EXECUTE.
compute ShockExposureIdex=sum(ShockExposureIdex1,ShockExposureIdex2).
EXECUTE.
VARIABLE LABELS ShockExposureIdex "Shock Exposure Index".
EXECUTE.




DELETE VARIABLES SEI_pluies SEI_secheresse SEI_Glissementterrain SEI_Maladiescultures SEI_RavageursCultures SEI_MauvaisesHeres SEI_MaladiesBetails SEI_Epidemies SEI_VolsDestructionBiens SEI_VolBetails.
DELETE VARIABLES SEI_RetardsAideHumanitaire SEI_AugPrixAliments SEI_AugmPrixIntrants SEI_BaissePrixAgriElev SEI_PertesTerres SEI_Chomagejeune SEI_DecesMembreMenage.
EXECUTE.

*******************************************************************************************************************************************************************************************************.
**************************************************	Ability to recover index *****************************************************************************************************************.
*******************************************************************************************************************************************************************************************************.


compute AbilitytoRecoverIndex1=sum(CACRetabCapAlimPluies,CACRetabCapAlim_1yPluies).
compute AbilitytoRecoverIndex2=sum(CACRetabCapAlimSecheresse, CACRetabCapAlim_1ySecheresse). 
compute AbilitytoRecoverIndex3=sum(CACRetabCapAlimGlissementterrain,CACRetabCapAlim_1yGlissementterrain).
compute AbilitytoRecoverIndex4=sum(CACRetabCapAlimMauvaisesHerb,CACRetabCapAlim_1yMauvaisesHerb).
compute AbilitytoRecoverIndex5=sum(CACRetabCapAlimMauvaisesHerb,CACRetabCapAlim_1yMauvaisesHerb).
compute AbilitytoRecoverIndex6=sum(CACRetabCapAlimMauvaisesHerb,CACRetabCapAlim_1yMauvaisesHerb).
compute AbilitytoRecoverIndex7=sum(CACRetabCapAlimMaladiesBetails,CACRetabCapAlim_1yMaladiesBetails).
compute AbilitytoRecoverIndex8=sum(CACRetabCapAlimEpidemies,CACRetabCapAlim_1yEpidemies).
compute AbilitytoRecoverIndex9=sum(CACRetabCapAlimVolsDestructionBiens,CACRetabCapAlim_1yVolsDestructionBiens).
compute AbilitytoRecoverIndex10=sum(CACRetabCapAlimVolBetails,CACRetabCapAlim_1yVolBetails).
compute AbilitytoRecoverIndex11=sum(CACRetabCapAlimRetardsAideHumanitaire,CACRetabCapAlim_1yRetardsAideHumanitaire).
compute AbilitytoRecoverIndex12=sum(CACRetabCapAlimAugPrixAliments,CACRetabCapAlim_1yAugPrixAliments).
compute AbilitytoRecoverIndex13=sum(CACRetabCapAlimAugmPrixIntrants,CACRetabCapAlim_1yAugmPrixIntrants).
compute AbilitytoRecoverIndex14=sum(CACRetabCapAlimBaissePrixAgriElev,CACRetabCapAlim_1yBaissePrixAgriElev).
compute AbilitytoRecoverIndex15=sum(CACRetabCapAlimPertesTerres,CACRetabCapAlim_1yPertesTerres).
compute AbilitytoRecoverIndex16=sum(CACRetabCapAlimChomagejeune,CACRetabCapAlim_1yChomagejeune).
compute AbilitytoRecoverIndex17=sum(CACRetabCapAlimDecesMembreMenage,CACRetabCapAlim_1yDecesMembreMenage).
execute. 

compute AbilitytoRecoverIndex_a=MEAN(AbilitytoRecoverIndex1,AbilitytoRecoverIndex2,AbilitytoRecoverIndex3, AbilitytoRecoverIndex4, AbilitytoRecoverIndex5, AbilitytoRecoverIndex6, AbilitytoRecoverIndex7, AbilitytoRecoverIndex8, AbilitytoRecoverIndex9).
Execute. 
compute AbilitytoRecoverIndex_b=MEAN(AbilitytoRecoverIndex10, AbilitytoRecoverIndex11,AbilitytoRecoverIndex12,AbilitytoRecoverIndex13, AbilitytoRecoverIndex14, AbilitytoRecoverIndex15, AbilitytoRecoverIndex16, AbilitytoRecoverIndex17).
EXECUTE.
compute AbilitytoRecoverIndex=MEAN(AbilitytoRecoverIndex_a,AbilitytoRecoverIndex_b). 
EXECUTE.
DELETE VARIABLES AbilitytoRecoverIndex_a AbilitytoRecoverIndex_b. 

*********************************************************************************************************************************************************.
*********************************************************	Bonding Captital Index ***********************************************************************.
***************************************************************************************************************************************************************************.
RECODE SCIAideIntraCom SCIAideDehorsCom SCIPersAiderDehorsCom (1=1) (4=0) (2=2) (3=3).
MISSING VALUES SCIAideIntraCom (888,8888).
EXECUTE. 

*Il est important de noter que dans les prochaines collectes la première question, SCIAideIntraCom, devra être en choix multiples et non en choix unique. 

compute BondingCapcitalIndex=sum(SCIAideIntraCom,SCIPersAAiderCom.1, SCIPersAAiderCom.2, SCIPersAAiderCom.3).

VARIABLE LABELS BondingCapcitalIndex "Bonding Captital Index".
EXECUTE.


********************************************************************************************************************************.
*********************************************************	Bridging Captital Index *******************************************.
*******************************************************************************************************************************.
MISSING VALUES SCIAideDehorsCom SCIPersAiderDehorsCom (888,8888).

*Lors des prochaines collectes les deux questions ci-dessous,SCIAideDehorsCom et SCIPersAiderDehorsCom,   devront être en choix multiples et non en choix unique. 
 
compute BridgingCapcitalIndex=sum(SCIAideDehorsCom,SCIPersAiderDehorsCom).

VARIABLE LABELS BridgingCapcitalIndex "Bridging Captital Index".
EXECUTE.


********************************************************************************************************************************.
*************************************************************************************	SERS *****************************.
***********************************************************************************************************************************************.
DATASET ACTIVATE DataSet10.
*** Calculer SERS.

RECODE SERSRebondir (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser1.
VARIABLE LABELS  ser1 'sers1'.

RECODE SERSDifficultes (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser2.
VARIABLE LABELS  ser2 'sers2'.

RECODE SERSMoyen (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser3.
VARIABLE LABELS  ser3 'sers3'.

RECODE SERSRevenue (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser4.
VARIABLE LABELS  ser4 'sers4'.

RECODE SERSSurvivre (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser5.
VARIABLE LABELS  ser5 'sers5'.

RECODE SERSFamAmis (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser6.
VARIABLE LABELS  ser6 'sers6'.

RECODE SERSPoliticiens (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser7.
VARIABLE LABELS  ser7 'sers7'.

RECODE SERSLecons (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser8.
VARIABLE LABELS  ser8 'sers8'.

RECODE SERSPreparerFuture (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser9.
VARIABLE LABELS  ser9 'sers9'.

RECODE SERSAvertissementEven (5=1) (4=2) (3=3) (2=4) (1=5) INTO ser10.
VARIABLE LABELS  ser10 'sers10'.
EXECUTE.

compute serab = sum(ser5,ser3)/2.
EXECUTE.

compute SERS = sum(serab,ser1,ser2,ser4,ser6,ser7,ser8,ser9,ser10)/9.
Variable labels SERS "Subjectively Evaluated Resilience Score".
EXECUTE.


compute Anticipatory_Cap = (ser9-1)/4*100.
Variable labels Anticipatory_Cap "Anticipatory capacity ".
EXECUTE.
RECODE Anticipatory_Cap (0 thru 32.5=1) (32.6 thru 65.5=2) (65.6 thru HIGHEST=3) INTO Anticipatory_Cap_Categories.
VARIABLE LABELS  Anticipatory_Cap_Categories 'Anticipatory capacity categories'.
EXECUTE.
VALUE LABELS Anticipatory_Cap_Categories
  1 "Anticipatory_Cap Faible"
  2 "Anticipatory_Cap moyen"
  3 "Anticipatory_Cap élevé".
EXECUTE.


compute Absorptive_Cap = (ser1-1)/4*100.
Variable labels Absorptive_Cap "Absorptive capacity ".
EXECUTE.
RECODE Absorptive_Cap (0 thru 32.5=1) (32.6 thru 65.5=2) (65.6 thru HIGHEST=3) INTO Absorptive_Cap_Categories.
VARIABLE LABELS  Absorptive_Cap_Categories 'Absorptive capacity categories'.
EXECUTE.
VALUE LABELS Absorptive_Cap_Categories
  1 "Absorptive_Cap Faible"
  2 "Absorptive_Cap moyen"
  3 "Absorptive_Cap élevé".
EXECUTE.


compute Transformative_cap = (ser4-1)/4*100.
Variable labels Transformative_cap "Transformative capacity ".
EXECUTE.
RECODE Transformative_cap (0 thru 32.5=1) (32.6 thru 65.5=2) (65.6 thru HIGHEST=3) INTO Transformative_cap_Categories.
VARIABLE LABELS  Transformative_cap_Categories 'Transformative capacity categories'.
EXECUTE.
VALUE LABELS Transformative_cap_Categories
  1 "Transformative_cap Faible"
  2 "Transformative_cap moyen"
  3 "Transformative_cap élevé".
EXECUTE.

compute Adaptive_cap = (serab-1)/4*100.
Variable labels Adaptive_cap "Adaptive capacity ".
EXECUTE.
RECODE Adaptive_cap (0 thru 32.5=1) (32.6 thru 65.5=2) (65.6 thru HIGHEST=3) INTO Adaptive_cap_Categories.
VARIABLE LABELS  Adaptive_cap_Categories 'Adaptive capacity categories'.
EXECUTE.
VALUE LABELS Adaptive_cap_Categories
  1 "Adaptive_cap Faible"
  2 "Adaptive_cap moyen"
  3 "Adaptive_cap élevé".
EXECUTE.

compute RCS = (sum(serab,ser1,ser2,ser4,ser6,ser7,ser8,ser9,ser10)/9-1)/4*100.
Variable labels RCS "Resilience Capacity Score".
EXECUTE.
RECODE RCS (0 thru 32.5=1) (32.6 thru 65.5=2) (65.6 thru HIGHEST=3) INTO RCS_Categories.
VARIABLE LABELS  RCS_Categories 'Resilience Capacity Score categories'.
EXECUTE.
VALUE LABELS RCS_Categories
  1 "RCS Faible"
  2 "RCS moyen"
  3 "RCS élevé".
EXECUTE.

ONEWAY FCS rCSI FoodExp_share BY RCS_Categories
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS
  /POSTHOC=TUKEY ALPHA(0.05).

*
IF  (DATEDIFF(DATE.DMY(01,09,2021),DebutAssistance,"days")>0) benefAvantSEPT2021=1.
*EXECUTE.
*RECODE benefAvantSEPT2021 (SYSMIS=0).
*EXECUTE.

****************************************************************************************************************************************************************************.
***************Proportion de ménages qui dispose d’un  membre qui est member d’un groupe d’épargne (tontine*) et ou qui fait de l’épargne sur pieds*.
*****************************************************************************************************************************************************************************.

IF  (MembreGroupeEpargne=1 | EpargnePieds=1) Mng_Epargne=1.
EXECUTE.
recode Mng_Epargne (MISSING=0).
VARIABLE LABELS Mng_Epargne "Menage avec un membre particpant a un groupe d epargne ou qui fait epargne sur pied".

VALUE LABELS
Mng_Epargne
1 "Oui"
0 "Non".
EXECUTE. 




**************************************************************************************************************************************************************************.
***************ABI % of the population in targeted communities reporting benefits from an enhanced livelihood asset base*.
***************************************************************************************************************************************************************************.

*Calcul du ABI. 

RECODE ABIProteger ABIProduction ABIdifficultes ABIMarches ABIGererActifs ABIEnvironnement 
    ABIutiliseractifs ABITensions (1=0) (2=1) (3=SYSMIS).
EXECUTE.

compute ABI = sum(ABIProteger, ABIProduction, ABIdifficultes, ABIMarches, ABIGererActifs ,ABIEnvironnement, ABIutiliseractifs, ABITensions)/8.
Variable labels ABI "Asset Benefit Indicatorr".
EXECUTE.

*DATASET ACTIVATE DataSet6.
*RECODE q762_actifconstruit q763_actifaugmenter q764_actifartisanat q765_actifaccesmarches q766_actifamelcapacites q767_actifameenvir 
q768_actifamefonc q769_actifpotentielagricole q7610_actifrestauterres q7611_actifmeilleurhygene (1=1) (0=0) (2=SYSMIS).
*EXECUTE.

*compute ABI = sum(q762_actifconstruit,q763_actifaugmenter,q764_actifartisanat,q765_actifaccesmarches, q766_actifamelcapacites,q767_actifameenvir,
q768_actifamefonc,q769_actifpotentielagricole,q7610_actifrestauterres,q7611_actifmeilleurhygene)/10.
*EXECUTE.
*Variable labels ABI "Asset Benefit Indicatorr".
*EXECUTE.

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=ABIParticipation ABI DISPLAY=LABEL
  /TABLE ABIParticipation [C] BY ABI [S][MEAN, COUNT F40.0, MAXIMUM, MEDIAN, MINIMUM]
  /CATEGORIES VARIABLES=ABIParticipation ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.


********************************************************************************************************************************************************************************************************************************************.
**	% d’individus ayant des connaissances sur et des capacités à mettre en œuvre de bonnes pratiques d’adaptation au changement climatique *****************************.
********************************************************************************************************************************************************************************************************************************.

*Connaissances des bonnes pratiques d'apadation aux chnagements climatiques. 

IF  (techconsamelioree=1  | Diversifrotatculture=1 | Destockagetempsutile=1 | 
    technameliorpaturage=1) ConnaispratiquechgmClim=1.
VARIABLE LABELS  ConnaispratiquechgmClim "Connaissance des bonnes pratiques d'adaptation au changement climatique".
EXECUTE.

RECODE ConnaispratiquechgmClim (SYSMIS=0).
EXECUTE.

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=ConnaispratiquechgmClim DISPLAY=LABEL
  /TABLE ConnaispratiquechgmClim [C][COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=ConnaispratiquechgmClim ORDER=A KEY=VALUE EMPTY=EXCLUDE.

*Capacités d'Application des bonnes pratiques d'adaptation aux changements climatiques. 

IF  (Appltechconsamelioree=1  | ApplDiversifrotatculture=1 | ApplDestockagetempsutile=1 | 
Appltechnameliorpaturage=1| Formationtechagridestockage=1 | Formationtechagritechpaturage=1 | 
Formationtechagridispoeau=1 ) CapacApplipratiquechgmClim=1.
*J'ai ajouté dans le calcul l'application des bonnes pratiques d'elavage vu que la question de savoir s'ils ont les capacités d'appliquer ces pratiques n'a pas été posée.
VARIABLE LABELS  CapacApplipratiquechgmClim "Capacités Application des pratiques d'adaptation aux changements climatiques".
EXECUTE.

RECODE CapacApplipratiquechgmClim (SYSMIS=0).
EXECUTE.

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=CapacApplipratiquechgmClim DISPLAY=LABEL
  /TABLE CapacApplipratiquechgmClim [COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=CapacApplipratiquechgmClim ORDER=A KEY=VALUE EMPTY=EXCLUDE.

**********************************************************************************************************************************************.
****************	% of households who integrate adaptation measures in their activities/livelihoods*****************************.
***********************************************************************************************************************************************.
If (bonnespratiquesmenage.1=1 | bonnespratiquesmenage.2=1 | bonnespratiquesmenage.3=1 |
bonnespratiquesmenage.4=1 | bonnespratiquesmenage.5=1 | bonnespratiquesmenage.6=1 | bonnespratiquesmenage.7=1 ) 
ApplipratiquechgmClim=1. 

VARIABLE LABELS  ApplipratiquechgmClim "Application des pratiques d'adaptation aux changements climatiques".
EXECUTE.
RECODE ApplipratiquechgmClim (SYSMIS=0).
EXECUTE.

VALUE LABELS
ApplipratiquechgmClim
1 "Oui"
0 "Non".
EXECUTE. 

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=ApplipratiquechgmClim DISPLAY=LABEL
  /TABLE ApplipratiquechgmClim [COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=ApplipratiquechgmClim ORDER=A KEY=VALUE EMPTY=INCLUDE.

************************************************************************************************************************************************.
**	% de ménages avec un membre ayant migré ou parti en exode à cause de difficultés alimentaires*****************************.
************************************************************************************************************************************************.
If (RaisonMigration=4 | RaisonMigration=5) MigrationdiffAlimentaire=1. 
RECODE MigrationdiffAlimentaire (SYSMIS=0).
EXECUTE.
VARIABLE LABELS MigrationdiffAlimentaire "Ménage avec un membre ayant migré à cause de difficultés alimentaire ou en année de crise alimentaire".

VALUE LABELS
MigrationdiffAlimentaire
1 "Oui"
0 "Non".
EXECUTE. 

***********************************************************************************************************************************************************.
**	******************************************************Pourcentage de perte post-récolte*********************************************************.
************************************************************************************************************************************************.

COMPUTE pctpertepostrecolte=QPertpostrecol*100/SUM(qtrecoltemil,qtrecolteniebe,qtrecoltesorgho,
    qtrecoltearachide,qtrecolteautrespec,qtrecoltesalade,qtrecoltetomate,qtrecolteoignon,
    qtrecoltepommedeterre,qtrecolteautrelegume).
VARIABLE LABELS pctpertepostrecolte "Pourcentage perte post-récolte".
EXECUTE.

if (SUM(qtrecoltemil,qtrecolteniebe,qtrecoltesorgho,
    qtrecoltearachide,qtrecolteautrespec,qtrecoltesalade,qtrecoltetomate,qtrecolteoignon,
    qtrecoltepommedeterre,qtrecolteautrelegume)=0 and QPertpostrecol<>0) pctpertepostrecolte=100.
EXECUTE.

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 pctpertepostrecolte DISPLAY=LABEL
  /TABLE Section2_8 [C] > pctpertepostrecolte [S][MEAN, COUNT F40.0, MAXIMUM, MEDIAN, MINIMUM]
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.

************************************************************************************************************************************************.
****************	% de ménages qui comptent laisser leurs enfants terminer le primaire, le secondaire*****************************.
************************************************************************************************************************************************.


* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 FillesPrimterminer FillesSecterminer DISPLAY=LABEL
  /TABLE Section2_8 [C][COUNT F40.0, ROWPCT.COUNT PCT40.1] BY FillesPrimterminer [C] + 
    FillesSecterminer [C]
  /CATEGORIES VARIABLES=Section2_8 FillesPrimterminer ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES 
    POSITION=AFTER
  /CATEGORIES VARIABLES=FillesSecterminer ORDER=A KEY=VALUE EMPTY=INCLUDE.

RECODE FillesSecterminer FillesPrimterminer (1=1) (SYSMIS=0) (2=1).
EXECUTE.

************************************************************************************************************************************************.
**	% d’individus qui ont eu une opportunité d’emploi ou un emploi plus stable grâce aux actifs créés par le programme de resilience **********************.
************************************************************************************************************************************************.

if (ActifCreationEmploi=1 | BeneficieEmploi=1) OpportEmploi=1. 
RECODE OpportEmploi  (SYSMIS=0).
EXECUTE.
VARIABLE LABELS OpportEmploi "Opportunité d'emploi ou emploi plus stable grace aux actifs crés/réhabilités".

VALUE LABELS
OpportEmploi
1 "Oui"
0 "Non".
EXECUTE. 


* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 OpportEmploi DISPLAY=LABEL
  /TABLE Section2_8 [C][COUNT F40.0, ROWPCT.COUNT PCT40.1] BY OpportEmploi
  /CATEGORIES VARIABLES=Section2_8 OpportEmploi ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES 
    POSITION=AFTER.



************************************************************************************************************************************************.
**********************Nombre de mois de couverture des stocks alimentaires*********************************** **********************.
************************************************************************************************************************************************.


* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 NbMoisCouvert DISPLAY=LABEL
  /TABLE Section2_8 [C] BY NbMoisCouvert [MEAN, COUNT F40.0, MAXIMUM, MEDIAN, MINIMUM]
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.


************************************************************************************************************************************************.
*************************************************************Rendement agricole************************************************************.
************************************************************************************************************************************************.
COMPUTE Rendementgdculture=SUM(qtrecoltemil,qtrecolteniebe,qtrecoltesorgho,qtrecoltearachide,
    qtrecolteautrespec)/sum(SuperficieCultiveemil,SuperficieCultiveeniebe,SuperficieCultiveesorgho,
    SuperficieCultiveearachide,SuperficieCultiveeautrespec).
VARIABLE LABELS  Rendementgdculture "Rendrement des grande cultures".
EXECUTE.

COMPUTE rendementpdtmaraicher=sum(qtrecoltesalade,qtrecoltetomate,qtrecolteoignon,
    qtrecoltepommedeterre,qtrecolteautrelegume)/sum(SuperficieCultiveesalade,SuperficieCultiveetomate,
    SuperficieCultiveeoignon,SuperficieCultiveepommedeterre,SuperficieCultiveeautrelegume).
VARIABLE LABELS  rendementpdtmaraicher "Rendrement des cultures maraîchères".
EXECUTE.

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 Rendementgdculture rendementpdtmaraicher DISPLAY=LABEL
  /TABLE Section2_8 [C] > (Rendementgdculture [MEAN, COUNT F40.0, MAXIMUM, MEDIAN, MINIMUM] + 
    rendementpdtmaraicher [MEAN, COUNT F40.0, MAXIMUM, MEDIAN, MINIMUM])
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.



************************************************************************************************************************************************.
***************% de femmes qui disposent des conaissances de transformations de produits locaux nutritifs**********************.
**************% de femmes qui ont intégré dans l’alimentation de leurs nourissons les produits nutritifs localement transformés. 
************************************************************************************************************************************************.
RECODE MaitriseTech ApplicationTech (1=1) (2=1).
EXECUTE.

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 MaitriseTech ApplicationTech DISPLAY=LABEL
  /TABLE Section2_8 [C][COUNT F40.0, ROWPCT.COUNT PCT40.1] BY MaitriseTech + ApplicationTech
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=MaitriseTech ApplicationTech ORDER=A KEY=VALUE EMPTY=INCLUDE.

************************************************************************************************************************************************.
*******************************************Production maraîchère Moyenne par ménage  **********************.**************
************************************************************************************************************************************************.
COMPUTE pdtmaraichere=sum(qtrecoltesalade,qtrecoltetomate,qtrecolteoignon,qtrecoltepommedeterre,
    qtrecolteautrelegume).
VARIABLE LABELS  pdtmaraichere 'production maraîchère moyenne'.
EXECUTE.


**************************************************************************************************************************************************
***************Proportion of households where women, men, or both women and men make decisions on the use *****************
of food / cash / vouchers, disaggregated by transfer modality (WFP 2020: 229) *******************************************************
**************************************************************************************************************************************************.

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 Section5_19 DISPLAY=LABEL
  /TABLE Section2_8 [ROWPCT.COUNT PCT40.1] BY Section5_19
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=Section5_19 ORDER=A KEY=VALUE EMPTY=INCLUDE.


**************************************************************************************************************************************************
**************************************Reduction de la charge de travail des femmes  *******************************************************
**************************************************************************************************************************************************.



* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 ABIdifficultes DISPLAY=LABEL
  /TABLE Section2_8 [C] BY ABIdifficultes [C][ROWPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=ABIdifficultes ORDER=A KEY=VALUE EMPTY=INCLUDE.


**********************************************************************************************************************************************************************************
******Proportion of women/men that feel it is possible/easy for them to raise concerns with local leaders/influential people (Suich et al. 2020: 14-15)*********
**********************************************************************************************************************************************************************************.

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 CapaciteInterpellerLeaders DISPLAY=LABEL
  /TABLE Section2_8 [C][ROWPCT.COUNT PCT40.1] BY CapaciteInterpellerLeaders
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=CapaciteInterpellerLeaders ORDER=A KEY=VALUE EMPTY=INCLUDE.



**********************************************************************************************************************************************************************************
******% de ménages ayant rapporté une plus forte collaboration entre transhumants et agriculteurs residents*****************************************************
**********************************************************************************************************************************************************************************.

if ((Q_2_1_pincipal_activite=2 | Q_2_2_pincipal_activite=2 ) & (AppreciationInterTransh=4 | AppreciationInterTransh=5)) |
 ((Q_2_1_pincipal_activite=3 | Q_2_2_pincipal_activite=3) & (AppreciationInterAgric=4 | AppreciationInterAgric=5)) fortecollaborationAgriTransh=1. 

*Chad.
*if ((AppreciationInterTransh=4 | AppreciationInterTransh=5)) |
 ((AppreciationInterAgric=4 | AppreciationInterAgric=5)) fortecollaborationAgriTransh=1. 

RECODE fortecollaborationAgriTransh  (SYSMIS=0).
EXECUTE.
VARIABLE LABELS fortecollaborationAgriTransh "Forte collaboration entre Agriculteurs et transhumants".

VALUE LABELS
fortecollaborationAgriTransh
1 "Oui"
0 "Non".
EXECUTE. 

**********************************************************************************************************************************************************************************
******% de groupes communautaires ayant rapporté une plus forte collaboration entre déplacés et communauté hôtes******************************************
**********************************************************************************************************************************************************************************.
if ((Section2_9=2) & (AppreciationInterdeplaces=4 | AppreciationInterdeplaces=5)) |
 ((Section2_9=1) & (AppreciationInterhote=4 | AppreciationInterhote=5)) fortecollaborationIDPhote=1. 

*Chad. 
if ((AppreciationInterdeplaces=4 | AppreciationInterdeplaces=5)) |
 ((AppreciationInterhote=4 | AppreciationInterhote=5)) fortecollaborationIDPhote=1. 
RECODE fortecollaborationIDPhote  (SYSMIS=0).
EXECUTE.
VARIABLE LABELS fortecollaborationIDPhote "Forte collaboration entre IDP et populations hôtes".

VALUE LABELS
fortecollaborationIDPhote
1 "Oui"
0 "Non".
EXECUTE. 

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=fortecollaborationAgriTransh fortecollaborationIDPhote DISPLAY=LABEL
  /TABLE fortecollaborationAgriTransh [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    fortecollaborationIDPhote [COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=fortecollaborationAgriTransh fortecollaborationIDPhote ORDER=A KEY=VALUE 
    EMPTY=INCLUDE.



**********************************************************************************************************************************************************************************
******Proportion of households whose children benefit from school canteens *******************************************************************************************
**********************************************************************************************************************************************************************************.


* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=CantineScolaire DISPLAY=LABEL
  /TABLE CantineScolaire [COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=CantineScolaire ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.



******************************************************************************************************************.
*EBI Proportion of the population in targeted communities reporting environmental benefits
*.
*******************************************************************************************************************.

*Calcul du EBI. 

Compute EBI = sum(ABIProduction, ABIEnvironnement)/2.
EXECUTE.
Variable labels EBI "Environment Benefit Indicatorr".
EXECUTE.


* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=Section2_8 EBI DISPLAY=LABEL
  /TABLE Section2_8 > EBI [MEAN]
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.





**********************************************************************************************************************************************************************************
******Percentage of community members who report reduced tensions over natural resource access and use (PRO-P) *******************************************
**********************************************************************************************************************************************************************************.

* Custom Tables.
CTABLES
  /FORMAT EMPTY=BLANK MISSING='.'
  /HIDESMALLCOUNTS COUNT=2
  /SMISSING VARIABLE
  /VLABELS VARIABLES=ABITensions Section2_8 DISPLAY=LABEL
  /TABLE ABITensions [COUNT F40.0, COLPCT.COUNT PCT40.1] BY Section2_8 [C]
  /CATEGORIES VARIABLES=ABITensions ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=Section2_8 ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.


******************************************************************************************************************************************.
***************************************************************CHAD********************************************************************.
*******************************************************************************************************************************************.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Mng_Epargne ConnaispratiquechgmClim CapacApplipratiquechgmClim 
    ApplipratiquechgmClim MigrationdiffAlimentaire FillesPrimterminer FillesSecterminer OpportEmploi 
    MaitriseTech ApplicationTech ABIdifficultes CapaciteInterpellerLeaders fortecollaborationAgriTransh 
    fortecollaborationIDPhote CantineScolaire ABITensions Existencededettes HHHSex 
    DISPLAY=LABEL
  /TABLE Mng_Epargne [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + ConnaispratiquechgmClim [C][COUNT 
    F40.0, COLPCT.COUNT PCT40.1] + CapacApplipratiquechgmClim [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    ApplipratiquechgmClim [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + MigrationdiffAlimentaire [C][COUNT 
    F40.0, COLPCT.COUNT PCT40.1] + FillesPrimterminer [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    FillesSecterminer [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + OpportEmploi [C][COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + MaitriseTech [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + ApplicationTech 
    [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + ABIdifficultes [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    CapaciteInterpellerLeaders [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + fortecollaborationAgriTransh 
    [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + fortecollaborationIDPhote [C][COUNT F40.0, COLPCT.COUNT 
    PCT40.1] + CantineScolaire [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + ABITensions [C][COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + Existencededettes [C][COUNT F40.0, COLPCT.COUNT PCT40.1] BY HHHSex [C]
  /CATEGORIES VARIABLES=Mng_Epargne ConnaispratiquechgmClim CapacApplipratiquechgmClim 
    ApplipratiquechgmClim MigrationdiffAlimentaire FillesPrimterminer FillesSecterminer OpportEmploi 
    MaitriseTech ApplicationTech ABIdifficultes CapaciteInterpellerLeaders fortecollaborationAgriTransh 
    fortecollaborationIDPhote CantineScolaire ABITensions Existencededettes HHHSex ORDER=A KEY=VALUE 
    EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=ShockExposureIdex AbilitytoRecoverIndex ABI RevenuMonetaire 
    pctpertepostrecolte pdtmaraichere NbMoisCouvert Rendementgdculture rendementpdtmaraicher SERS 
    BondingCapcitalIndex BridgingCapcitalIndex HHHSex 
    DISPLAY=LABEL
  /TABLE ShockExposureIdex [S][MEAN, STDDEV, MEDIAN] + AbilitytoRecoverIndex [S][MEAN, STDDEV, 
    MEDIAN] + ABI [S][MEAN, STDDEV, MEDIAN] + RevenuMonetaire [S][MEAN, STDDEV, MEDIAN] + 
    pctpertepostrecolte [S][MEAN, STDDEV, MEDIAN] + pdtmaraichere [S][MEAN, STDDEV, MEDIAN] + 
    NbMoisCouvert [S][MEAN, STDDEV, MEDIAN] + Rendementgdculture [S][MEAN, STDDEV, MEDIAN] + 
    rendementpdtmaraicher [S][MEAN, STDDEV, MEDIAN] + pdtmaraichere [S][MEAN, STDDEV, MEDIAN] + SERS 
    [S][MEAN, STDDEV, MEDIAN] + BondingCapcitalIndex [S][MEAN, STDDEV, MEDIAN] + BridgingCapcitalIndex 
    [S][MEAN, STDDEV, MEDIAN] BY HHHSex [C]
  /CATEGORIES VARIABLES=HHHSex ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.




* Custom Tables.
CTABLES
  /VLABELS VARIABLES=CARI SERS DISPLAY=LABEL
  /TABLE CARI BY SERS [MEAN, STDDEV]
  /CATEGORIES VARIABLES=CARI ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER.


********************************************************************************************************************************************.
***************************************Analyse de la relation entre l'exposition aux chocs et la SAN*************************. 
**********************************************************************************************************************************************************.
*******Chad.
do if (Pluies_12m=2 or Secheresse_12m=2 or Glissementterrain_12m=2 or Maladiescultures_12m =2 or 
RavageursCultures_12m=2 or MauvaisesHeres_12m=2 or MaladiesBetails_12m=2 or Epidemies_12m=2 or
VolsDestructionBiens_12m=2 or VolBetails_12m=2 or RetardsAideHumanitaire_12m=2 or
AugPrixAliments_12m=2 or AugmPrixIntrants_12m=2 or BaissePrixAgriElev_12m=2 or PertesTerres_12m=2 or
Chomagejeune_12m=2 or DecesMembreMenage_12m=2).
compute vecu_choc=1.
ELSE.
compute vecu_choc=0.
end if. 
recode vecu_choc (1=1) (SYSMIS=0). 
EXECUTE.


********************************************************.
********************************** Burkina FAso. 
********************************************************.
do if (Pluies_12m=1 or Secheresse_12m=1 or Glissementterrain_12m=1 or Maladiescultures_12m =1 or 
RavageursCultures_12m=1 or MauvaisesHeres_12m=1 or MaladiesBetails_12m=1 or Epidemies_12m=1 or
VolsDestructionBiens_12m=1 or VolBetails_12m=1 or RetardsAideHumanitaire_12m=1 or
AugPrixAliments_12m=1 or AugmPrixIntrants_12m=1 or BaissePrixAgriElev_12m=1 or PertesTerres_12m=1 or
Chomagejeune_12m=1 or DecesMembreMenage_12m=1).
compute vecu_choc=1.
ELSE.
compute vecu_choc=0.
end if. 
recode vecu_choc (1=1) (SYSMIS=0). 
EXECUTE.


do IF  (GraviteImpactRevenusPluies=3 or GraviteImpactRevenusPluies=4 or GraviteImpactSANPluies=3 or 
    GraviteImpactSANPluies=4 or GraviteImpactRevenusSecheresse=3 or GraviteImpactRevenusSecheresse=4 or 
    GraviteImpactSANSecheresse=3 or GraviteImpactSANSecheresse=4 or GraviteImpactSANGlissementterrain=3 
    or GraviteImpactSANGlissementterrain=4 or GraviteImpactSANMauvaisesHerb=3 or GraviteImpactSANMauvaisesHerb=4 or
 GraviteImpactSANMauvaisesHerb@4a1c=3 or  GraviteImpactSANMauvaisesHerb@4a1c=4 or
GraviteImpactSANMauvaisesHerb@2477=3 or   GraviteImpactSANMauvaisesHerb@2477=4  or GraviteImpactSANMaladiesBetails=3 or 
    GraviteImpactSANMaladiesBetails=4 or GraviteImpactSANEpidemies=3 or GraviteImpactSANEpidemies=4 or 
    GraviteImpactSANVolsDestructionBiens=3 or GraviteImpactSANVolsDestructionBiens=4 or 
    GraviteImpactSANVolBetails=3 or GraviteImpactSANVolBetails=4 or 
    GraviteImpactSANRetardsAideHumanitaire=3 or GraviteImpactSANRetardsAideHumanitaire=4 or 
    GraviteImpactSANAugPrixAliments=3 or GraviteImpactSANAugPrixAliments=4 or 
    GraviteImpactSANAugmPrixIntrants=3 or GraviteImpactSANAugmPrixIntrants=4 or 
    GraviteImpactSANBaissePrixAgriElev=3 or GraviteImpactSANBaissePrixAgriElev=4 or 
    GraviteImpactSANPertesTerres=3 or GraviteImpactSANPertesTerres=4 or GraviteImpactSANChomagejeune=3 
   or GraviteImpactSANChomagejeune=4 or GraviteImpactRevenusDecesMembreMenage=3 or 
    GraviteImpactRevenusDecesMembreMenage=4 or GraviteImpactSANDecesMembreMenage=3 or 
    GraviteImpactSANDecesMembreMenage=4). 
compute Fort_impactshock=2.
ELSE.
compute Fort_impactshock=0.
end if.
RECODE Fort_impactshock (SYSMIS=0).
EXECUTE.

if (Fort_impactshock=0 and vecu_choc=1) Fort_impactshock=1. 
EXECUTE.

************************************************************************************.
*********************************************Niger. 
************************************************************************************.

do IF  (GraviteImpactRevenusPluies=3 or GraviteImpactRevenusPluies=4 or GraviteImpactSANPluies=3 or 
    GraviteImpactSANPluies=4 or GraviteImpactRevenusSecheresse=3 or GraviteImpactRevenusSecheresse=4 or 
    GraviteImpactSANSecheresse=3 or GraviteImpactSANSecheresse=4 or GraviteImpactSANGlissementterrai=3 
    or GraviteImpactSANGlissementterrai=4 or GraviteImpactSANMauvaisesHerb=3 or GraviteImpactSANMauvaisesHerb=4 or
GraviteImpactSANMauvaisesHerb_8e=3 or  GraviteImpactSANMauvaisesHerb_8e=4 or
GraviteImpactSANMauvaisesHerb_66=3 or   GraviteImpactSANMauvaisesHerb_66=4  or GraviteImpactSANMaladiesBetails=3 or 
    GraviteImpactSANMaladiesBetails=4 or GraviteImpactSANEpidemies=3 or GraviteImpactSANEpidemies=4 or 
    GraviteImpactSANVolsDestructionB=3 or GraviteImpactSANVolsDestructionB=4 or 
    GraviteImpactSANVolBetails=3 or GraviteImpactSANVolBetails=4 or 
    GraviteImpactSANRetardsAideHuman=3 or GraviteImpactSANRetardsAideHuman=4 or 
    GraviteImpactSANAugPrixAliments=3 or GraviteImpactSANAugPrixAliments=4 or 
    GraviteImpactSANAugmPrixIntrants=3 or GraviteImpactSANAugmPrixIntrants=4 or 
    GraviteImpactSANBaissePrixAgriEl=3 or GraviteImpactSANBaissePrixAgriEl=4 or 
    GraviteImpactSANPertesTerres=3 or GraviteImpactSANPertesTerres=4 or GraviteImpactSANChomagejeune=3 
   or GraviteImpactSANChomagejeune=4 or GraviteImpactRevenusDecesMembreM=3 or 
    GraviteImpactRevenusDecesMembreM=4 or GraviteImpactSANDecesMembreMenage=3 or 
    GraviteImpactSANDecesMembreMenage=4). 
compute Fort_impactshock=2.
ELSE.
compute Fort_impactshock=0.
end if.
RECODE Fort_impactshock (SYSMIS=0).
EXECUTE.

if (Fort_impactshock=0 and vecu_choc=1) Fort_impactshock=1. 
EXECUTE.


************************************************************************************.
***********************************************************Mauritanie.
************************************************************************************.
DATASET ACTIVATE DataSet5. 
Do iF (GraviteImpactRevenus=3 or GraviteImpactRevenus=4 or GraviteImpactSAN=3 or GraviteImpactSAN=4). 
compute Fort_impactshock=2.
ELSE.
compute Fort_impactshock=0.
end if.
RECODE Fort_impactshock (SYSMIS=0).
EXECUTE.

if (Fort_impactshock=0 and vecu_choc=1) Fort_impactshock=1. 
EXECUTE.


* Custom Tables.
CTABLES
  /VLABELS VARIABLES=CARI Fort_impactshock DISPLAY=LABEL
  /TABLE CARI [C][COLPCT.COUNT PCT40.1] BY Fort_impactshock [C]
  /CATEGORIES VARIABLES=CARI ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=Fort_impactshock ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /SIGTEST TYPE=CHISQUARE ALPHA=0.05 INCLUDEMRSETS=YES CATEGORIES=ALLVISIBLE.

ONEWAY Mng_Epargne ConnaispratiquechgmClim CapacApplipratiquechgmClim ApplipratiquechgmClim 
    MigrationdiffAlimentaire FillesPrimterminer FillesSecterminer OpportEmploi MaitriseTech 
    ApplicationTech ABIdifficultes CapaciteInterpellerLeaders InteravecAgric AppreciationInterAgric 
    Interavecdeplaces AppreciationInterdeplaces Interavechote AppreciationInterhote CantineScolaire 
    ABITensions Existencededettes BY FCS
  /MISSING ANALYSIS.

NONPAR CORR
  /VARIABLES=FCS rCSI FoodExp_share ShockExposureIdex AbilitytoRecoverIndex RevenuMonetaire 
    NbMoisCouvert BondingCapcitalIndex BridgingCapcitalIndex EBI
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE.

ONEWAY Mng_Epargne ConnaispratiquechgmClim CapacApplipratiquechgmClim ApplipratiquechgmClim 
    MigrationdiffAlimentaire FillesPrimterminer FillesSecterminer OpportEmploi MaitriseTech 
    ApplicationTech ABIdifficultes CapaciteInterpellerLeaders InteravecAgric AppreciationInterAgric 
    Interavecdeplaces AppreciationInterdeplaces Interavechote AppreciationInterhote CantineScolaire 
    ABITensions Existencededettes BY rCSI
  /MISSING ANALYSIS.



USE ALL.
COMPUTE filter_$=(Fort_impactshock<>0).
VARIABLE LABELS filter_$ 'Fort_impactshock<>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Fort_impactshock ABIdifficultes ABITensions Existencededettes 
    FillesPrimterminer FillesSecterminer TechTransformation MaitriseTech ApplicationTech 
    CapaciteInterpellerLeaders reductiontension AppreciationInterTransh AppreciationInterAgric 
    AppreciationInterdeplaces AppreciationInterhote Mng_Epargne ConnaispratiquechgmClim 
    CapacApplipratiquechgmClim ApplipratiquechgmClim MigrationdiffAlimentaire OpportEmploi CARI 
    FCSCat28 Foodexp_4pt LhCSICat 
    DISPLAY=LABEL
  /TABLE Fort_impactshock [C] > (ABIdifficultes [ROWPCT.COUNT PCT40.1] + ABITensions [ROWPCT.COUNT 
    PCT40.1] + Existencededettes [ROWPCT.COUNT PCT40.1] + FillesPrimterminer [ROWPCT.COUNT PCT40.1] + 
    FillesSecterminer [ROWPCT.COUNT PCT40.1] + TechTransformation [ROWPCT.COUNT PCT40.1] + MaitriseTech 
    [ROWPCT.COUNT PCT40.1] + ApplicationTech [ROWPCT.COUNT PCT40.1] + CapaciteInterpellerLeaders 
    [ROWPCT.COUNT PCT40.1] + reductiontension [ROWPCT.COUNT PCT40.1] + AppreciationInterTransh 
    [ROWPCT.COUNT PCT40.1] + AppreciationInterAgric [ROWPCT.COUNT PCT40.1] + AppreciationInterdeplaces 
    [ROWPCT.COUNT PCT40.1] + AppreciationInterhote [ROWPCT.COUNT PCT40.1] + Mng_Epargne [ROWPCT.COUNT 
    PCT40.1] + ConnaispratiquechgmClim [ROWPCT.COUNT PCT40.1] + CapacApplipratiquechgmClim 
    [ROWPCT.COUNT PCT40.1] + ApplipratiquechgmClim [ROWPCT.COUNT PCT40.1] + MigrationdiffAlimentaire 
    [ROWPCT.COUNT PCT40.1] + OpportEmploi [ROWPCT.COUNT PCT40.1]) BY CARI [C] + FCSCat28 + Foodexp_4pt 
    + LhCSICat
  /CATEGORIES VARIABLES=Fort_impactshock ABIdifficultes ABITensions Existencededettes 
    FillesPrimterminer FillesSecterminer TechTransformation MaitriseTech ApplicationTech 
    CapaciteInterpellerLeaders reductiontension AppreciationInterTransh AppreciationInterAgric 
    AppreciationInterdeplaces AppreciationInterhote Mng_Epargne ConnaispratiquechgmClim 
    CapacApplipratiquechgmClim ApplipratiquechgmClim MigrationdiffAlimentaire OpportEmploi FCSCat28 
    Foodexp_4pt LhCSICat ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=CARI [4.00, 3.00, 2.00, 1.00, OTHERNM] EMPTY=INCLUDE TOTAL=YES 
    POSITION=AFTER
  /SIGTEST TYPE=CHISQUARE ALPHA=0.05 INCLUDEMRSETS=YES CATEGORIES=ALLVISIBLE.

