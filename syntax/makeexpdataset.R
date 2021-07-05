library(haven)
library(tidyverse)
library(labelled)
library(skimr)

####
exp_examples <- read_sav("C:/RBD_Resilience_guide_FR/example_datasets/data_traite_29_09_2020_ND.sav")

exp_examples <- exp_examples %>%
  rename(HHExpFCer_1M_Purch = S7.1.1,
         HHExpFCer_1M_MN = S7.1.1a,
         HHExpFCer_1M_CRD = S7.1.1b,
         HHExpFCer_1M_GiftAid = S7.1.1c,
         HHExpFCer_1M_Own = S7.1.1d,
         HHExpFTub_1M_Purch = S7.1.3,
         HHExpFTub_1M_MN = S7.1.3a,
         HHExpFTub_1M_CRD = S7.1.3b,
         HHExpFTub_1M_GiftAid = S7.1.3c,
         HHExpFTub_1M_Own = S7.1.3d,
         HHExpFPuls_1M_Purch = S7.1.11,
         HHExpFPuls_1M_MN = S7.1.11a,
         HHExpFPuls_1M_CRD = S7.1.11b,
         HHExpFPuls_1M_GiftAid =S7.1.11c,
         HHExpFPuls_1M_Own = S7.1.11d,
         HHExpFVeg_1M_Purch = S7.1.4,
         HHExpFVeg_1M_MN = S7.1.4a,
         HHExpFVeg_1M_CRD = S7.1.4b,
         HHExpFVeg_1M_GiftAid = S7.1.4c,
         HHExpFVeg_1M_Own = S7.1.4d,
         HHExpFFrt_1M_Purch = S7.1.6,
         HHExpFFrt_1M_MN = S7.1.6a,
         HHExpFFrt_1M_CRD = S7.1.6b,
         HHExpFFrt_1M_GiftAid = S7.1.6c,
         HHExpFFrt_1M_Own = S7.1.6d,
         HHExpFAnimMeat_1M_Purch = S7.1.8,
         HHExpFAnimMeat_1M_MN = S7.1.8a,
         HHExpFAnimMeat_1M_CRD = S7.1.8b,
         HHExpFAnimMeat_1M_GiftAid = S7.1.8c,
         HHExpFAnimMeat_1M_Own = S7.1.8d,
         HHExpFAnimFish_1M_Purch =  S7.1.7,
         HHExpFAnimFish_1M_MN = S7.1.7a,
         HHExpFAnimFish_1M_CRD = S7.1.7b,
         HHExpFAnimFish_1M_GiftAid = S7.1.7c,
         HHExpFAnimFish_1M_Own = S7.1.7d,
         HHExpFFats_1M_Purch = S7.1.12,
         HHExpFFats_1M_MN = S7.1.12a,
         HHExpFFats_1M_CRD = S7.1.12b,
         HHExpFFats_1M_GiftAid = S7.1.12c,
         HHExpFFats_1M_Own = S7.1.12d,
         HHExpFDairy_1M_Purch = S7.1.5,
         HHExpFDairy_1M_MN = S7.1.5a,
         HHExpFDairy_1M_CRD = S7.1.5b,
         HHExpFDairy_1M_GiftAid = S7.1.5c,
         HHExpFDairy_1M_Own = S7.1.5d,
         HHExpFAnimEgg_1M_Purch = S7.1.10,
         HHExpFAnimEgg_1M_MN = S7.1.10a,
         HHExpFAnimEgg_1M_CRD = S7.1.10b,
         HHExpFAnimEgg_1M_GiftAid = S7.1.10c,
         HHExpFAnimEgg_1M_Own = S7.1.10d,
         HHExpFSgr_1M_Purch = S7.1.13,
         HHExpFSgr_1M_MN = S7.1.13a,
         HHExpFSgr_1M_CRD = S7.1.13b,
         HHExpFSgr_1M_GiftAid = S7.1.13c,
         HHExpFSgr_1M_Own = S7.1.13d,
         HHExpFBeverage_1M_Purch = S7.1.15,
         HHExpFBeverage_1M_MN = S7.1.15a,
         HHExpFBeverage_1M_CRD = S7.1.15b,
         HHExpFBeverage_1M_GiftAid = S7.1.15c,
         HHExpFBeverage_1M_Own = S7.1.15d,
         HHExpFOut_1M_Purch = S7.1.16,
         HHExpFOut_1M_MN = S7.1.16a,
         HHExpFOut_1M_CRD = S7.1.16b,
         HHExpFOut_1M_GiftAid = S7.1.16c,
         HHExpFOut_1M_Own = S7.1.16d)


#variablelabels - for food expenditures
var_label(exp_examples$HHExpFCer_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté Des céréales, telles que :  (maïs, riz, sorgho, blé , farine de céréales, pain, pâtes (remplacez par des exemples locaux pertinents) en espèces ou à crédit ?"
var_label(exp_examples$HHExpFCer_1M_MN) <- "Veuillez estimer la valeur total que votre ménage a dépensé en espèces pour des céréales au cours des 30 derniers jours."
var_label(exp_examples$HHExpFCer_1M_CRD) <- "Veuillez estimer la valeur total que votre ménage a dépensé en crédit pour des céréales au cours des 30 derniers jours."
var_label(exp_examples$HHExpFCer_1M_GiftAid) <- "Veuillez estimer la valeur totale des céréales que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFCer_1M_Own) <- "Veuillez estimer la valeur totale des céréales que votre ménage a consommées et qui ont été produites, cueillies, chassées ou reçues en échange de travail au cours des 30 derniers jours. "
var_label(exp_examples$HHExpFTub_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des tubercules, tels que : ( pommes de terre, patates douces, manioc, bananes plantains, ignames) remplacer par des exemples pertinents localement) en espèces ou à crédit ?"
var_label(exp_examples$HHExpFTub_1M_MN) <- "Veuillez estimer la valeur total que votre ménage a dépensé en espèces pour des tubercules au cours des 30 derniers jours."
var_label(exp_examples$HHExpFTub_1M_CRD) <- "Veuillez estimer la valeur total que votre ménage a dépensé en crédit pour des tubercules au cours des 30 derniers jours."
var_label(exp_examples$HHExpFTub_1M_GiftAid) <- "Veuillez estimer la valeur totale des  tubercules  que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFTub_1M_Own) <- "Veuillez estimer la valeur totale des tubercules que votre ménage a consommés et qui ont été produits, cueillis, chassés ou reçus en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFPuls_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté Des légumineuses et noix, tels que : ( haricots, pois, lentilles, noix en coque ou décortiquées ) remplacer par des exemples locaux pertinents) en espèces ou à crédit ?"
var_label(exp_examples$HHExpFPuls_1M_MN) <- "Veuillez estimer la valeur total que votre ménage a dépensé en espèces pour des légumineuses et noix au cours des 30 derniers jours."
var_label(exp_examples$HHExpFPuls_1M_CRD) <- "Veuillez estimer la valeur total que votre ménage a dépensé en crédit pour des  légumineuses et noix au cours des 30 derniers jours."
var_label(exp_examples$HHExpFPuls_1M_GiftAid) <- "Veuillez estimer la valeur totale des  légumineuses et noix   que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFPuls_1M_Own) <- "Veuillez estimer la valeur totale des des  légumineuses et noix  que votre ménage a consommés et qui ont été produits, récoltés, chassés ou reçus en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFVeg_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des légumes, tels que :( légumes à feuilles vert foncé, légumes orange, autres légumes ) remplacer par des exemples locaux pertinents) en espèces ou à crédit ?"
var_label(exp_examples$HHExpFVeg_1M_MN) <- "Veuillez estimer la valeur total que votre ménage a dépensé en espèces pour des légumes au cours des 30 derniers jours."
var_label(exp_examples$HHExpFVeg_1M_CRD) <- "Veuillez estimer la valeur total que votre ménage a dépensé en crédit pour des légumes au cours des 30 derniers jours."
var_label(exp_examples$HHExpFVeg_1M_GiftAid) <- "Veuillez estimer la valeur totale des   légumes   que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFVeg_1M_Own) <- "Veuillez estimer la valeur totale des légumes que votre ménage a consommés et qui ont été produits, cueillis, chassés ou reçus en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFFrt_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des fruits, tels que : ( banane, pomme, citron, mangue, papaye, abricot, pêche) remplacer par des exemples locaux pertinents) en espèces ou à crédit ?"
var_label(exp_examples$HHExpFFrt_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour des fruits au cours des 30 derniers jours."
var_label(exp_examples$HHExpFFrt_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour des fruits au cours des 30 derniers jours."
var_label(exp_examples$HHExpFFrt_1M_GiftAid) <- "Veuillez estimer la valeur totale des fruits  que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFFrt_1M_Own) <- "Veuillez estimer la valeur totale des fruits que votre ménage a consommés et qui ont été produits, cueillis, chassés ou reçus en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimMeat_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté de la viande, telle que : (viande de chèvre, bœuf, poulet, porc, sang) remplacer par des exemples locaux pertinents en espèces ou à crédit ?"
var_label(exp_examples$HHExpFAnimMeat_1M_MN) <- "Veuillez estimer la valeur totael que votre ménage a dépensé en espèces pour la viande au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimMeat_1M_CRD) <- " Veuillez estimer la valeur totael que votre ménage a dépensé en crédit pour la viande au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimMeat_1M_GiftAid) <- "Veuillez estimer la valeur totale de la viande  que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimMeat_1M_Own) <- "Veuillez estimer la valeur totale de la viande que votre ménage a consommée et qui a été produite, cueillie, chassée ou reçue en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimFish_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des poissons et des crustacés, tels que :  (poisson, y compris les conserves de thon, les escargots, et/ou d'autres fruits de mer ; remplacer par des exemples locaux pertinents) ;  en espèces ou à crédit ?"
var_label(exp_examples$HHExpFAnimFish_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour l'achat de poissons et de crustacés au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimFish_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour du poisson et des crustacés au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimFish_1M_GiftAid) <- "Veuillez estimer la valeur totale du poisson et des crustacés  que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimFish_1M_Own) <- "Veuillez estimer la valeur totale du poisson et des crustacés que votre ménage a consommés et qui ont été produite, cueillie, chassée ou reçue en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFFats_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des huiles/graisses/beurre, tels que :  (huile végétale, huile de palme, beurre de karité, margarine, autres graisses/huiles) remplacer par des exemples locaux pertinents en espèces ou à crédit ?"
var_label(exp_examples$HHExpFFats_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour l'achat d'huile/graisse/beurre au cours des 30 derniers jours."
var_label(exp_examples$HHExpFFats_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour l'huile/la graisse/le beurre au cours des 30 derniers jours."
var_label(exp_examples$HHExpFFats_1M_GiftAid) <- "Veuillez estimer la valeur totale  de l'huile/graisse/beurre  que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFFats_1M_Own) <- "Veuillez estimer la valeur totale de l'huile/graisse/beurre que votre ménage a consommé et qui a été produit, récolté, chassé ou reçu en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFDairy_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté du lait/des produits laitiers, tels que :  (lait, fromage, yaourt, lait en poudre) remplacer par des exemples locaux pertinents en espèces ou à crédit ?"
var_label(exp_examples$HHExpFDairy_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour du lait ou des produits laitiers au cours des 30 derniers jours."
var_label(exp_examples$HHExpFDairy_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour du lait ou des produits laitiers au cours des 30 derniers jours."
var_label(exp_examples$HHExpFDairy_1M_GiftAid) <- "Veuillez estimer la valeur totale  de laitiers   que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFDairy_1M_Own) <- "Veuillez estimer la valeur totale du lait/des produits laitiers que votre ménage a consommés et qui ont été produits, collectés, chassés ou reçus en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimEgg_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des œufs en espèces ou à crédit ? Œufs "
var_label(exp_examples$HHExpFAnimEgg_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour des œufs au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimEgg_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour des œufs au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimEgg_1M_GiftAid) <- "Veuillez estimer la valeur totale   des œufs   que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFAnimEgg_1M_Own) <- "Veuillez estimer la valeur totale des œufs que votre ménage a consommés et qui ont été produits, cueillis, chassés ou reçus en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFSgr_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté du sucre et des sucreries, tels que :  (sucre, miel, confiture, gâteaux, bonbons, biscuits, pâtisseries, gâteaux) remplacer par des exemples pertinents localement en espèces ou à crédit ?"
var_label(exp_examples$HHExpFSgr_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour acheter du sucre et des sucreries au cours des 30 derniers jours."
var_label(exp_examples$HHExpFSgr_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour du sucre et des sucreries au cours des 30 derniers jours."
var_label(exp_examples$HHExpFSgr_1M_GiftAid) <- "Veuillez estimer la valeur totale des sucre et des sucreries   que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFSgr_1M_Own) <- "Veuillez estimer la valeur totale du sucre et des sucreries que votre ménage a consommés et qui ont été produits, cueillis, chassés ou reçus en échange de travail au cours des 30 derniers jours."
var_label(exp_examples$HHExpFCond_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des condiments, tels que :  (Sel, épices, cubes, poudre de poisson ) remplacer par des exemples pertinents localement en espèces ou à crédit ?"
var_label(exp_examples$HHExpFCond_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour des condiments au cours des 30 derniers jours."
var_label(exp_examples$HHExpFCond_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour des condiments au cours des 30 derniers jours."
var_label(exp_examples$HHExpFCond_1M_GiftAid) <- "Veuillez estimer la valeur totale des condiments   que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFCond_1M_Own) <- "Veuillez estimer la valeur totale des condiments que votre ménage a consommés et qui ont été produits, récoltés, chassés ou reçus en échange de travail. "
var_label(exp_examples$HHExpFBeverage_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des boissons non alcoolisées, y compris de l'eau en bouteille, telles que :  (café, thé, infusion, eau en bouteille, boissons non alcoolisées, jus de fruits) remplacer par des exemples pertinents localement en espèces ou à crédit ?"
var_label(exp_examples$HHExpFBeverage_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour des boissons non alcoolisées, y compris l'eau en bouteille, au cours des 30 derniers jours."
var_label(exp_examples$HHExpFBeverage_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédits pour des boissons non alcoolisées, y compris l'eau en bouteille, au cours des 30 derniers jours."
var_label(exp_examples$HHExpFBeverage_1M_GiftAid) <- "Veuillez estimer la valeur totale des  boissons non alcoolisées, y compris l'eau en bouteille, que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFBeverage_1M_Own) <- "Veuillez estimer la valeur totale des boissons non alcoolisées, y compris l'eau en bouteille, que votre ménage a consommées et qui ont été produites, collectées, chassées ou reçues en échange de travail. "
var_label(exp_examples$HHExpFOut_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des snacks consommés à l'extérieur de la maison, tels que :  (plats à emporter, snacks consommés  à l'extérieur du menage) remplacer par des exemples pertinents localement en espèces ou à crédit ?"
var_label(exp_examples$HHExpFOut_1M_MN) <- "Veuillez estimer le valeur total que votre ménage a dépensé en espèces pour des snacks consommés en dehors de la maison au cours des 30 derniers jours."
var_label(exp_examples$HHExpFOut_1M_CRD) <- "Veuillez estimer le valeur total que votre ménage a dépensé en crédit pour des snacks consommés en dehors de la maison au cours des 30 derniers jours."
var_label(exp_examples$HHExpFOut_1M_GiftAid) <- "Veuillez estimer la valeur totale  des snacks consommés en dehors de la maison, que votre ménage a consommées provenant de don en nature ou de cadeaux  au cours des 30 derniers jours."
var_label(exp_examples$HHExpFOut_1M_Own) <- "Veuillez estimer la valeur totale des collations consommées en dehors du foyer que votre ménage a consommées et qui ont été produites, cueillies, chassées ou reçues en échange de travail. "

exp_examples  %>% write_sav("exp_examples.sav")

#nonfood

exp_examples <- exp_examples %>%
  rename(HHExpNFHyg_1M_Purch = S7.2.1,
         HHExpNFHyg_1M_MN = S7.2.1a,
         HHExpNFHyg_1M_CRD = S7.2.1b,
         HHExpNFTransp_1M_Purch = S7.2.2,
         HHExpNFTransp_1M_MN = S7.2.2a,
         HHExpNFTransp_1M_CRD = S7.2.2b,
         HHExpNFWat_1M_Purch = S7.2.3,
         HHExpNFWat_1M_MN = S7.2.3a,
         HHExpNFWat_1M_CRD = S7.2.3b,
         HHExpNFElec_1M_Purch = S7.2.4,
         HHExpNFElec_1M_MN = S7.2.4a,
         HHExpNFElec_1M_CRD = S7.2.4b,
         HHExpNFEnerg_1M_Purch = S7.2.5,
         HHExpNFEnerg_1M_MN = S7.2.5a,
         HHExpNFEnerg_1M_CRD = S7.2.5b,
         HHExpNFDwelServ_1M_Purch = S7.2.6,
         HHExpNFDwelServ_1M_MN = S7.2.6a,
         HHExpNFDwelServ_1M_CRD = S7.2.6b,
         HHExpNFPhone_1M_Purch = S7.2.7,
         HHExpNFPhone_1M_MN = S7.2.7a,
         HHExpNFPhone_1M_CRD = S7.2.7b,
         HHExpNFAlcTobac_1M_Purch = S7.2.8,
         HHExpNFAlcTobac_1M_MN = S7.2.8a,
         HHExpNFAlcTobac_1M_CRD = S7.2.8b,
         HHExpNFMedServ_6M_Purch = S7.3.1,
         HHExpNFMedServ_6M_MN = S7.3.1a,
         HHExpNFMedServ_6M_CRD = S7.3.1b,
         HHExpNFMedGood_6M_Purch = S7.3.2,
         HHExpNFMedGood_6M_MN = S7.3.2a,
         HHExpNFMedGood_6M_CRD = S7.3.2b,
         HHExpNFCloth_6M_Purch = S7.3.3,
         HHExpNFCloth_6M_MN = S7.3.3a,
         HHExpNFCloth_6M_CRD = S7.3.3b,
         HHExpNFEduFee_6M_Purch = S7.3.4,
         HHExpNFEduFee_6M_MN = S7.3.4a,
         HHExpNFEduFee_6M_CRD = S7.3.4b,
         HHExpNFEduGood_6M_Purch = S7.3.5,
         HHExpNFEduGood_6M_MN = S7.3.5a,
         HHExpNFEduGood_6M_CRD = S7.3.5b,
         HHExpNFRent_6M_Purch = S7.3.6,
         HHExpNFRent_6M_MN = S7.3.6a,
         HHExpNFRent_6M_CRD = S7.3.6b,
         HHExpNFHHSoft_6M_Purch = S7.3.7,
         HHExpNFHHSoft_6M_MN = S7.3.7a,
         HHExpNFHHSoft_6M_CRD = S7.3.7b,
         HHExpNFSav_6M_Tot = S7.3.8a,
         HHExpNFDebt_6M_Tot = S7.3.9a,
         HHExpNFInsurance_6M_Tot = S7.3.10a)


exp_examples <- exp_examples %>%
  mutate(HHExpNFHyg_1M_GiftAid = HHExpNFHyg_1M_CRD,
         HHExpNFTransp_1M_GiftAid = HHExpNFTransp_1M_CRD,
         HHExpNFWat_1M_GiftAid = HHExpNFWat_1M_CRD,
         HHExpNFElec_1M_GiftAid = HHExpNFElec_1M_CRD,
         HHExpNFEnerg_1M_GiftAid = HHExpNFEnerg_1M_CRD,
         HHExpNFDwelServ_1M_GiftAid = HHExpNFDwelServ_1M_CRD,
         HHExpNFPhone_1M_GiftAid = HHExpNFPhone_1M_CRD,
         HHExpNFAlcTobac_1M_GiftAid = HHExpNFAlcTobac_1M_CRD,
         HHExpNFMedServ_6M_GiftAid = HHExpNFMedServ_6M_CRD,
         HHExpNFMedGood_6M_GiftAid = HHExpNFMedGood_6M_CRD,
         HHExpNFCloth_6M_GiftAid = HHExpNFCloth_6M_CRD,
         HHExpNFEduFee_6M_GiftAid = HHExpNFEduFee_6M_CRD,
         HHExpNFEduGood_6M_GiftAid = HHExpNFEduGood_6M_CRD,
         HHExpNFRent_6M_GiftAid = HHExpNFRent_6M_CRD,
         HHExpNFHHSoft_6M_GiftAid = HHExpNFHHSoft_6M_CRD)

#non food labels
var_label(exp_examples$HHExpNFHyg_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté des articles d'hygiène tels que :(Savon, brosse à dents, dentifrice, papier toilette, détergents remplacer par des exemples pertinents localement en espèces ou à crédit ?"
var_label(exp_examples$HHExpNFHyg_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour des articles d'hygiène au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFHyg_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour des articles d'hygiène au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFHyg_1M_GiftAid) <- "Veuillez estimer la valeur totale des articles d'hygiène consommés/utilisés provenant de don en nature ou de cadeaux   au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFTransp_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il dépensé pour des transports tels que :   (carburant, transports publics, taxi, remplacez par des exemples locaux pertinents, en espèces ou à crédit ?"
var_label(exp_examples$HHExpNFTransp_1M_MN) <- "Veuillez estimerla valeur totale que votre ménage a dépensé en espèces pour le transport au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFTransp_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour le transport au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFTransp_1M_GiftAid) <- "Veuillez estimer la valeur totale des transports consommés/utilisés à provenant de don en nature ou de cadeaux   au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFWat_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté de l'eau pour l'approvisionnement domestique - pas de l'eau potable en bouteille - en espèces ou à crédit ?"
var_label(exp_examples$HHExpNFWat_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour l'achat d'eau pour l'approvisionnement domestique - PAS d'eau potable en bouteille au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFWat_1M_CRD) <- "Veuillez estimer la valeur totaleque votre ménage a dépensé en crédit pour de l'eau à usage domestique - NON embouteillée au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFWat_1M_GiftAid) <- "Veuillez estimer la valeur totale de l'eau pour l'approvisionnement domestique - PAS d'eau potable en bouteille - consommée/utilisée à partir de dons ou d'aide en nature au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFElec_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il effectué des dépenses d'électricité en espèces ou à crédit ?"
var_label(exp_examples$HHExpNFElec_1M_MN) <- "Veuillez estimer  la valeur totale deque votre ménage a dépensé en espèces pour l'électricité au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFElec_1M_CRD) <- "Veuillez estimer la valeur totale  que votre ménage a dépensé en crédit pour l'électricité au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFElec_1M_GiftAid) <- "Veuillez estimer la valeur totale de l'électricité consommée/utilisée provenant de don en nature ou de cadeaux   au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFEnerg_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il dépensé en espèces ou en crédits pour  d'autres sources d'énergie (pour la cuisine, le chauffage, l'éclairage) telles que le gaz, le kérosène, le bois - PAS l'électricité  ?"
var_label(exp_examples$HHExpNFEnerg_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour d'autres sources d'énergie (pour la cuisine, le chauffage, l'éclairage) telles que le gaz, le kérosène, le bois - PAS l'électricité - au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFEnerg_1M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour d'autres sources d'énergie (pour la cuisine, le chauffage, l'éclairage) telles que le gaz, le kérosène, le bois - PAS l'électricité au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFEnerg_1M_GiftAid) <- "Veuillez estimer la valeur totale des autres sources d'énergie (pour la cuisine, le chauffage, l'éclairage) telles que le gaz, le kérosène, le bois - PAS l'électricité consommée/utilisée provenant de don en nature ou de cadeaux   au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFDwelServ_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté en espèces ou à crédit des services liés au logement tels que (collecte des ordures, collecte des eaux usées, frais d'entretien des bâtiments collectifs, services de sécurité)?"
var_label(exp_examples$HHExpNFDwelServ_1M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour des services liés au logement au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFDwelServ_1M_CRD) <- "Veuillez estimerla valeur totale que votre ménage a dépensé en crédit pour des services liés au logement au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFDwelServ_1M_GiftAid) <- "Veuillez estimer la valeur totale des services liés au logement consommés/utilisés à partir provenant de don en nature ou de cadeaux   au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFPhone_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté en espèces ou à crédit des communications telles que (recharge de téléphone portable, Internet) ?"
var_label(exp_examples$HHExpNFPhone_1M_MN) <- "Veuillez estimerla valeur  totale que votre ménage a dépensé en espèces pour la communication au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFPhone_1M_CRD) <- "Veuillez estimer la valeur  total que votre ménage a dépensé en crédit pour la communication au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFPhone_1M_GiftAid) <- "Veuillez estimer la valeur totale de la communication consommée/utilisée provenant de don en nature ou de cadeaux   au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFAlcTobac_1M_Purch) <- "Au cours des 30 derniers jours, votre ménage a-t-il acheté en espèces ou à crédit de l'alcool, du tabac?"
var_label(exp_examples$HHExpNFAlcTobac_1M_MN) <- "Veuillez estimer le valeur total que votre ménage a dépensé en espèces pour l'achat d'alcool, de tabac au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFAlcTobac_1M_CRD) <- "Veuillez estimer le valeur total que votre ménage a dépensé en crédit pour l'alcool, le tabac et le crédit au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFAlcTobac_1M_GiftAid) <- "Veuillez estimer la valeur totale de l'alcool, du tabac consommé/utilisé provenant de don en nature ou de cadeaux   au cours des 30 derniers jours."
var_label(exp_examples$HHExpNFMedServ_6M_Purch) <- "Au cours des 6 derniers mois, votre ménage a-t-il dépensé en espèces ou à crédit pour des services de santé tels que des services ambulatoires ou hospitaliers ?"
var_label(exp_examples$HHExpNFMedServ_6M_MN) <- "Veuillez estimer la valeur totale  que votre ménage a dépensé en espèces pour des services de santé au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFMedServ_6M_CRD) <- "Veuillez estimer la valeur totale  que votre ménage a dépensé en crédit pour des services de santé au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFMedServ_6M_GiftAid) <- "Veuillez estimer la valeur totale des services de santé utilisés provenant de don en nature ou de cadeaux   au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFMedGood_6M_Purch) <- "Au cours des 6 derniers mois, votre ménage a-t-il dépensé en espèces ou à crédit pour des médicaments et des produits de santé tels que des médicaments, d'autres produits médicaux, des équipements médicaux ?"
var_label(exp_examples$HHExpNFMedGood_6M_MN) <- "Veuillez estimer la valeur totale  que votre ménage a dépensé en espèces pour des médicaments et des produits de santé au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFMedGood_6M_CRD) <- "Veuillez estimer la valeur totale  que votre ménage a dépensé en crédit pour des médicaments et des produits de santé au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFMedGood_6M_GiftAid) <- "Veuillez estimer la valeur totale des médicaments et produits de santé utilisés provenant de don en nature ou de cadeaux   au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFCloth_6M_Purch) <- "Au cours des 6 derniers mois, votre ménage a-t-il dépensé en espèces ou à crédit pour des vêtements et des chaussures?"
var_label(exp_examples$HHExpNFCloth_6M_MN) <- "Veuillez estimer la valeur totale  que votre ménage a dépensé en espèces pour l'achat de vêtements et de chaussures au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFCloth_6M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour des vêtements et des chaussures au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFCloth_6M_GiftAid) <- "Veuillez estimer la valeur totale des vêtements et des chaussuresprovenant de don en nature ou de cadeaux   au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFEduFee_6M_Purch) <- "Au cours des 6 derniers mois, votre ménage a-t-il dépensé de l'argent ou des crédits pour des services d'éducation tels que des cours ou des frais de scolarité?"
var_label(exp_examples$HHExpNFEduFee_6M_MN) <- "Veuillez estimer  la valeur totale que votre ménage a dépensé en espèces pour des services d'éducation au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFEduFee_6M_CRD) <- "Veuillez estimer  la valeur totale que votre ménage a dépensé en crédit pour des services d'éducation au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFEduFee_6M_GiftAid) <- "Veuillez estimer la valeur totale des services d'éducation provenant de don en nature ou de cadeaux   au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFEduGood_6M_Purch) <- "Au cours des 6 derniers mois, votre ménage a-t-il dépensé en espèces ou à crédit pour des biens éducatifs tels que (uniforme, matériel scolaire, transport)?"
var_label(exp_examples$HHExpNFEduGood_6M_MN) <- "Veuillez estimer  la valeur totale que votre ménage a dépensé en espèces pour des biens d'éducation au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFEduGood_6M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé à crédit pour des biens d'éducation au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFEduGood_6M_GiftAid) <- "Veuillez estimer la valeur totale des biens d'éducation provenant de don en nature ou de cadeaux   au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFRent_6M_Purch) <- "Au cours des 6 derniers mois, votre ménage a-t-il dépensé en espèces ou à crédit pour le loyer (loyer réel du logement)?"
var_label(exp_examples$HHExpNFRent_6M_MN) <- "Veuillez estimer  la valeur totale  que votre ménage a dépensé en espèces pour le loyer au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFRent_6M_CRD) <- "Veuillez estimer  la valeur totale que votre ménage a dépensé en crédit pour le loyer au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFRent_6M_GiftAid) <- "Veuillez estimer la valeur totale du loyer provenant de don en nature ou de cadeaux   au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFHHSoft_6M_Purch) <- "Au cours des 6 derniers mois, votre ménage a-t-il dépensé de l'argent ou du crédit pour des meubles non durables et pour l'entretien courant du ménage, tels que (Textiles, ustensiles, biens et services pour l'entretien courant du ménage (ne pas inclure les meubles durables, les équipements et les appareils électroménagers)?"
var_label(exp_examples$HHExpNFHHSoft_6M_MN) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en espèces pour l'achat de meubles non durables et l'entretien courant au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFHHSoft_6M_CRD) <- "Veuillez estimer la valeur totale que votre ménage a dépensé en crédit pour l'achat de meubles non durables et l'entretien courant au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFHHSoft_6M_GiftAid) <- "Veuillez estimer la valeur totale du mobilier non durable et de l'entretien courant du ménage provenant de don en nature ou de cadeaux   au cours des 6 derniers mois."
var_label(exp_examples$HHExpNFSav_6M_Tot) <- "Au cours des 6 derniers mois, veuillez estimer le valeur total que votre ménage a dépensé en espèces ou crédit ou  provenant de don en nature ou de cadeaux    pour l'épargne ?"
var_label(exp_examples$HHExpNFDebt_6M_Tot) <- "Au cours des 6 derniers mois, veuillez estimer le valeur total que votre ménage a dépensé en espèces ou crédit ou  provenant de don en nature ou de cadeaux   pour le remboursement de ses dettes ?"
var_label(exp_examples$HHExpNFInsurance_6M_Tot) <- "Au cours des 6 derniers mois, veuillez estimer le valeur total que votre ménage a dépensé en espèces ou crédit ou  provenant de don en nature ou de cadeaux    pour des assurances ?"


exp_examples <- sample_n(exp_examples, size = 3000)

#select only variables
exp_examples <- exp_examples %>% select(
    HHExpFCer_1M_Purch,
    HHExpFCer_1M_MN,
    HHExpFCer_1M_CRD,
    HHExpFCer_1M_GiftAid,
    HHExpFCer_1M_Own,
    HHExpFTub_1M_Purch,
         HHExpFTub_1M_MN,
         HHExpFTub_1M_CRD,
         HHExpFTub_1M_GiftAid,
         HHExpFTub_1M_Own,
         HHExpFPuls_1M_Purch,
         HHExpFPuls_1M_MN,
         HHExpFPuls_1M_CRD,
         HHExpFPuls_1M_GiftAid,
         HHExpFPuls_1M_Own,
         HHExpFVeg_1M_Purch,
         HHExpFVeg_1M_MN,
         HHExpFVeg_1M_CRD,
         HHExpFVeg_1M_GiftAid,
         HHExpFVeg_1M_Own,
         HHExpFFrt_1M_Purch,
         HHExpFFrt_1M_MN,
         HHExpFFrt_1M_CRD,
         HHExpFFrt_1M_GiftAid,
         HHExpFFrt_1M_Own,
         HHExpFAnimMeat_1M_Purch,
         HHExpFAnimMeat_1M_MN,
         HHExpFAnimMeat_1M_CRD,
         HHExpFAnimMeat_1M_GiftAid,
         HHExpFAnimMeat_1M_Own,
         HHExpFAnimFish_1M_Purch,
         HHExpFAnimFish_1M_MN,
         HHExpFAnimFish_1M_CRD,
         HHExpFAnimFish_1M_GiftAid,
         HHExpFAnimFish_1M_Own,
         HHExpFFats_1M_Purch,
         HHExpFFats_1M_MN,
         HHExpFFats_1M_CRD,
         HHExpFFats_1M_GiftAid,
         HHExpFFats_1M_Own,
         HHExpFDairy_1M_Purch,
         HHExpFDairy_1M_MN,
         HHExpFDairy_1M_CRD,
         HHExpFDairy_1M_GiftAid,
         HHExpFDairy_1M_Own,
         HHExpFAnimEgg_1M_Purch,
         HHExpFAnimEgg_1M_MN,
         HHExpFAnimEgg_1M_CRD,
         HHExpFAnimEgg_1M_GiftAid,
         HHExpFAnimEgg_1M_Own,
         HHExpFSgr_1M_Purch,
         HHExpFSgr_1M_MN,
         HHExpFSgr_1M_CRD,
         HHExpFSgr_1M_GiftAid,
         HHExpFSgr_1M_Own,
         HHExpFBeverage_1M_Purch,
         HHExpFBeverage_1M_MN,
         HHExpFBeverage_1M_CRD,
         HHExpFBeverage_1M_GiftAid,
         HHExpFBeverage_1M_Own,
         HHExpFOut_1M_Purch,
         HHExpFOut_1M_MN,
         HHExpFOut_1M_CRD,
         HHExpFOut_1M_GiftAid,
         HHExpFOut_1M_Own,
        HHExpNFHyg_1M_Purch,
    HHExpNFHyg_1M_GiftAid,
         HHExpNFHyg_1M_MN,
         HHExpNFHyg_1M_CRD,
         HHExpNFTransp_1M_Purch,
         HHExpNFTransp_1M_MN,
         HHExpNFTransp_1M_CRD,
    HHExpNFTransp_1M_GiftAid,
         HHExpNFWat_1M_Purch,
         HHExpNFWat_1M_MN,
         HHExpNFWat_1M_CRD,
    HHExpNFWat_1M_GiftAid,
         HHExpNFElec_1M_Purch,
         HHExpNFElec_1M_MN,
         HHExpNFElec_1M_CRD,
    HHExpNFElec_1M_GiftAid,
         HHExpNFEnerg_1M_Purch,
         HHExpNFEnerg_1M_MN,
         HHExpNFEnerg_1M_CRD,
    HHExpNFEnerg_1M_GiftAid,
         HHExpNFDwelServ_1M_Purch,
         HHExpNFDwelServ_1M_MN,
         HHExpNFDwelServ_1M_CRD,
    HHExpNFDwelServ_1M_GiftAid,
         HHExpNFPhone_1M_Purch,
         HHExpNFPhone_1M_MN,
         HHExpNFPhone_1M_CRD,
    HHExpNFPhone_1M_GiftAid,
         HHExpNFAlcTobac_1M_Purch,
         HHExpNFAlcTobac_1M_MN,
         HHExpNFAlcTobac_1M_CRD,
    HHExpNFAlcTobac_1M_GiftAid,
         HHExpNFMedServ_6M_Purch,
         HHExpNFMedServ_6M_MN,
         HHExpNFMedServ_6M_CRD,
    HHExpNFMedServ_6M_GiftAid,
         HHExpNFMedGood_6M_Purch,
         HHExpNFMedGood_6M_MN,
         HHExpNFMedGood_6M_CRD,
    HHExpNFMedGood_6M_GiftAid,
         HHExpNFCloth_6M_Purch,
         HHExpNFCloth_6M_MN,
         HHExpNFCloth_6M_CRD,
    HHExpNFCloth_6M_GiftAid,
         HHExpNFEduFee_6M_Purch,
         HHExpNFEduFee_6M_MN,
         HHExpNFEduFee_6M_CRD,
    HHExpNFEduFee_6M_GiftAid,
         HHExpNFEduGood_6M_Purch,
         HHExpNFEduGood_6M_MN,
         HHExpNFEduGood_6M_CRD,
    HHExpNFEduGood_6M_GiftAid,
         HHExpNFRent_6M_Purch,
         HHExpNFRent_6M_MN,
         HHExpNFRent_6M_CRD,
    HHExpNFRent_6M_GiftAid,
         HHExpNFHHSoft_6M_Purch,
         HHExpNFHHSoft_6M_MN,
         HHExpNFHHSoft_6M_CRD,
    HHExpNFHHSoft_6M_GiftAid,
         HHExpNFSav_6M_Tot,
         HHExpNFDebt_6M_Tot,
         HHExpNFInsurance_6M_Tot)


library(haven)
exampledataFrancais_raw <- read_sav("example_datasets/exampledataFrancais_raw.sav")


exampledataFrancais_rawv2 <- bind_cols(exampledataFrancais_raw,exp_examples)


exampledataFrancais_rawv2  %>% write_sav("example_datasets/exampledataFrancais_raw.sav")

