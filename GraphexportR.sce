chdir('C:\Users\matve\Desktop\Code These\');
load('ResilienceMSY\Bsimul26','B_simul_26');
exec('ResilienceMSY\donnees.sce');
exec('ResilienceMSY\fctdyn.sce');
chdir('')//a changer en fonction du fichier de destination 
t_0=0;
//Graphique pour les biomasses
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
T_proj=256
cas="26"
fichier='ResilienceBAU'
//TRAD SANS CHOC
////////////////////////////////////////BLIM////////////////////////////////////////
load(string(fichier)+'\Blim_sans_choc'+string(cas),'Blim');
BlimTrad=Blim;
load(string(fichier)+'\Blim_Del'+string(cas),'Blim');
BlimSus=Blim;
load(string(fichier)+'\Blim_Sus'+string(cas),'Blim');
BlimDel=Blim;
Blim(:,1)=(BlimTrad(:,1)+BlimDel(:,1)+BlimSus(:,1))./3

BlimMATAR=[BlimTrad(:,1),BlimDel(:,1),BlimSus(:,1)]
BlimARMax=min(BlimMATAR, 'c')
BlimARMin(:,1)=max(BlimMATAR, 'c')
BlimAR=mean(BlimMATAR, 'c')

BlimMATAA=[BlimTrad(:,2),BlimDel(:,2),BlimSus(:,2)]
BlimAAMax=min(BlimMATAA, 'c')
BlimAAMin(:,1)=max(BlimMATAA, 'c')
BlimAA=mean(BlimMATAA, 'c')

BlimMATMB=[BlimTrad(:,3),BlimDel(:,3),BlimSus(:,3)]
BlimMBMax=min(BlimMATMB, 'c')
BlimMBMin(:,1)=max(BlimMATMB, 'c')
BlimMB=mean(BlimMATMB, 'c')

////////////////////////////////////////PRO////////////////////////////////////////
load(string(fichier)+'\Pro_sans_choc'+string(cas),'Pro');
ProTrad=sum(Pro,"c");
load(string(fichier)+'\Pro_Del'+string(cas),'Pro');
ProDel=sum(Pro,"c");
load(string(fichier)+'\Pro_Sus'+string(cas),'Pro');
ProSus=sum(Pro,"c");
ProMat=[ProTrad,ProDel,ProSus]
ProMax=min(ProMat, 'c')
ProMin=max(ProMat, 'c')
Pro=mean(ProMat, 'c')

////////////////////////////////////////FOODSSECT///////////////////////////////////////
load(string(fichier)+'\Foodssect_sans_choc'+string(cas),'Foodssect');
FoodssectTrad=Foodssect
load(string(fichier)+'\Foodssect_Del'+string(cas),'Foodssect');
FoodssectDel=Foodssect
load(string(fichier)+'\Foodssect_Sus'+string(cas),'Foodssect');
FoodssectSus=Foodssect
FoodssectMat=[FoodssectTrad,FoodssectDel,FoodssectSus]
FoodssectMax=min(FoodssectMat, 'c')
FoodssectMin=max(FoodssectMat, 'c')
Foodssect=mean(FoodssectMat, 'c')

////////////////////////////////////////BATEAU///////////////////////////////////////
load(string(fichier)+'\nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
NbBoatTrad=sum(nb_boats_Post_BAU_t,"c")
NbBoatCCTrad=nb_boats_Post_BAU_t(:,1)
NbBoatCCATrad=nb_boats_Post_BAU_t(:,2)
NbBoatTAPTrad=nb_boats_Post_BAU_t(:,3)
load(string(fichier)+'\Bateau_Del'+string(cas),'nb_boats_Post_BAU_t')
NbBoatDel=sum(nb_boats_Post_BAU_t,"c")
NbBoatCCDel=nb_boats_Post_BAU_t(:,1)
NbBoatCCADel=nb_boats_Post_BAU_t(:,2)
NbBoatTAPDel=nb_boats_Post_BAU_t(:,3)
load(string(fichier)+'\Bateau_Sus'+string(cas),'nb_boats_Post_BAU_t')
NbBoatSus=sum(nb_boats_Post_BAU_t,"c")
NbBoatMat=[NbBoatTrad,NbBoatDel,NbBoatSus]
NbBoatMax=min(NbBoatMat, 'c')
NbBoatMin=max(NbBoatMat, 'c')
NbBoat=mean(NbBoatMat, 'c')

NbBoatCCSus=nb_boats_Post_BAU_t(:,1)
NbBoatCCMat=[NbBoatCCTrad,NbBoatCCDel,NbBoatCCSus]
NbBoatCCMax=min(NbBoatCCMat, 'c')
NbBoatCCMin=max(NbBoatCCMat, 'c')
NbBoatCC=mean(NbBoatCCMat, 'c')

NbBoatCCASus=nb_boats_Post_BAU_t(:,2)
NbBoatCCAMat=[NbBoatCCATrad,NbBoatCCADel,NbBoatCCASus]
NbBoatCCAMax=min(NbBoatCCAMat, 'c')
NbBoatCCAMin=max(NbBoatCCAMat, 'c')
NbBoatCCA=mean(NbBoatCCAMat, 'c')

NbBoatTAPSus=nb_boats_Post_BAU_t(:,3)
NbBoatTAPMat=[NbBoatTAPTrad,NbBoatTAPDel,NbBoatTAPSus]
NbBoatTAPMax=min(NbBoatTAPMat, 'c')
NbBoatTAPMin=max(NbBoatTAPMat, 'c')
NbBoatTAP=mean(NbBoatTAPMat, 'c')

////////////////////////////////////////EFFORT///////////////////////////////////////
EffortTrad=nb_j_peche_per_boats_per_trim(1).*NbBoatCCTrad+nb_j_peche_per_boats_per_trim(2).*NbBoatCCATrad+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPTrad
EffortDel=nb_j_peche_per_boats_per_trim(1).*NbBoatCCDel+nb_j_peche_per_boats_per_trim(2).*NbBoatCCADel+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPDel
EffortSus=nb_j_peche_per_boats_per_trim(1).*NbBoatCCSus+nb_j_peche_per_boats_per_trim(2).*NbBoatCCASus+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPSus

EffortMat=[EffortTrad,EffortDel,EffortSus]
EffortMax=min(EffortMat, 'c')
EffortMin=max(EffortMat, 'c')
Effort=mean(EffortMat, 'c')
///////////////////////////////////////////////////////////////////////////////
MatriceBlimAR=[]
MatriceBlimAA=[]
MatriceBlimMB=[]
MatriceFoodssect=[]
MatriceNbBoat=[]
MatriceNbBoatCC=[]
MatriceNbBoatCCA=[]
MatriceNbBoatTAP=[]
MatricePro=[]
MatriceEffort=[]

MatriceBlimAA=[MatriceBlimAA,BlimAA]
MatriceBlimAA=[MatriceBlimAA,BlimAAMin]
MatriceBlimAA=[MatriceBlimAA,BlimAAMax]

MatriceBlimAR=[MatriceBlimAR,BlimAR]
MatriceBlimAR=[MatriceBlimAR,BlimARMin]
MatriceBlimAR=[MatriceBlimAR,BlimARMax]

MatriceBlimMB=[MatriceBlimMB,BlimMB]
MatriceBlimMB=[MatriceBlimMB,BlimMBMin]
MatriceBlimMB=[MatriceBlimMB,BlimMBMax]

MatriceFoodssect=[MatriceFoodssect,Foodssect]
MatriceFoodssect=[MatriceFoodssect,FoodssectMin]
MatriceFoodssect=[MatriceFoodssect,FoodssectMax]

MatriceNbBoat=[MatriceNbBoat,NbBoat]
MatriceNbBoat=[MatriceNbBoat,NbBoatMin]
MatriceNbBoat=[MatriceNbBoat,NbBoatMax]

MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCC]
MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCCMin]
MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCCMax]

MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCA]
MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCAMin]
MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCAMax]

MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAP]
MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAPMin]
MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAPMax]

MatriceEffort=[MatriceEffort,Effort]
MatriceEffort=[MatriceEffort,EffortMin]
MatriceEffort=[MatriceEffort,EffortMax]

MatricePro=[MatricePro,Pro]
MatricePro=[MatricePro,ProMin]
MatricePro=[MatricePro,ProMax]

fichier='ResilienceMEY2'
//TRAD SANS CHOC
////////////////////////////////////////BLIM////////////////////////////////////////
load(string(fichier)+'\Blim_sans_choc'+string(cas),'Blim');
BlimTrad=Blim;
load(string(fichier)+'\Blim_Del'+string(cas),'Blim');
BlimSus=Blim;
load(string(fichier)+'\Blim_Sus'+string(cas),'Blim');
BlimDel=Blim;
Blim(:,1)=(BlimTrad(:,1)+BlimDel(:,1)+BlimDel(:,1))./3

BlimMATAR=[BlimTrad(:,1),BlimDel(:,1),BlimSus(:,1)]
BlimARMax=min(BlimMATAR, 'c')
BlimARMin(:,1)=max(BlimMATAR, 'c')
BlimAR=mean(BlimMATAR, 'c')

BlimMATAA=[BlimTrad(:,2),BlimDel(:,2),BlimSus(:,2)]
BlimAAMax=min(BlimMATAA, 'c')
BlimAAMin(:,1)=max(BlimMATAA, 'c')
BlimAA=mean(BlimMATAA, 'c')

BlimMATMB=[BlimTrad(:,3),BlimDel(:,3),BlimSus(:,3)]
BlimMBMax=min(BlimMATMB, 'c')
BlimMBMin(:,1)=max(BlimMATMB, 'c')
BlimMB=mean(BlimMATMB, 'c')

////////////////////////////////////////PRO////////////////////////////////////////
load(string(fichier)+'\Pro_sans_choc'+string(cas),'Pro');
ProTrad=sum(Pro,"c");
load(string(fichier)+'\Pro_Del'+string(cas),'Pro');
ProDel=sum(Pro,"c");
load(string(fichier)+'\Pro_Sus'+string(cas),'Pro');
ProSus=sum(Pro,"c");
ProMat=[ProTrad,ProDel,ProSus]
ProMax=min(ProMat, 'c')
ProMin=max(ProMat, 'c')
Pro=mean(ProMat, 'c')

////////////////////////////////////////FOODSSECT///////////////////////////////////////
load(string(fichier)+'\Foodssect_sans_choc'+string(cas),'Foodssect');
FoodssectTrad=Foodssect
load(string(fichier)+'\Foodssect_Del'+string(cas),'Foodssect');
FoodssectDel=Foodssect
load(string(fichier)+'\Foodssect_Sus'+string(cas),'Foodssect');
FoodssectSus=Foodssect
FoodssectMat=[FoodssectTrad,FoodssectDel,FoodssectSus]
FoodssectMax=min(FoodssectMat, 'c')
FoodssectMin=max(FoodssectMat, 'c')
Foodssect=mean(FoodssectMat, 'c')

////////////////////////////////////////BATEAU///////////////////////////////////////
load(string(fichier)+'\nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
NbBoatTrad=sum(nb_boats_Post_BAU_t,"c")
NbBoatCCTrad=nb_boats_Post_BAU_t(:,1)
NbBoatCCATrad=nb_boats_Post_BAU_t(:,2)
NbBoatTAPTrad=nb_boats_Post_BAU_t(:,3)
load(string(fichier)+'\Bateau_Del'+string(cas),'nb_boats_Post_BAU_t')
NbBoatDel=sum(nb_boats_Post_BAU_t,"c")
NbBoatCCDel=nb_boats_Post_BAU_t(:,1)
NbBoatCCADel=nb_boats_Post_BAU_t(:,2)
NbBoatTAPDel=nb_boats_Post_BAU_t(:,3)
load(string(fichier)+'\Bateau_Sus'+string(cas),'nb_boats_Post_BAU_t')
NbBoatSus=sum(nb_boats_Post_BAU_t,"c")
NbBoatMat=[NbBoatTrad,NbBoatDel,NbBoatSus]
NbBoatMax=min(NbBoatMat, 'c')
NbBoatMin=max(NbBoatMat, 'c')
NbBoat=mean(NbBoatMat, 'c')

NbBoatCCSus=nb_boats_Post_BAU_t(:,1)
NbBoatCCMat=[NbBoatCCTrad,NbBoatCCDel,NbBoatCCSus]
NbBoatCCMax=min(NbBoatCCMat, 'c')
NbBoatCCMin=max(NbBoatCCMat, 'c')
NbBoatCC=mean(NbBoatCCMat, 'c')

NbBoatCCASus=nb_boats_Post_BAU_t(:,2)
NbBoatCCAMat=[NbBoatCCATrad,NbBoatCCADel,NbBoatCCASus]
NbBoatCCAMax=min(NbBoatCCAMat, 'c')
NbBoatCCAMin=max(NbBoatCCAMat, 'c')
NbBoatCCA=mean(NbBoatCCAMat, 'c')

NbBoatTAPSus=nb_boats_Post_BAU_t(:,3)
NbBoatTAPMat=[NbBoatTAPTrad,NbBoatTAPDel,NbBoatTAPSus]
NbBoatTAPMax=min(NbBoatTAPMat, 'c')
NbBoatTAPMin=max(NbBoatTAPMat, 'c')
NbBoatTAP=mean(NbBoatTAPMat, 'c')

////////////////////////////////////////EFFORT///////////////////////////////////////
EffortTrad=nb_j_peche_per_boats_per_trim(1).*NbBoatCCTrad+nb_j_peche_per_boats_per_trim(2).*NbBoatCCATrad+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPTrad
EffortDel=nb_j_peche_per_boats_per_trim(1).*NbBoatCCDel+nb_j_peche_per_boats_per_trim(2).*NbBoatCCADel+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPDel
EffortSus=nb_j_peche_per_boats_per_trim(1).*NbBoatCCSus+nb_j_peche_per_boats_per_trim(2).*NbBoatCCASus+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPSus

EffortMat=[EffortTrad,EffortDel,EffortSus]
EffortMax=min(EffortMat, 'c')
EffortMin=max(EffortMat, 'c')
Effort=mean(EffortMat, 'c')
///////////////////////////////////////////////////////////////////////////////
MatriceBlimAA=[MatriceBlimAA,BlimAA]
MatriceBlimAA=[MatriceBlimAA,BlimAAMin]
MatriceBlimAA=[MatriceBlimAA,BlimAAMax]

MatriceBlimAR=[MatriceBlimAR,BlimAR]
MatriceBlimAR=[MatriceBlimAR,BlimARMin]
MatriceBlimAR=[MatriceBlimAR,BlimARMax]

MatriceBlimMB=[MatriceBlimMB,BlimMB]
MatriceBlimMB=[MatriceBlimMB,BlimMBMin]
MatriceBlimMB=[MatriceBlimMB,BlimMBMax]

MatriceFoodssect=[MatriceFoodssect,Foodssect]
MatriceFoodssect=[MatriceFoodssect,FoodssectMin]
MatriceFoodssect=[MatriceFoodssect,FoodssectMax]

MatriceNbBoat=[MatriceNbBoat,NbBoat]
MatriceNbBoat=[MatriceNbBoat,NbBoatMin]
MatriceNbBoat=[MatriceNbBoat,NbBoatMax]

MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCC]
MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCCMin]
MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCCMax]

MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCA]
MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCAMin]
MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCAMax]

MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAP]
MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAPMin]
MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAPMax]

MatriceEffort=[MatriceEffort,Effort]
MatriceEffort=[MatriceEffort,EffortMin]
MatriceEffort=[MatriceEffort,EffortMax]

MatricePro=[MatricePro,Pro]
MatricePro=[MatricePro,ProMin]
MatricePro=[MatricePro,ProMax]


fichier='ResilienceClosure'
//TRAD SANS CHOC
////////////////////////////////////////BLIM////////////////////////////////////////
load(string(fichier)+'\Blim_sans_choc'+string(cas),'Blim');
BlimTrad=Blim;
load(string(fichier)+'\Blim_Del'+string(cas),'Blim');
BlimSus=Blim;
load(string(fichier)+'\Blim_Sus'+string(cas),'Blim');
BlimDel=Blim;
Blim(:,1)=(BlimTrad(:,1)+BlimDel(:,1)+BlimDel(:,1))./3

BlimMATAR=[BlimTrad(:,1),BlimDel(:,1),BlimSus(:,1)]
BlimARMax=min(BlimMATAR, 'c')
BlimARMin(:,1)=max(BlimMATAR, 'c')
BlimAR=mean(BlimMATAR, 'c')

BlimMATAA=[BlimTrad(:,2),BlimDel(:,2),BlimSus(:,2)]
BlimAAMax=min(BlimMATAA, 'c')
BlimAAMin(:,1)=max(BlimMATAA, 'c')
BlimAA=mean(BlimMATAA, 'c')

BlimMATMB=[BlimTrad(:,3),BlimDel(:,3),BlimSus(:,3)]
BlimMBMax=min(BlimMATMB, 'c')
BlimMBMin(:,1)=max(BlimMATMB, 'c')
BlimMB=mean(BlimMATMB, 'c')

////////////////////////////////////////PRO////////////////////////////////////////
load(string(fichier)+'\Pro_sans_choc'+string(cas),'Pro');
ProTrad=sum(Pro,"c");
load(string(fichier)+'\Pro_Del'+string(cas),'Pro');
ProDel=sum(Pro,"c");
load(string(fichier)+'\Pro_Sus'+string(cas),'Pro');
ProSus=sum(Pro,"c");
ProMat=[ProTrad,ProDel,ProSus]
ProMax=min(ProMat, 'c')
ProMin=max(ProMat, 'c')
Pro=mean(ProMat, 'c')

////////////////////////////////////////FOODSSECT///////////////////////////////////////
load(string(fichier)+'\Foodssect_sans_choc'+string(cas),'Foodssect');
FoodssectTrad=Foodssect
load(string(fichier)+'\Foodssect_Del'+string(cas),'Foodssect');
FoodssectDel=Foodssect
load(string(fichier)+'\Foodssect_Sus'+string(cas),'Foodssect');
FoodssectSus=Foodssect
FoodssectMat=[FoodssectTrad,FoodssectDel,FoodssectSus]
FoodssectMax=min(FoodssectMat, 'c')
FoodssectMin=max(FoodssectMat, 'c')
Foodssect=mean(FoodssectMat, 'c')

////////////////////////////////////////BATEAU///////////////////////////////////////
load(string(fichier)+'\nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
NbBoatTrad=sum(nb_boats_Post_BAU_t,"c")
NbBoatCCTrad=nb_boats_Post_BAU_t(:,1)
NbBoatCCATrad=nb_boats_Post_BAU_t(:,2)
NbBoatTAPTrad=nb_boats_Post_BAU_t(:,3)
load(string(fichier)+'\Bateau_Del'+string(cas),'nb_boats_Post_BAU_t')
NbBoatDel=sum(nb_boats_Post_BAU_t,"c")
NbBoatCCDel=nb_boats_Post_BAU_t(:,1)
NbBoatCCADel=nb_boats_Post_BAU_t(:,2)
NbBoatTAPDel=nb_boats_Post_BAU_t(:,3)
load(string(fichier)+'\Bateau_Sus'+string(cas),'nb_boats_Post_BAU_t')
NbBoatSus=sum(nb_boats_Post_BAU_t,"c")
NbBoatMat=[NbBoatTrad,NbBoatDel,NbBoatSus]
NbBoatMax=min(NbBoatMat, 'c')
NbBoatMin=max(NbBoatMat, 'c')
NbBoat=mean(NbBoatMat, 'c')

NbBoatCCSus=nb_boats_Post_BAU_t(:,1)
NbBoatCCMat=[NbBoatCCTrad,NbBoatCCDel,NbBoatCCSus]
NbBoatCCMax=min(NbBoatCCMat, 'c')
NbBoatCCMin=max(NbBoatCCMat, 'c')
NbBoatCC=mean(NbBoatCCMat, 'c')

NbBoatCCASus=nb_boats_Post_BAU_t(:,2)
NbBoatCCAMat=[NbBoatCCATrad,NbBoatCCADel,NbBoatCCASus]
NbBoatCCAMax=min(NbBoatCCAMat, 'c')
NbBoatCCAMin=max(NbBoatCCAMat, 'c')
NbBoatCCA=mean(NbBoatCCAMat, 'c')

NbBoatTAPSus=nb_boats_Post_BAU_t(:,3)
NbBoatTAPMat=[NbBoatTAPTrad,NbBoatTAPDel,NbBoatTAPSus]
NbBoatTAPMax=min(NbBoatTAPMat, 'c')
NbBoatTAPMin=max(NbBoatTAPMat, 'c')
NbBoatTAP=mean(NbBoatTAPMat, 'c')

////////////////////////////////////////EFFORT///////////////////////////////////////
EffortTrad=nb_j_peche_per_boats_per_trim(1).*NbBoatCCTrad+nb_j_peche_per_boats_per_trim(2).*NbBoatCCATrad+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPTrad
EffortDel=nb_j_peche_per_boats_per_trim(1).*NbBoatCCDel+nb_j_peche_per_boats_per_trim(2).*NbBoatCCADel+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPDel
EffortSus=nb_j_peche_per_boats_per_trim(1).*NbBoatCCSus+nb_j_peche_per_boats_per_trim(2).*NbBoatCCASus+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPSus

EffortMat=[EffortTrad,EffortDel,EffortSus]
EffortMax=min(EffortMat, 'c')
EffortMin=max(EffortMat, 'c')
Effort=mean(EffortMat, 'c')
///////////////////////////////////////////////////////////////////////////////
MatriceBlimAA=[MatriceBlimAA,BlimAA]
MatriceBlimAA=[MatriceBlimAA,BlimAAMin]
MatriceBlimAA=[MatriceBlimAA,BlimAAMax]

MatriceBlimAR=[MatriceBlimAR,BlimAR]
MatriceBlimAR=[MatriceBlimAR,BlimARMin]
MatriceBlimAR=[MatriceBlimAR,BlimARMax]

MatriceBlimMB=[MatriceBlimMB,BlimMB]
MatriceBlimMB=[MatriceBlimMB,BlimMBMin]
MatriceBlimMB=[MatriceBlimMB,BlimMBMax]

MatriceFoodssect=[MatriceFoodssect,Foodssect]
MatriceFoodssect=[MatriceFoodssect,FoodssectMin]
MatriceFoodssect=[MatriceFoodssect,FoodssectMax]

MatriceNbBoat=[MatriceNbBoat,NbBoat]
MatriceNbBoat=[MatriceNbBoat,NbBoatMin]
MatriceNbBoat=[MatriceNbBoat,NbBoatMax]

MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCC]
MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCCMin]
MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCCMax]

MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCA]
MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCAMin]
MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCAMax]

MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAP]
MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAPMin]
MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAPMax]

MatriceEffort=[MatriceEffort,Effort]
MatriceEffort=[MatriceEffort,EffortMin]
MatriceEffort=[MatriceEffort,EffortMax]

MatricePro=[MatricePro,Pro]
MatricePro=[MatricePro,ProMin]
MatricePro=[MatricePro,ProMax]

fichier='ResilienceMSY'
//TRAD SANS CHOC
//TRAD SANS CHOC
//TRAD SANS CHOC
////////////////////////////////////////BLIM////////////////////////////////////////
load(string(fichier)+'\Blim_sans_choc'+string(cas),'Blim');
BlimTrad=Blim;
load(string(fichier)+'\Blim_Del'+string(cas),'Blim');
BlimSus=Blim;
load(string(fichier)+'\Blim_Sus'+string(cas),'Blim');
BlimDel=Blim;
Blim(:,1)=(BlimTrad(:,1)+BlimDel(:,1)+BlimDel(:,1))./3

BlimMATAR=[BlimTrad(:,1),BlimDel(:,1),BlimSus(:,1)]
BlimARMax=min(BlimMATAR, 'c')
BlimARMin(:,1)=max(BlimMATAR, 'c')
BlimAR=mean(BlimMATAR, 'c')

BlimMATAA=[BlimTrad(:,2),BlimDel(:,2),BlimSus(:,2)]
BlimAAMax=min(BlimMATAA, 'c')
BlimAAMin(:,1)=max(BlimMATAA, 'c')
BlimAA=mean(BlimMATAA, 'c')

BlimMATMB=[BlimTrad(:,3),BlimDel(:,3),BlimSus(:,3)]
BlimMBMax=min(BlimMATMB, 'c')
BlimMBMin(:,1)=max(BlimMATMB, 'c')
BlimMB=mean(BlimMATMB, 'c')

////////////////////////////////////////PRO////////////////////////////////////////
load(string(fichier)+'\Pro_sans_choc'+string(cas),'Pro');
ProTrad=sum(Pro,"c");
load(string(fichier)+'\Pro_Del'+string(cas),'Pro');
ProDel=sum(Pro,"c");
load(string(fichier)+'\Pro_Sus'+string(cas),'Pro');
ProSus=sum(Pro,"c");
ProMat=[ProTrad,ProDel,ProSus]
ProMax=min(ProMat, 'c')
ProMin=max(ProMat, 'c')
Pro=mean(ProMat, 'c')

////////////////////////////////////////FOODSSECT///////////////////////////////////////
load(string(fichier)+'\Foodssect_sans_choc'+string(cas),'Foodssect');
FoodssectTrad=Foodssect
load(string(fichier)+'\Foodssect_Del'+string(cas),'Foodssect');
FoodssectDel=Foodssect
load(string(fichier)+'\Foodssect_Sus'+string(cas),'Foodssect');
FoodssectSus=Foodssect
FoodssectMat=[FoodssectTrad,FoodssectDel,FoodssectSus]
FoodssectMax=min(FoodssectMat, 'c')
FoodssectMin=max(FoodssectMat, 'c')
Foodssect=mean(FoodssectMat, 'c')

////////////////////////////////////////BATEAU///////////////////////////////////////
load(string(fichier)+'\nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
NbBoatTrad=sum(nb_boats_Post_BAU_t,"c")
NbBoatCCTrad=nb_boats_Post_BAU_t(:,1)
NbBoatCCATrad=nb_boats_Post_BAU_t(:,2)
NbBoatTAPTrad=nb_boats_Post_BAU_t(:,3)
load(string(fichier)+'\Bateau_Del'+string(cas),'nb_boats_Post_BAU_t')
NbBoatDel=sum(nb_boats_Post_BAU_t,"c")
NbBoatCCDel=nb_boats_Post_BAU_t(:,1)
NbBoatCCADel=nb_boats_Post_BAU_t(:,2)
NbBoatTAPDel=nb_boats_Post_BAU_t(:,3)
load(string(fichier)+'\Bateau_Sus'+string(cas),'nb_boats_Post_BAU_t')
NbBoatSus=sum(nb_boats_Post_BAU_t,"c")
NbBoatMat=[NbBoatTrad,NbBoatDel,NbBoatSus]
NbBoatMax=min(NbBoatMat, 'c')
NbBoatMin=max(NbBoatMat, 'c')
NbBoat=mean(NbBoatMat, 'c')

NbBoatCCSus=nb_boats_Post_BAU_t(:,1)
NbBoatCCMat=[NbBoatCCTrad,NbBoatCCDel,NbBoatCCSus]
NbBoatCCMax=min(NbBoatCCMat, 'c')
NbBoatCCMin=max(NbBoatCCMat, 'c')
NbBoatCC=mean(NbBoatCCMat, 'c')

NbBoatCCASus=nb_boats_Post_BAU_t(:,2)
NbBoatCCAMat=[NbBoatCCATrad,NbBoatCCADel,NbBoatCCASus]
NbBoatCCAMax=min(NbBoatCCAMat, 'c')
NbBoatCCAMin=max(NbBoatCCAMat, 'c')
NbBoatCCA=mean(NbBoatCCAMat, 'c')

NbBoatTAPSus=nb_boats_Post_BAU_t(:,3)
NbBoatTAPMat=[NbBoatTAPTrad,NbBoatTAPDel,NbBoatTAPSus]
NbBoatTAPMax=min(NbBoatTAPMat, 'c')
NbBoatTAPMin=max(NbBoatTAPMat, 'c')
NbBoatTAP=mean(NbBoatTAPMat, 'c')

////////////////////////////////////////EFFORT///////////////////////////////////////
EffortTrad=nb_j_peche_per_boats_per_trim(1).*NbBoatCCTrad+nb_j_peche_per_boats_per_trim(2).*NbBoatCCATrad+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPTrad
EffortDel=nb_j_peche_per_boats_per_trim(1).*NbBoatCCDel+nb_j_peche_per_boats_per_trim(2).*NbBoatCCADel+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPDel
EffortSus=nb_j_peche_per_boats_per_trim(1).*NbBoatCCSus+nb_j_peche_per_boats_per_trim(2).*NbBoatCCASus+nb_j_peche_per_boats_per_trim(3).*NbBoatTAPSus

EffortMat=[EffortTrad,EffortDel,EffortSus]
EffortMax=min(EffortMat, 'c')
EffortMin=max(EffortMat, 'c')
Effort=mean(EffortMat, 'c')
///////////////////////////////////////////////////////////////////////////////
MatriceBlimAA=[MatriceBlimAA,BlimAA]
MatriceBlimAA=[MatriceBlimAA,BlimAAMin]
MatriceBlimAA=[MatriceBlimAA,BlimAAMax]

MatriceBlimAR=[MatriceBlimAR,BlimAR]
MatriceBlimAR=[MatriceBlimAR,BlimARMin]
MatriceBlimAR=[MatriceBlimAR,BlimARMax]

MatriceBlimMB=[MatriceBlimMB,BlimMB]
MatriceBlimMB=[MatriceBlimMB,BlimMBMin]
MatriceBlimMB=[MatriceBlimMB,BlimMBMax]

MatriceFoodssect=[MatriceFoodssect,Foodssect]
MatriceFoodssect=[MatriceFoodssect,FoodssectMin]
MatriceFoodssect=[MatriceFoodssect,FoodssectMax]

MatriceNbBoat=[MatriceNbBoat,NbBoat]
MatriceNbBoat=[MatriceNbBoat,NbBoatMin]
MatriceNbBoat=[MatriceNbBoat,NbBoatMax]

MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCC]
MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCCMin]
MatriceNbBoatCC=[MatriceNbBoatCC,NbBoatCCMax]

MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCA]
MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCAMin]
MatriceNbBoatCCA=[MatriceNbBoatCCA,NbBoatCCAMax]

MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAP]
MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAPMin]
MatriceNbBoatTAP=[MatriceNbBoatTAP,NbBoatTAPMax]

MatriceEffort=[MatriceEffort,Effort]
MatriceEffort=[MatriceEffort,EffortMin]
MatriceEffort=[MatriceEffort,EffortMax]

MatricePro=[MatricePro,Pro]
MatricePro=[MatricePro,ProMin]
MatricePro=[MatricePro,ProMax]

/////
Blimite=[]
for i=1:T_proj
    Blimite(i,1)=9867
    Blimite(i,2)=41079
    Blimite(i,3)=19484
end
MatriceBlimAR=[MatriceBlimAR,Blimite(:,1)]
MatriceBlimAA=[MatriceBlimAA,Blimite(:,2)]
MatriceBlimMB=[MatriceBlimMB,Blimite(:,3)]
/////
FoodssectLim=[]
for i=1:T_proj
    FoodssectLim(i,1)=1.6
end
MatriceFoodssect=[MatriceFoodssect,FoodssectLim]
/////
BoatLim=[]
for i=1:T_proj
    BoatLim(i,1)=60
end
MatriceNbBoat=[MatriceNbBoat,BoatLim]
BoatCCLim=[]
for i=1:T_proj
    BoatCCLim(i,1)=0
end
MatriceNbBoatCC=[MatriceNbBoatCC,BoatCCLim]
BoatCCALim=[]
for i=1:T_proj
    BoatCCALim(i,1)=0
end
MatriceNbBoatCCA=[MatriceNbBoatCCA,BoatCCALim]
BoatTAPLim=[]
for i=1:T_proj
    BoatTAPLim(i,1)=0
end
MatriceNbBoatTAP=[MatriceNbBoatTAP,BoatTAPLim]
/////
ProLim=[]
for i=1:T_proj
    ProLim(i,1)=0
end
MatricePro=[MatricePro,ProLim]

EffortLim=[]
for i=1:T_proj
    EffortLim(i,1)=0
end
MatriceEffort=[MatriceEffort,EffortLim]
/////
chdir('GRAPH');
csvWrite(MatricePro,'MatricePro'+string(cas)+'.csv');
csvWrite(MatriceNbBoat,'MatriceNbBoat'+string(cas)+'.csv');
csvWrite(MatriceNbBoatCC,'MatriceNbBoatCC'+string(cas)+'.csv');
csvWrite(MatriceNbBoatCCA,'MatriceNbBoatCCA'+string(cas)+'.csv');
csvWrite(MatriceNbBoatTAP,'MatriceNbBoatTAP'+string(cas)+'.csv');
csvWrite(MatriceFoodssect,'MatriceFoodssect'+string(cas)+'.csv');
csvWrite(MatriceBlimAR,'MatriceBlimAR'+string(cas)+'.csv');
csvWrite(MatriceBlimAA,'MatriceBlimAA'+string(cas)+'.csv');
csvWrite(MatriceBlimMB,'MatriceBlimMB'+string(cas)+'.csv');
csvWrite(MatriceEffort,'MatriceEffort'+string(cas)+'.csv');

//BAU
MatriceBAU=[MatriceFoodssect(48,1),MatriceFoodssect(111,1),MatriceFoodssect(256,1);MatricePro(48,1),MatricePro(111,1),MatricePro(256,1);MatriceEffort(48,1),MatriceEffort(111,1),MatriceEffort(256,1);MatriceBlimAA(48,1),MatriceBlimAA(111,1),MatriceBlimAA(256,1);MatriceBlimAR(48,1),MatriceBlimAR(111,1),MatriceBlimAR(256,1);MatriceBlimMB(48,1),MatriceBlimMB(111,1),MatriceBlimMB(256,1)]
csvWrite(MatriceBAU,'MatriceBAU'+string(cas)+'.csv');

//MEY
MatriceMEY=[MatriceFoodssect(48,4),MatriceFoodssect(111,4),MatriceFoodssect(256,4);MatricePro(48,4),MatricePro(111,4),MatricePro(256,4);MatriceEffort(48,4),MatriceEffort(111,4),MatriceEffort(256,4);MatriceBlimAA(48,4),MatriceBlimAA(111,4),MatriceBlimAA(256,4);MatriceBlimAR(48,4),MatriceBlimAR(111,4),MatriceBlimAR(256,4);MatriceBlimMB(48,4),MatriceBlimMB(111,4),MatriceBlimMB(256,4)]
csvWrite(MatriceMEY,'MatriceMEY'+string(cas)+'.csv');

//CLOS
MatriceCLOS=[MatriceFoodssect(48,7),MatriceFoodssect(111,7),MatriceFoodssect(256,7);MatricePro(48,7),MatricePro(111,7),MatricePro(256,7);MatriceEffort(48,7),MatriceEffort(111,7),MatriceEffort(256,7);MatriceBlimAA(48,7),MatriceBlimAA(111,7),MatriceBlimAA(256,7);MatriceBlimAR(48,7),MatriceBlimAR(111,7),MatriceBlimAR(256,7);MatriceBlimMB(48,7),MatriceBlimMB(111,7),MatriceBlimMB(256,7)]
csvWrite(MatriceCLOS,'MatriceCLOS'+string(cas)+'.csv');

//MSY
MatriceMSY=[MatriceFoodssect(48,10),MatriceFoodssect(111,10),MatriceFoodssect(256,10);MatricePro(48,10),MatricePro(111,10),MatricePro(256,10);MatriceEffort(48,10),MatriceEffort(111,10),MatriceEffort(256,10);MatriceBlimAA(48,10),MatriceBlimAA(111,10),MatriceBlimAA(256,10);MatriceBlimAR(48,10),MatriceBlimAR(111,10),MatriceBlimAR(256,10);MatriceBlimMB(48,10),MatriceBlimMB(111,10),MatriceBlimMB(256,10)]
csvWrite(MatriceMSY,'MatriceMSY'+string(cas)+'.csv');
