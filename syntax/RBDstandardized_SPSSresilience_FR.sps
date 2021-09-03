***************************************************************************************.
*****************************Calcul du Shock exposure index********************* .
***************************************************************************************.
*Le calcul de cet indicator sera différent de la manière dont il a été décrit. En effet dans le guide d'origine cet indicateur est égal à la moyenne pondérée des chocs subis par le ménage au cours des,.
* 12 derniers mois avec le poids correspondant à la gravtité du choc sur le revenu et la SAN du ménage.
*Dans notre cas nous alons suposer que le même poids pour tous les chocs subis. 

*Calcul du nombre de chocs subis au cours des 12 derniers mois. 

compute nbshocks=sum(Pluies_12m,Secheresse_12m,Glissementterrain_12m, Maladiescultures_12m, 
RavageursCultures_12m,MauvaisesHeres_12m, MaladiesBetails_12m, Epidemies_12m, VolsDestructionBiens_12m, VolBetails_12m, 
RetardsAideHumanitaire_12m, AugPrixAliments_12m, AugmPrixIntrants_12m, BaissePrixAgriElev_12m, PertesTerres_12m, 
Chomagejeune_12m, DecesMembreMenage_12m ).

EXECUTE.

*Calcul de la gravité du choc.

MISSING VALUES GraviteImpactRevenus GraviteImpactSAN (888,8888) .
EXECUTE.
compute Greviteshock=sum(GraviteImpactRevenus,GraviteImpactSAN).
EXECUTE.

compute ShockExposureIdex=Greviteshock*nbshocks.

VARIABLE LABELS ShockExposureIdex "Shock Exposure Index".
EXECUTE.
***************************************************************************************.
*****************************	Ability to recover index *****************************.
***************************************************************************************.

compute AbilitytoRecoverIndex=sum(CACRetabCapAlim, CACRetabCapAlim_1y).
VARIABLE LABELS AbilitytoRecoverIndex "Ability to recover index".
EXECUTE.

**************************************************************************************.
*****************************	Bonding Captital Index *****************************.
***************************************************************************************.
RECODE SCIAideIntraCom SCIAideDehorsCom SCIPersAiderDehorsCom (1=1) (4=0) (2=2) (3=3).
MISSING VALUES SCIAideIntraCom (888,8888).
EXECUTE. 

*Il est important de noter que dans les prochaines collectes la première question, SCIAideIntraCom, devra être en choix multiples et non en choix unique. 

compute BondingCapcitalIndex=sum(SCIAideIntraCom,SCIPersAAiderCom.1, SCIPersAAiderCom.2, SCIPersAAiderCom.3).

VARIABLE LABELS BondingCapcitalIndex "Bonding Captital Index".
EXECUTE.


**************************************************************************************.
*****************************	Bridging Captital Index *****************************.
***************************************************************************************.
MISSING VALUES SCIAideDehorsCom SCIPersAiderDehorsCom (888,8888).

*Lors des prochaines collectes les deux questions ci-dessous,SCIAideDehorsCom et SCIPersAiderDehorsCom,   devront être en choix multiples et non en choix unique. 
 
compute BridgingCapcitalIndex=sum(SCIAideDehorsCom,SCIPersAiderDehorsCom).

VARIABLE LABELS BridgingCapcitalIndex "Bridging Captital Index".
EXECUTE.




**************************************************************************************.
*****************************	SERS *****************************.
***************************************************************************************.

*** Calculer SERS

RECODE SERSRebondir (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser1.
VARIABLE LABELS  ser1 'sers1'.

RECODE SERSDifficultes (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser2.
VARIABLE LABELS  ser2 'sers2'.

RECODE SERSMoyen (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser3.
VARIABLE LABELS  ser3 'sers3'.

RECODE SERSRevenue (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser4.
VARIABLE LABELS  ser4 'sers4'.

RECODE SERSSurvivre (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser5.
VARIABLE LABELS  ser5 'sers5'.

RECODE SERSFamAmis (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser6.
VARIABLE LABELS  ser6 'sers6'.

RECODE SERSPoliticiens (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser7.
VARIABLE LABELS  ser7 'sers7'.

RECODE SERSLecons (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser8.
VARIABLE LABELS  ser8 'sers8'.

RECODE SERSPreparerFuture (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser9.
VARIABLE LABELS  ser9 'sers9'.

RECODE SERSAvertissementEven (5=0) (4=1) (3=2) (2=3) (1=4) INTO ser10.
VARIABLE LABELS  ser10 'sers10'.
EXECUTE.

compute serab = sum(ser1,ser2)/2.
EXECUTE.

compute SERS = sum(serab,ser3,ser4,ser5,ser6,ser7,ser8,ser9,ser10)/36.
Variable labels SERS "indicateur subjectif de la resilience".
EXECUTE.

