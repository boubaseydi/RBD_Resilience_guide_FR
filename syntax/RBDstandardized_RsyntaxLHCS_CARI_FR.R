library(haven)
library(labelled)
library(tidyverse)

#import dataset
dataset <- read_sav("example_datasets/exampledataFrancais_raw.sav")

#Calculate LHCS -
dataset<- to_factor(dataset)

# parce que le texte est très long dans les questions - voir si la réponse a été tronquée - parce qu'il sera difficile de faire correspondre le texte exact
# utilisez str_detect avec une partie du texte de la réponse
levels(dataset$LhCSIStress1)

#Stress
dataset <- dataset %>% mutate(stress_coping = case_when(
  LhCSIStress1 == "Oui" | str_detect(LhCSIStress1,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  LhCSIStress2 == "Oui" | str_detect(LhCSIStress2,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  LhCSIStress3 == "Oui" | str_detect(LhCSIStress3,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  LhCSIStress4 == "Oui" | str_detect(LhCSIStress4,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  TRUE ~ "Non"))
var_label(dataset$stress_coping) <- "le ménage s'est-il engagé dans des stratégies  du stress ?"

#Crisis
dataset <- dataset %>% mutate(crisis_coping = case_when(
  LhCSICrisis1 == "Oui" | str_detect(LhCSICrisis1,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  LhCSICrisis2 == "Oui" | str_detect(LhCSICrisis2,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  LhCSICrisis3 == "Oui" | str_detect(LhCSICrisis3,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  TRUE ~ "Non"))
var_label(dataset$crisis_coping) <- "le ménage s'est-il engagé dans des stratégies d'adaptation aux crises ?"

#Emergency
dataset <- dataset %>% mutate(emergency_coping = case_when(
  LhCSIEmergency1 == "Oui" | str_detect(LhCSIEmergency1,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  LhCSIEmergency2 == "Oui" | str_detect(LhCSIEmergency2,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  LhCSIEmergency3 == "Oui" | str_detect(LhCSIEmergency3,"Non, parce que j’ai déjà vendu ces actifs") ~ "Oui",
  TRUE ~ "Non"))
var_label(dataset$emergency_coping) <- "le ménage s'est-il engagé dans des stratégies d'adaptation d'urgence ?"

#calculate Max_coping_behaviour
dataset <- dataset %>% mutate(LhCSICat = case_when(
  emergency_coping == "Oui" ~ 4,
  crisis_coping == "Oui" ~ 3,
  stress_coping == "Oui" ~ 2,
  TRUE ~ 1))

#value and variable labels
val_labels(dataset$LhCSICat) <- c("Pasdestrategies" = 1, "StrategiesdeStress" = 2, "StrategiesdeCrise" = 3, "StrategiesdeUrgence" = 4)
var_label(dataset$LhCSICat) <- "Catégories de stratégies d'adaptation aux moyens d'existence - version léger  de CARI"
