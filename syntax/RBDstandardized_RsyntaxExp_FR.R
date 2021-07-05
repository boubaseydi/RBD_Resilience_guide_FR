library(haven)
library(labelled)
library(tidyverse)
library(skimr)

#import dataset
dataset <- read_sav("example_datasets/exampledataFrancais_raw.sav")

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



