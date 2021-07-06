* Encoding: UTF-8.
GET
  FILE='exampledataFrancais_raw.sav'.
DATASET NAME DataSet1 WINDOW=FRONT.

** calculer le Score de Consommation Alimentaire (FCS)

compute FCS = sum(FCSStap*2, FCSPulse*3, FCSDairy*4, FCSPr*4, FCSVeg, FCSFruit, FCSFat*0.5, FCSSugar*0.5).
variable labels FCS "Score de Consommation Alimentaire".

** calculer  des groupes de consommation alimentaire à partir du score de consommation alimentaire - seuils 21/35 et 28/42s

recode FCS (0 thru 21 = 1) (21 thru 35 = 2) (35 thru highest = 3) into FCSCat21.
variable labels FCSCat21 "Groupes de Consommation Alimentaire - seuils 21/35".
recode FCS (0 thru 28 = 1) (28 thru 42 = 2) (42 thru highest = 3) into FCSCat28.
variable labels FCSCat28  "Groupes de Consommation Alimentaire  - seuils 28/42".

VALUE LABELS FCSCat21 FCSCat28 
1 "Pauvre"
2 "Limite"
3 "Acceptable".

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

