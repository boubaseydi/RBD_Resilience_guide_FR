* Constitution des groupes alimentaires pour les FEMMES 15-49 ans

     * Groupe des cereales et tubercules

do if (Q15_1_1=1 or Q15_1_2=1).
compute GR_Certuber=1.
ELSE.
compute GR_Certuber=0.
end if.
EXECUTE

     * Groupe des Légumineuses 

do if (Q15_1_3=1).
compute GR_Legumineuse=1.
ELSE.
compute GR_Legumineuse=0.
end if.
EXECUTE

  * Groupe des graines

do if (Q15_1_4=1).
compute GR_Graine=1.
ELSE.
compute GR_Graine=0.
end if.
EXECUTE

  * Groupe des produits laitiers

do if (Q15_1_13=1).
compute GR_Lait=1.
ELSE.
compute GR_Lait=0.
end if.
EXECUTE

* Groupe Poisson, fruits de mer,  viande

do if (Q15_1_14=1 or Q15_1_15=1 or Q15_1_16=1 or Q15_1_17=1).
compute GR_Pois.Viand=1.
ELSE.
compute GR_Pois.Viand=0.
end if.
EXECUTE

  * Groupe des Oeufs

do if (Q15_1_12=1).
compute GR_Oeufs=1.
ELSE.
compute GR_Oeufs=0.
end if.
EXECUTE

  * Groupe des legumes-feuilles verts foncés

do if (Q15_1_6=1).
compute GR_Legume.feuille=1.
ELSE.
compute GR_Legume.feuille=0.
end if.
EXECUTE

* Groupe Fruits, Legumes riches en vitamine A

do if (Q15_1_5=1 or Q15_1_8=1).
compute GR_Fruit.Leg.richvitA=1.
ELSE.
compute GR_Fruit.Leg.richvitA=0.
end if.
EXECUTE

  * Groupe des autres legumes

do if (Q15_1_7=1).
compute GR_autre.Legume=1.
ELSE.
compute GR_autre.Legume=0.
end if.
EXECUTE

  * Groupe des autres fruits

do if (Q15_1_9=1).
compute GR_autre.Fruit=1.
ELSE.
compute GR_autre.Fruit=0.
end if.
EXECUTE

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
EXECUTE

DATASET ACTIVATE Ensemble_de_données1.
FREQUENCIES VARIABLES=W_MDD_class
  /ORDER=ANALYSIS.

