chdir("C:\Users\matve\Desktop\Code These\")
//TRAD SANS CHOC
load(string(fichier)+'\Blim_sans_choc'+string(cas),'Blim');
load(string(fichier)+'\Pro_sans_choc'+string(cas),'Pro');
load(string(fichier)+'\Foodssect_sans_choc'+string(cas),'Foodssect');
load(string(fichier)+'\nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
BlimTradAR=Blim(:,1)-SeuilBiologie(1)
BlimTradAA=Blim(:,2)-SeuilBiologie(2)
BlimTradAcoupa=max(BlimTradAR,BlimTradAA)
BlimTradMB=Blim(:,3)-SeuilBiologie(3)
ProTrad=sum(Pro,"c");
FoodssectTrad=Foodssect-SeuilSocial;
Nb_boatsTrad=sum(nb_boats_Post_BAU_t,"c")-SeuilBoat
//SUS CHOC
load(string(fichier)+'\SusBlim_choc'+string(cas),'Blim');
load(string(fichier)+'\SusPro_choc'+string(cas),'Pro');
load(string(fichier)+'\SusFoodssect_choc'+string(cas),'Foodssect');
load(string(fichier)+'\SusBateau_choc'+string(cas),'nb_boats_Post_BAU_t');
BlimSus_chocAR=Blim(:,1)-SeuilBiologie(1)
BlimSus_chocAA=Blim(:,2)-SeuilBiologie(2)
BlimSus_chocAcoupa=max(BlimSus_chocAR,BlimSus_chocAA)
BlimSus_chocMB=Blim(:,3)-SeuilBiologie(3)
ProSus_choc=sum(Pro,"c");
FoodssectSus_choc=Foodssect-SeuilSocial;
Nb_boatsSus_choc=sum(nb_boats_Post_BAU_t,"c")-SeuilBoat
////////////////////////////////////////////////////////////////////////////////////////////////////
//SUS SANS CHOC
load(string(fichier)+'\Blim_Sus'+string(cas),'Blim');
load(string(fichier)+'\Pro_Sus'+string(cas),'Pro');
load(string(fichier)+'\Foodssect_Sus'+string(cas),'Foodssect');
load(string(fichier)+'\Bateau_Sus'+string(cas),'nb_boats_Post_BAU_t');
BlimSusAR=Blim(:,1)-SeuilBiologie(1)
BlimSusAA=Blim(:,2)-SeuilBiologie(2)
BlimSusAcoupa=max(BlimSusAR,BlimSusAA)
BlimSusMB=Blim(:,3)-SeuilBiologie(3)
ProSus=sum(Pro,"c");
FoodssectSus=Foodssect-SeuilSocial;
NbBoatSus=sum(nb_boats_Post_BAU_t,"c")-SeuilBoat;
//DEL CHOC
load(string(fichier)+'\DelBlim_choc'+string(cas),'Blim');
load(string(fichier)+'\DelPro_choc'+string(cas),'Pro');
load(string(fichier)+'\DelFoodssect_choc'+string(cas),'Foodssect');
load(string(fichier)+'\DelBateau_choc'+string(cas),'nb_boats_Post_BAU_t');
BlimDel_chocAR=Blim(:,1)-SeuilBiologie(1)
BlimDel_chocAA=Blim(:,2)-SeuilBiologie(2)
BlimDel_chocAcoupa=max(BlimDel_chocAR,BlimDel_chocAA)
BlimDel_chocMB=Blim(:,3)-SeuilBiologie(3)
ProDel_choc=sum(Pro,"c");
FoodssectDel_choc=Foodssect-SeuilSocial;
NbBoatDel_choc=sum(nb_boats_Post_BAU_t,"c")-SeuilBoat;
//DEL SANS CHOC
load(string(fichier)+'\Blim_Del'+string(cas),'Blim');
load(string(fichier)+'\'+'Pro_Del'+string(cas),'Pro');
load(string(fichier)+'\'+'Foodssect_Del'+string(cas),'Foodssect');
load(string(fichier)+'\'+'Bateau_Del'+string(cas),'nb_boats_Post_BAU_t');
BlimDelAR=Blim(:,1)-SeuilBiologie(1)
BlimDelAA=Blim(:,2)-SeuilBiologie(2)
BlimDelAcoupa=max(BlimDelAR,BlimDelAA)
BlimDelMB=Blim(:,3)-SeuilBiologie(3)
ProDel=sum(Pro,"c");
FoodssectDel=Foodssect-SeuilSocial;
NbBoatDel=sum(nb_boats_Post_BAU_t,"c")-SeuilBoat;
