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

#create the 4 point food consumption score for CARI
dataset <- dataset %>% mutate(FCS_4pt = case_when(
  FCSCat28 == "Pauvre" ~ 4,
  FCSCat28 == "Limite" ~ 3,
  FCSCat28 == "Acceptable" ~ 1))

# define variables labels and properties
var_label(dataset$FCS_4pt) <-  "4pt FCG"
val_labels(dataset$FCS_4pt) <- c("Pauvre" = 4, "Limite" = 3, "Acceptable" = 1)

# calculate Score de Consommation Alimentaire Nutrition (FCS-N)

dataset <- dataset %>% mutate(FGVitA = FCSDairy + FCSPrMeatO + FCSPrEgg + FCSVegOrg + FCSVegGre + FCSFruitOrg)
var_label(dataset$FGVitA) <-  "Consommation d'aliments riches en vitamine A"

dataset <- dataset %>% mutate(FGProtein = FCSPulse + FCSDairy + FCSPrMeatF + FCSPrMeatO + FCSPrFish + FCSPrEgg)
var_label(dataset$FGProtein) <-  "Consommation d'aliments riches en protiéine"

dataset <- dataset %>% mutate(FGHIron = FCSPrMeatF + FCSPrMeatO + FCSPrFish)
var_label(dataset$FGProtein) <-  "Consommation d'aliments riches en fer"

# recoder en groupes basés sur la consommation

dataset <- dataset %>% mutate(
  FGVitACat = case_when(
    FGVitA == 0 ~ 1,
    between(FGVitA,2,6) ~ 2,
    FGVitA >= 7 ~ 3),
  FGProteinCat = case_when(
    FGProtein == 0 ~ 1,
    between(FGProtein,2,6) ~ 2,
    FGProtein >= 7 ~ 3),
  FGHIronCat = case_when(
    FGHIron == 0 ~ 1,
    between(FGHIron,2,6) ~ 2,
    FGHIron >= 7 ~ 3)
)

var_label(dataset$FGVitACat) <-  "Consommation d'aliments riches en vitamine A"
var_label(dataset$FGProteinCat) <-  "Consommation d'aliments riches en protiéine"
var_label(dataset$FGHIronCat) <-  "Consommation d'aliments riches en fer"


# define variables labels and properties for " FGVitACat FGProteinCat FGHIronCat ".
val_labels(dataset$FGVitACat) <- c("0 jours" = 1, "1-6 jours" = 2, "7 jours" = 3)
val_labels(dataset$FGProteinCat) <- c("0 jours" = 1, "1-6 jours" = 2, "7 jours" = 3)
val_labels(dataset$FGHIronCat) <- c("0 jours" = 1, "1-6 jours" = 2, "7 jours" = 3)




