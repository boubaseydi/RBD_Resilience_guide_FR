library(haven)
library(labelled)
library(tidyverse)

#import dataset
dataset <- read_sav("example_datasets/exampledataFrancais_raw.sav")

#2 - convertir toutes les variables à la version étiquetée - mais créer d'abord des ADMINCodes
dataset <- dataset %>% mutate(ADMIN1Code = as.character(ADMIN1Name))
dataset <- dataset %>% mutate(ADMIN2Code = as.character(ADMIN2Name))
dataset <- to_factor(dataset)


##calculate rCSI
dataset <- dataset %>% mutate(rCSI = rCSILessQlty  + (2 * rCSIBorrow) + rCSIMealSize + (3 * rCSIMealAdult) + rCSIMealNb)
var_label(dataset$rCSI) <- "rCSI"


## FCS / FCSN
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
#variable and value labels
var_label(dataset$FGVitACat) <-  "Consommation d'aliments riches en vitamine A"
var_label(dataset$FGProteinCat) <-  "Consommation d'aliments riches en protiéine"
var_label(dataset$FGHIronCat) <-  "Consommation d'aliments riches en fer"
# define variables labels and properties for " FGVitACat FGProteinCat FGHIronCat ".
val_labels(dataset$FGVitACat) <- c("0 jours" = 1, "1-6 jours" = 2, "7 jours" = 3)
val_labels(dataset$FGProteinCat) <- c("0 jours" = 1, "1-6 jours" = 2, "7 jours" = 3)
val_labels(dataset$FGHIronCat) <- c("0 jours" = 1, "1-6 jours" = 2, "7 jours" = 3)


## EXPENDITURES
#set all missing response NAs to zeros for all the relevant expenditure variables - because in R adding with NAs can create problems
dataset <- dataset %>% mutate_at(vars(ends_with("_MN")), ~replace(., is.na(.), 0))
dataset <- dataset %>% mutate_at(vars(ends_with("_CRD")), ~replace(., is.na(.), 0))
dataset <- dataset %>% mutate_at(vars(ends_with("_Own")), ~replace(., is.na(.), 0))
dataset <- dataset %>% mutate_at(vars(ends_with("_GiftAid")), ~replace(., is.na(.), 0))
dataset <- dataset %>% mutate_at(vars(ends_with("_Tot")), ~replace(., is.na(.), 0))
#quickly look at variables to make sure all the NA's have been turned to 0s ()
dataset %>% skim(ends_with(c("_MN","_CRD","_Own","_GiftAid")))
#this looks complicated but is better than writing out all the expenditure variables (and maybe forgetting some)
#calculate monthly food expenditures - using regular expression to add together all variables starting with "HHExpF" (food) and ending with "CRD" or "MN" or "Own" or GiftAid"
dataset  <- dataset  %>%  mutate(food_monthly = rowSums(across(matches(c("^HHExpF.*_CRD$","^HHExpF.*_MN$","^HHExpF.*_Own$","^HHExpF.*_GiftAid$")))))
var_label(dataset$food_monthly) <- "Dépenses alimentaires du ménage au cours du mois"
#calculate monthly non food expenditures
dataset  <- dataset  %>%  mutate(nonfood1_monthly = rowSums(across(matches(c("^HHExpNF.*1M_CRD$","^HHExpNF.*1M_MN$","^HHExpNF.*1M_GiftAid$")))))
var_label(dataset$nonfood1_monthly) <- "Dépenses à court terme non alimentaires des ménages au cours du mois"
#caculate 6month non food expenditures
dataset  <- dataset  %>%  mutate(nonfood2_monthly = rowSums(across(matches(c("^HHExpNF.*6M_CRD$","^HHExpNF.*6M_MN$","^HHExpNF.*6M_GiftAid$","^HHExpNF.*6M_Tot$")))))
#convert 6month expenses into monthly
dataset  <- dataset  %>%  mutate(nonfood2_monthly = (nonfood2_monthly / 6))
var_label(dataset$nonfood2_monthly) <- "Dépenses à long terme non alimentaires des ménages au cours du mois"
#calculate food expenditure share and food expenditure share categories
dataset  <- dataset  %>%  mutate(FoodExp_share =food_monthly / (food_monthly +nonfood1_monthly +nonfood2_monthly))
var_label(dataset$FoodExp_share) <- "household food expenditure share"
dataset <- dataset %>% mutate(Foodexp_4pt = case_when(
  FoodExp_share <= .49 ~ 1,
  FoodExp_share >= .5 & FoodExp_share < .65 ~ 2,
  FoodExp_share >= .65 & FoodExp_share < .75 ~ 3,
  FoodExp_share > .75 ~ 4))
var_label(dataset$Foodexp_4pt) <- "catégories de répartition des dépenses alimentaires"
#value labels
val_labels(dataset$Foodexp_4pt) <- c("less than 50%" = 1, "between 50 and 65%" = 2, "between 65 and 75%" = 3, "greater than 75%" = 4)



#Calculate LHCS
#parce que le texte est très long dans les questions - voir si la réponse a été tronquée
levels(dataset$LhCSIStress1)
dataset <- dataset %>% mutate(stress_coping = case_when(
  LhCSIStress1 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  LhCSIStress2 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  LhCSIStress3 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  LhCSIStress4 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  TRUE ~ "Non"))
var_label(dataset$stress_coping) <- "le ménage s'est-il engagé dans des stratégies  du stress ?"
#Crisis
dataset <- dataset %>% mutate(crisis_coping = case_when(
  LhCSICrisis1 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  LhCSICrisis2 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  LhCSICrisis3 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  TRUE ~ "Non"))
var_label(dataset$crisis_coping) <- "le ménage s'est-il engagé dans des stratégies d'adaptation aux crises ?"
#Emergency
dataset <- dataset %>% mutate(emergency_coping = case_when(
  LhCSIEmergency1 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  LhCSIEmergency2 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  LhCSIEmergency3 %in% c("Oui","Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas c") ~ "Oui",
  TRUE ~ "Non"))
var_label(dataset$emergency_coping) <- "le ménage s'est-il engagé dans des stratégies d'adaptation d'urgence ?"
#calculate Max_coping_behaviour
dataset <- dataset %>% mutate(LhCSICat = case_when(
  emergency_coping == "Oui" ~ "StrategiesdeUrgence",
  crisis_coping == "Oui" ~ "StrategiesdeCrise",
  stress_coping == "Oui" ~ "StrategiesdeStress",
  TRUE ~ "Pasdestrategies"))
var_label(dataset$LhCSICat) <- "Catégories de stratégies d'adaptation aux moyens d'existence - version léger  de CARI"
