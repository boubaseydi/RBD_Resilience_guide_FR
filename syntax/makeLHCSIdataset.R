library(haven)
library(tidyverse)
library(labelled)
library(skimr)

####
exp_examples <- read_sav("C:/RBD_Resilience_guide_FR/example_datasets/data_traite_29_09_2020_ND.sav")

exp_examples <- exp_examples %>%
  rename(HHExpFCer_1M_MN = S7.1.1a,
         HHExpFCer_1M_CRD = S7.1.1b,
         HHExpFCer_1M_GiftAid = S7.1.1c,
         HHExpFCer_1M_Own = S7.1.1d,
         HHExpFTub_1M_MN = S7.1.3a,
         HHExpFTub_1M_CRD = S7.1.3b,
         HHExpFTub_1M_GiftAid = S7.1.3c,
         HHExpFTub_1M_Own = S7.1.3d,
         HHExpFPuls_1M_MN = S7.1.11a,
         HHExpFPuls_1M_CRD = S7.1.11b,
         HHExpFPuls_1M_GiftAid =S7.1.11c,
         HHExpFPuls_1M_Own = S7.1.11d,
         HHExpFVeg_1M_MN = S7.1.4a,
         HHExpFVeg_1M_CRD = S7.1.4b,
         HHExpFVeg_1M_GiftAid = S7.1.4c,
         HHExpFVeg_1M_Own = S7.1.4d,
         HHExpFFrt_1M_MN = S7.1.6a,
         HHExpFFrt_1M_CRD = S7.1.6b,
         HHExpFFrt_1M_GiftAid = S7.1.6c,
         HHExpFFrt_1M_Own = S7.1.6d,
         HHExpFAnimMeat_1M_MN = S7.1.8a,
         HHExpFAnimMeat_1M_CRD = S7.1.8b,
         HHExpFAnimMeat_1M_GiftAid = S7.1.8c,
         HHExpFAnimMeat_1M_Own = S7.1.8d,
         HHExpFAnimFish_1M_MN = S7.1.7a,
         HHExpFAnimFish_1M_CRD = S7.1.7b,
         HHExpFAnimFish_1M_GiftAid = S7.1.7c,
         HHExpFAnimFish_1M_Own = S7.1.7d,
         HHExpFFats_1M_MN = S7.1.12a,
         HHExpFFats_1M_CRD = S7.1.12b,
         HHExpFFats_1M_GiftAid = S7.1.12c,
         HHExpFFats_1M_Own = S7.1.12d,
         HHExpFDairy_1M_MN = S7.1.5a,
         HHExpFDairy_1M_CRD = S7.1.5b,
         HHExpFDairy_1M_GiftAid = S7.1.5c,
         HHExpFDairy_1M_Own = S7.1.5d,
         HHExpFAnimEgg_1M_MN = S7.1.10a,
         HHExpFAnimEgg_1M_CRD = S7.1.10b,
         HHExpFAnimEgg_1M_GiftAid = S7.1.10c,
         HHExpFAnimEgg_1M_Own = S7.1.10d,
         HHExpFSgr_1M_MN = S7.1.13a,
         HHExpFSgr_1M_CRD = S7.1.13b,
         HHExpFSgr_1M_GiftAid = S7.1.13c,
         HHExpFSgr_1M_Own = S7.1.13d,
         HHExpFBeverage_1M_MN = S7.1.15a,
         HHExpFBeverage_1M_CRD = S7.1.15b,
         HHExpFBeverage_1M_GiftAid = S7.1.15c,
         HHExpFBeverage_1M_Own = S7.1.15d,
         HHExpFOut_1M_MN = S7.1.16a,
         HHExpFOut_1M_CRD = S7.1.16b,
         HHExpFOut_1M_GiftAid = S7.1.16c,
         HHExpFOut_1M_Own = S7.1.16d)

exp_examples <- exp_examples %>% mutate(
  HHExpFCer_1M_Purch = case_when(is.na(HHExpFCer_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFTub_1M_Purch = case_when(is.na(HHExpFTub_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFPuls_1M_Purch = case_when(is.na(HHExpFPuls_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFVeg_1M_Purch = case_when(is.na(HHExpFVeg_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFFrt_1M_Purch = case_when(is.na(HHExpFFrt_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFAnimMeat_1M_Purch = case_when(is.na(HHExpFAnimMeat_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFAnimFish_1M_Purch = case_when(is.na(HHExpFAnimFish_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFFats_1M_Purch = case_when(is.na(HHExpFFats_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFDairy_1M_Purch = case_when(is.na(HHExpFDairy_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFAnimEgg_1M_Purch = case_when(is.na(HHExpFAnimEgg_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFSgr_1M_Purch = case_when(is.na(HHExpFSgr_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFBeverage_1M_Purch = case_when(is.na(HHExpFBeverage_1M_MN) ~ "Non", TRUE ~ "Oui"),
  HHExpFOut_1M_Purch = case_when(is.na(HHExpFOut_1M_MN) ~ "Non", TRUE ~ "Oui"))

#variablelabels - for food expenditures
var_label(dataLHCSLightEng$LhCSIStress1_lt) <- "During the past 30 days, did anyone in your household have to: Sell household assets/goods (radio, furniture, refrigerator, television, jewelry etc..) due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIStress2_lt) <- "During the past 30 days, did anyone in your household have to: sell more animals (non-productive) than usual due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIStress3_lt) <- "During the past 30 days, did anyone in your household have to: spend savings due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIStress4_lt) <- "During the past 30 days, did anyone in your household have to: Borrow money / food  from a formal lender / bank due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSICrisis1_lt) <- "During the past 30 days, did anyone in your household have to: Reduce non-food expenses on health (including drugs) and education due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSICrisis2_lt) <- "During the past 30 days, did anyone in your household have to: sell productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc..) due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSICrisis3_lt) <- "During the past 30 days, did anyone in your household have to: withdraw children from school due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIEmergency1_lt) <- "During the past 30 days, did anyone in your household have to: sell house or land due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIEmergency2_lt) <- "During the past 30 days, did anyone in your household have to: sell last female animals due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIEmergency3_lt) <- "During the past 30 days, did anyone in your household have to:beg due to a lack of food or a lack of money to buy food?"
#value labels
val_labels(dataLHCSLightEng$LhCSIStress1_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIStress2_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIStress3_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIStress4_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSICrisis1_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSICrisis2_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSICrisis3_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIEmergency1_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIEmergency2_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIEmergency3_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
#
#variable labels
dataLHCSLightEng <- dataLHCSLightEng %>% rename(ADMIN1Name = S0.1.3, ADMIN2Name = S0.1.4, WeightHH = Whi)
var_label(dataLHCSLightEng$ADMIN1Name) <- "First Administrative Level"
var_label(dataLHCSLightEng$ADMIN2Name) <- "Second Administrative Level"
var_label(dataLHCSLightEng$WeightHH) <- "Survey Weights"

dataLHCSLightEng <- sample_frac(dataLHCSLightEng, size = .3)

#select only variables
dataLHCSLightEng <- dataLHCSLightEng %>%
  select(ADMIN1Name, ADMIN2Name, WeightHH,LhCSIStress1_lt,LhCSIStress1_lt,LhCSIStress2_lt,LhCSIStress2_lt,LhCSIStress3_lt,,LhCSIStress4_lt,
         LhCSICrisis1_lt,LhCSICrisis2_lt,LhCSICrisis3_lt,LhCSIEmergency1_lt,LhCSIEmergency2_lt,LhCSIEmergency3_lt)

dataLHCSLightEng  %>% write_sav("C:/Users/william.olander/Dropbox/standardizedRBD/dataLHCSLightEng.sav")

