library(haven)
library(labelled)
library(tidyverse)

#import dataset
dataset <- read_sav("example_datasets/exampledataFrancais_raw.sav")
#convert to labels
dataset <- to_factor(dataset)

#calculate FCS
dataset <- dataset %>% mutate(FCS = (2 * FCSStap) + (3 * FCSPulse)+ (4*FCSPr) +FCSVeg  +FCSFruit +(4*FCSDairy) + (0.5*FCSFat) + (0.5*FCSSugar))
var_label(dataset$FCS) <- "Score de consommation alimentaire"
#create FCG groups based on 21/25 or 28/42 thresholds - analyst should decide which one to use.
dataset <- dataset %>% mutate(
  FCSCat21 = case_when(
    FCS <= 21 ~ "Pauvre", between(FCS, 21.5, 35) ~ "Limite", FCS > 35 ~ "Acceptable"),
  FCSCat28 = case_when(
    FCS <= 28 ~ "Pauvre", between(FCS, 28.5, 42) ~ "Limite", FCS > 42 ~ "Acceptable"))
var_label(dataset$FCSCat21) <- "Groupe de consommation alimentaire - Seuils du 21/35"
var_label(dataset$FCSCat28) <-  "Groupe de consommation alimentaire - Seuils du 28/42"

# calculate Score de Consommation Alimentaire Nutrition (FCS-N)

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
