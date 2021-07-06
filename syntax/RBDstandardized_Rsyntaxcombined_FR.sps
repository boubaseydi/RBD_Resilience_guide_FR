* Encoding: UTF-8.
GET  FILE='exampledataFrancais_raw.sav'.
DATASET NAME DataSet1 WINDOW=FRONT.


* calculer le Score de Consommation Alimentaire (FCS)

compute FCS = sum(FCSStap*2, FCSPulse*3, FCSDairy*4, FCSPr*4, FCSVeg, FCSFruit, FCSFat*0.5, FCSSugar*0.5).
variable labels FCS "Score de Consommation Alimentaire".
EXECUTE.
** calculer  des groupes de consommation alimentaire � partir du score de consommation alimentaire - seuils 21/35 et 28/42s

recode FCS (0 thru 21 = 1) (21 thru 35 = 2) (35 thru highest = 3) into FCSCat21.
variable labels FCSCat21 "Groupes de Consommation Alimentaire - seuils 21/35".
recode FCS (0 thru 28 = 1) (28 thru 42 = 2) (42 thru highest = 3) into FCSCat28.
variable labels FCSCat28  "Groupes de Consommation Alimentaire  - seuils 28/42".
EXECUTE.

VALUE LABELS FCSCat21 FCSCat28 
1 "Pauvre"
2 "Limite"
3 "Acceptable".
EXECUTE.
*utiliser le seuil appropri� - 21 ou 28

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

** calculate Score de Consommation Alimentaire Nutrition (FCS-N)

compute FGVitA = sum(FCSDairy, FCSPrMeatO, FCSPrEgg, FCSVegOrg, FCSVegGre, FCSFruitOrg).
variable labels FGVitA "Consommation d'aliments riches en vitamine A".
compute FGProtein = sum(FCSPulse, FCSDairy, FCSPrMeatF, FCSPrMeatO, FCSPrFish, FCSPrEgg).
variable labels FGProtein "Consommation d'aliments riches en proti�ine".
compute FGHIron = sum(FCSPrMeatF, FCSPrMeatO, FCSPrFish).
variable labels FGHIron "Consommation d'aliments riches en fer".
EXECUTE.
*** recoder en groupes bas�s sur la consommation 

RECODE FGVitA (0=1) (1 thru 6=2) (7 thru 42=3) INTO FGVitACat.
variable labels FGVitACat "Consommation d'aliments riches en vitamine A".
RECODE FGProtein (0=1) (1 thru 6=2) (7 thru 42=3) INTO FGProteinCat.
variable labels FGProteinCat "Consommation d'aliments riches en proti�ine".
RECODE FGHIron (0=1) (1 thru 6=2) (7 thru 42=3) INTO FGHIronCat.
variable labels  FGHIronCat "Consommation d'aliments riches en fer".
EXECUTE.
*** define variables labels and properties for " FGVitACat FGProteinCat FGHIronCat ".

VALUE LABELS FGVitACat FGProteinCat FGHIronCat
1 '0 jours'
2 '1-6 jours'
3 '7 jours'.
EXECUTE.

*D�penses 
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
VARIABLE LABELS food_monthly 'D�penses alimentaires du m�nage au cours du mois'.
EXECUTE.

*compute 1 month short term nonfood expenses

COMPUTE nonfood1_monthly=sum(HHExpNFHyg_1M_GiftAid,HHExpNFHyg_1M_MN,HHExpNFHyg_1M_CRD,HHExpNFTransp_1M_MN,HHExpNFTransp_1M_CRD,HHExpNFTransp_1M_GiftAid,HHExpNFWat_1M_MN,
HHExpNFWat_1M_CRD,HHExpNFWat_1M_GiftAid,HHExpNFElec_1M_MN,HHExpNFElec_1M_CRD,HHExpNFElec_1M_GiftAid,HHExpNFEnerg_1M_MN,HHExpNFEnerg_1M_CRD,HHExpNFEnerg_1M_GiftAid,
HHExpNFDwelServ_1M_MN,HHExpNFDwelServ_1M_CRD,HHExpNFDwelServ_1M_GiftAid,HHExpNFPhone_1M_MN,HHExpNFPhone_1M_CRD,HHExpNFPhone_1M_GiftAid,HHExpNFAlcTobac_1M_MN,HHExpNFAlcTobac_1M_CRD,
HHExpNFAlcTobac_1M_GiftAid).
VARIABLE LABELS nonfood1_monthly 'D�penses � court terme non alimentaires des m�nages au cours du mois '.
EXECUTE.

*compute 1 month longterm nonfood expenses

COMPUTE nonfood2_monthly=sum(HHExpNFMedServ_6M_MN,HHExpNFMedServ_6M_CRD,HHExpNFMedServ_6M_GiftAid,HHExpNFMedGood_6M_MN,HHExpNFMedGood_6M_CRD,HHExpNFMedGood_6M_GiftAid,HHExpNFCloth_6M_MN,HHExpNFCloth_6M_CRD,
HHExpNFCloth_6M_GiftAid,HHExpNFEduFee_6M_MN,HHExpNFEduFee_6M_CRD,HHExpNFEduFee_6M_GiftAid,HHExpNFEduGood_6M_MN,HHExpNFEduGood_6M_CRD,HHExpNFEduGood_6M_GiftAid,HHExpNFRent_6M_MN,
HHExpNFRent_6M_CRD,HHExpNFRent_6M_GiftAid,HHExpNFHHSoft_6M_MN,HHExpNFHHSoft_6M_CRD,HHExpNFHHSoft_6M_GiftAid,HHExpNFSav_6M_Tot,HHExpNFDebt_6M_Tot,HHExpNFInsurance_6M_Tot)/6.
VARIABLE LABELS nonfood2_monthly 'D�penses � long terme non alimentaires des m�nages au cours du mois'.
EXECUTE.

*compute food expenditure share and food expenditure share categories

COMPUTE FoodExp_share= food_monthly/sum(food_monthly, nonfood1_monthly, nonfood2_monthly).
VARIABLE LABELS FoodExp_share 'part des d�penses alimentaires des m�nages'
EXECUTE.

RECODE FoodExp_share (Lowest thru .49=1) (.50 thru .649=2) (.65 thru .749=3) (.75 thru Highest=4)
 INTO Foodexp_4pt.
VARIABLE LABELS Foodexp_4pt 'cat�gories de r�partition des d�penses alimentaires'.
EXECUTE.

VALUE LABELS Foodexp_4pt
1 'moins de 50%'
2 'entre 50 et 65%'
3 'entre 65 et 75%'
4 'plus de 75%'.
EXECUTE.

*** Calculer rCSI

compute rCSI = sum(rCSILessQlty,rCSIBorrow*2,rCSIMealSize,rCSIMealAdult*3,rCSIMealNb).
Variable labels rCSI "rCSI".
EXECUTE.
*** calculate Livelihood Coping Stragegies
** creer une variable  pour montrer si les strategies de stress etaient  "Oui"" ou "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire"

do if (LhCSIStress1 = 2) | (LhCSIStress1 = 3) |
(LhCSIStress2 = 2) | (LhCSIStress2 = 3) |
(LhCSIStress3 = 2) | (LhCSIStress3 = 3) |
(LhCSIStress4 = 2) | (LhCSIStress4 = 3).
compute stress_coping = 1.
ELSE.
compute stress_coping = 0.
end if.
variable labels stress_coping "le m�nage s'est-il engag� dans des strat�gies  du stress ?".
value labels stress_coping
0 "Non"
1 "Oui".
EXECUTE.
*** creer une variable  pour montrer si les strategies de crises etaient  "Oui"" ou "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire"

do if (LhCSICrisis1 = 2) | (LhCSICrisis1 = 3) |
(LhCSICrisis2 = 2) | (LhCSICrisis2 = 3) |
(LhCSICrisis3 = 2) | (LhCSICrisis3 = 3).
compute crisis_coping = 1.
ELSE.
compute crisis_coping = 0.
end if.
variable labels crisis_coping "le m�nage s'est-il engag� dans des strat�gies d'adaptation aux crises ?".
value labels crisis_coping
0 "Non"
1 "Oui".
EXECUTE.

*** creer une variable  pour montrer si les strategies de urgences etaient  "Oui"" ou "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire"

do if (LhCSIEmergency1 = 2) | (LhCSIEmergency1  = 3) |
(LhCSIEmergency2 = 2) | (LhCSIEmergency2  = 3) |
(LhCSIEmergency3  = 2) | (LhCSIEmergency3 = 3).
compute emergency_coping = 1.
ELSE.
compute emergency_coping = 0.
end if.
variable labels emergency_coping "le m�nage s'est-il engag� dans des strat�gies d'adaptation d'urgence ?".
value labels emergency_coping
0 "Non"
1 "Oui".
EXECUTE.

*** recoder les variables pour calculer une variable de la stratégie d'adaptation la plus sévère utilisée

recode stress_coping (0=0) (1=2).
recode crisis_coping (0=0) (1=3).
recode emergency_coping (0=0) (1=4).

compute LhCSICat=max(stress_coping, crisis_coping, emergency_coping).
recode LhCSICat (0=1).

Value labels LhCSICat 1 "Pasdestrategies" 2 "StrategiesdeStress" 3 "StrategiesdeCrise" 4 "StrategiesdUrgence".
Variable Labels LhCSICat "Cat�gories de strat�gies d'adaptation aux moyens d'existence - version l�ger  de CARI".
EXECUTE.

*** Calculate CARI 

COMPUTE Mean_coping_capacity=MEAN(LhCSICat, Foodexp_4pt).
EXECUTE.
COMPUTE FS_class_unrounded=MEAN(FCS_4pt,Mean_coping_capacity).
EXECUTE.
COMPUTE FS_final=RND(FS_class_unrounded).
EXECUTE.

* Define Variable Properties.

VALUE LABELS FS_final
 1.00 's�curit� alimentaire'
 2.00 's�curit� alimentaire marginale'
 3.00 'ins�curit� alimentaire mod�r�e'
 4.00 'ins�curit� alimentaire s�v�re'.
EXECUTE.







