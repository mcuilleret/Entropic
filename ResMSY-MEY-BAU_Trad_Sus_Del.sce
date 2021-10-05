chdir("C:\Users\matve\Desktop\Code These\")
//////////////////////////////RESILIENCE////////////////////
///charger la serie a etudier 
fichier='ResilienceBAU'
fichier='ResilienceMEY2'
fichier='ResilienceMSY'
cas="26"
for fichier=list('ResilienceMSY','ResilienceBAU','ResilienceMEY2','ResilienceClosure')
    for cas=list("26","85")
/////////////////////////////////////////////////////////////////////////////////////CHARGEMENT DES DONNEES
//TRAD SANS CHOC
load(string(fichier)+'\Blim_sans_choc'+string(cas),'Blim');
load(string(fichier)+'\Pro_sans_choc'+string(cas),'Pro');
load(string(fichier)+'\Foodssect_sans_choc'+string(cas),'Foodssect');
load(string(fichier)+'\nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
Blim(:,1)=Blim(:,1)
Blim(:,2)=Blim(:,2)
Blim(:,3)=Blim(:,3)
BlimTrad=Blim;
ProTrad=sum(Pro,"c");
FoodssectTrad=Foodssect;
NbBoatTrad=nb_boats_Post_BAU_t;
NbBoatMean=sum(nb_boats_Post_BAU_t,"c")
for n=1:(256/4);
   tmin=(n-1)*4+1
   tmax=(n-1)*4+4
   ProTradAn(n,1)=sum(ProTrad(tmin:tmax));
   BlimTradAn(n,1)=mean(Blim(tmin:tmax,1));
   BlimTradAn(n,2)=mean(Blim(tmin:tmax,2));
   BlimTradAn(n,3)=mean(Blim(tmin:tmax,3));
   FoodssectTradAn(n,1)=sum(FoodssectTrad(tmin:tmax));
   NbBoatTradAn(n,1)=mean(NbBoatMean(tmin:tmax));
end
//////////////////////////////////////////////////////////////////////////////////////////////
//SUS SANS CHOC
load(string(fichier)+'\Blim_Sus'+string(cas),'Blim');
load(string(fichier)+'\Pro_Sus'+string(cas),'Pro');
load(string(fichier)+'\Foodssect_Sus'+string(cas),'Foodssect');
load(string(fichier)+'\Bateau_Sus'+string(cas),'nb_boats_Post_BAU_t');
Blim(:,1)=Blim(:,1)
Blim(:,2)=Blim(:,2)
Blim(:,3)=Blim(:,3)
BlimSus=Blim;
ProSus=sum(Pro,"c");
FoodssectSus=Foodssect;
NbBoatSus=nb_boats_Post_BAU_t;
NbBoatMean=sum(nb_boats_Post_BAU_t,"c")
for n=1:(256/4);
   tmin=(n-1)*4+1
   tmax=(n-1)*4+4
   ProSusAn(n,1)=sum(ProSus(tmin:tmax));
   BlimSusAn(n,1)=mean(Blim(tmin:tmax,1));
   BlimSusAn(n,2)=mean(Blim(tmin:tmax,2));
   BlimSusAn(n,3)=mean(Blim(tmin:tmax,3));
   FoodssectSusAn(n,1)=sum(FoodssectSus(tmin:tmax));
   NbBoatSusAn(n,1)=mean(sum(NbBoatMean(tmin:tmax)));
end
//DEL SANS CHOC
load(string(fichier)+'\Blim_Del'+string(cas),'Blim');
load(string(fichier)+'\'+'Pro_Del'+string(cas),'Pro');
load(string(fichier)+'\'+'Foodssect_Del'+string(cas),'Foodssect');
load(string(fichier)+'\'+'Bateau_Del'+string(cas),'nb_boats_Post_BAU_t');
Blim(:,1)=Blim(:,1)
Blim(:,2)=Blim(:,2)
Blim(:,3)=Blim(:,3)
BlimDel=Blim;
ProDel=sum(Pro,"c");
FoodssectDel=Foodssect;
NbBoatDel=nb_boats_Post_BAU_t;
NbBoatMean=sum(nb_boats_Post_BAU_t,"c")
for n=1:(256/4);
   tmin=(n-1)*4+1
   tmax=(n-1)*4+4
   ProDelAn(n,1)=sum(ProDel(tmin:tmax));
   BlimDelAn(n,1)=mean(Blim(tmin:tmax,1));
   BlimDelAn(n,2)=mean(Blim(tmin:tmax,2));
   BlimDelAn(n,3)=mean(Blim(tmin:tmax,3));
   FoodssectDelAn(n,1)=sum(FoodssectDel(tmin:tmax));
   NbBoatDelAn(n,1)=mean(NbBoatMean(tmin:tmax));
end
//////////////////////////////////IND//////////////////////////////////////////
SeuilProfit=0
SeuilBiologie=[9867,41079,19484]
SeuilSocial=1.64
SeuilBoat=60
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////RECOVERY//////////////////
IndDelAn=[];
IndDelTotAn=[];
IndDelAn=[IndDelAn,bool2s(FoodssectDelAn<SeuilSocial*4),bool2s(bool2s(bool2s(BlimDelAn(:,1)>=SeuilBiologie(1))+bool2s(BlimDelAn(:,2)>=SeuilBiologie(2))>=1)+bool2s(BlimDelAn(:,3)>=SeuilBiologie(3))<2),bool2s(ProDelAn<=0),bool2s(NbBoatDelAn<=SeuilBoat)];
IndDelTotAn=[IndDelTotAn,bool2s(sum(IndDelAn,"c")~=0)];
IndSusAn=[];
IndSusTotAn=[];
IndSusAn=[IndSusAn,bool2s(FoodssectSusAn<SeuilSocial*4),bool2s(bool2s(bool2s(BlimSusAn(:,1)>=SeuilBiologie(1))+bool2s(BlimSusAn(:,2)>=SeuilBiologie(2))>=1)+bool2s(BlimSusAn(:,3)>=SeuilBiologie(3))<2),bool2s(ProSusAn<=0),bool2s(NbBoatSusAn<=SeuilBoat)];
IndSusTotAn=[IndSusTotAn,bool2s(sum(IndSusAn,"c")~=0)];
IndTradAn=[];
IndTradTotAn=[];
IndTradAn=[IndTradAn,bool2s(FoodssectTradAn<SeuilSocial*4),bool2s(bool2s(bool2s(BlimTradAn(:,1)>=SeuilBiologie(1))+bool2s(BlimTradAn(:,2)>=SeuilBiologie(2))>=1)+bool2s(BlimTradAn(:,3)>=SeuilBiologie(3))<2),bool2s(ProTradAn<=0),bool2s(NbBoatTradAn<=SeuilBoat)];
IndTradTotAn=[IndTradTotAn,bool2s(sum(IndTradAn,"c")~=0)];
///////////////////////////////////////////////////////////////////////////////
IndDel=[];
IndDelTot=[];
IndDel=[IndDel,bool2s(FoodssectDel<SeuilSocial),bool2s(bool2s(bool2s(BlimDel(:,1)>=SeuilBiologie(1))+bool2s(BlimDel(:,2)>=SeuilBiologie(2))>=1)+bool2s(BlimDel(:,3)>=SeuilBiologie(3))<2),bool2s(ProDel<=0),bool2s(sum(NbBoatDel,"c")<=SeuilBoat)];
IndDelTot=[IndDelTot,bool2s(sum(IndDel,"c")~=0)];
//////////////////////////////////////////////////////////////////////////////////////////////
IndSus=[];
IndSusTot=[];
IndSus=[IndSus,bool2s(FoodssectSus<SeuilSocial),bool2s(bool2s(bool2s(BlimSus(:,1)>=SeuilBiologie(1))+bool2s(BlimSus(:,2)>=SeuilBiologie(2))>=1)+bool2s(BlimSus(:,3)>=SeuilBiologie(3))<2),bool2s(ProSus<=0),bool2s(sum(NbBoatSus,"c")<=SeuilBoat)];
IndSusTot=[IndSusTot,bool2s(sum(IndSus,"c")~=0)];
//////////////////////////////////////////////////////////////////////////////////////////////
IndTrad=[];
IndTradTot=[];
IndTrad=[IndTrad,bool2s(FoodssectTrad<SeuilSocial),bool2s(bool2s(bool2s(BlimTrad(:,1)>=SeuilBiologie(1))+bool2s(BlimTrad(:,2)>=SeuilBiologie(2))>=1)+bool2s(BlimTrad(:,3)>=SeuilBiologie(3))<2),bool2s(ProTrad<=0),bool2s(sum(NbBoatTrad,"c")<=SeuilBoat)];
IndTradTot=[IndTradTot,bool2s(sum(IndTrad,"c")~=0)];
////////////////////////////////////////////ROBUSTNESS///////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
RobustnessFoodssectTrad=1-(sum(IndTrad(49:size(IndTrad)(1),1))/(size(IndTrad)(1)-48))
RobustnessFoodssectDel=1-(sum(IndDel(49:size(IndDel)(1),1))/(size(IndDel)(1)-48))
RobustnessFoodssectSus=1-(sum(IndSus(49:size(IndSus)(1),1))/(size(IndSus)(1)-48))
//////////////////////////////////////////////////////////////////////////////
RobustnessTotalTrad=1-(sum(IndTradTot(49:size(IndTradTot)(1),1))/(size(IndTradTot)(1)-48));
RobustnessTotalDel=1-(sum(IndDelTot(49:size(IndDelTot)(1),1))/(size(IndDelTot)(1)-48));
RobustnessTotalSus=1-(sum(IndSusTot(49:size(IndSusTot)(1),1))/(size(IndSusTot)(1)-48));
/////////////////////////////////////////////////////////////////////////////
RobustnessBiologieTrad=1-(sum(IndTrad(49:size(IndTrad)(1),2))/(size(IndTrad)(1)-48))
RobustnessBiologieDel=1-(sum(IndDel(49:size(IndDel)(1),2))/(size(IndDel)(1)-48))
RobustnessBiologieSus=1-(sum(IndSus(49:size(IndSus)(1),2))/(size(IndSus)(1)-48))
//////////////////////////////////////////////////////////////////////////////

RobustnessEconomieTrad=1-(sum(IndTrad(49:size(IndTrad)(1),3))/(size(IndTrad)(1)-48))
RobustnessEconomieDel=1-(sum(IndDel(49:size(IndDel)(1),3))/(size(IndDel)(1)-48))
RobustnessEconomieSus=1-(sum(IndSus(49:size(IndSus)(1),3))/(size(IndSus)(1)-48))
////////////////////////////////////////////////////////////////////////////////////////
RobustnessNbBoatTrad=1-(sum(IndTrad(49:size(IndTrad)(1),4))/(size(IndTrad)(1)-48))
RobustnessNbBoatDel=1-(sum(IndDel(49:size(IndDel)(1),4))/(size(IndDel)(1)-48))
RobustnessNbBoatSus=1-(sum(IndSus(49:size(IndSus)(1),4))/(size(IndSus)(1)-48))
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
RobustnessTrad=[RobustnessFoodssectTrad,RobustnessBiologieTrad,RobustnessEconomieTrad,RobustnessNbBoatTrad,RobustnessTotalTrad];
save(string(fichier)+'\RobustnessTrad'+string(cas),'RobustnessTrad');
RobustnessDel=[RobustnessFoodssectDel,RobustnessBiologieDel,RobustnessEconomieDel,RobustnessNbBoatDel,RobustnessTotalDel];
save(string(fichier)+'\RobustnessDel'+string(cas),'RobustnessDel');
RobustnessSus=[RobustnessFoodssectSus,RobustnessBiologieSus,RobustnessEconomieSus,RobustnessNbBoatSus,RobustnessTotalSus];
save(string(fichier)+'\RobustnessSus'+string(cas),'RobustnessSus');
////////////////////////////////////////////////RECOVERY////////////////////////////////////
chdir('');
exec('recovery.sce');
save(string(fichier)+'\RecoveryDel'+string(cas),'RecoveryDel');
save(string(fichier)+'\RecoverySus'+string(cas),'RecoverySus');
save(string(fichier)+'\RecoveryTrad'+string(cas),'RecoveryTrad');
end
clear()
end

//////////////////////////////////////////////////////////////////////////////
///////////////////////////////RESISTANCE/////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
cas="26"
for cas=list("26","85")
SeuilProfit=0
SeuilBiologie=[9867,41079,19484]
SeuilSocial=1.64
SeuilBoat=60
////////////////////////MEY/////////////////////////////////////
//TRAITEMENT 
fichier='ResilienceMEY2'
exec('ResilienceMSY\ChargementFichiers.sce');
////////////////////////////////////////////////////////////////////////////////
MatriceProfitMEY=[]
MatriceProfitMEY=[MatriceProfitMEY,ProDel,ProSus,ProTrad]
save('ResilienceMEY2\MatriceProfitMEY'+string(cas),'MatriceProfitMEY');
MatriceBlimAcoupaMEY=[]
MatriceBlimAcoupaMEY=[MatriceBlimAcoupaMEY,BlimDelAcoupa,BlimSusAcoupa,BlimTradAcoupa]
save('ResilienceMEY2\MatriceBlimAcoupaMEY'+string(cas),'MatriceBlimAcoupaMEY');

MatriceBlimARMEY=[]
MatriceBlimARMEY=[MatriceBlimARMEY,BlimDelAR,BlimSusAR,BlimTradAR]
save('ResilienceMEY2\MatriceBlimARMEY'+string(cas),'MatriceBlimARMEY');
MatriceBlimAAMEY=[]
MatriceBlimAAMEY=[MatriceBlimAAMEY,BlimDelAA,BlimSusAA,BlimTradAA]
save('ResilienceMEY2\MatriceBlimAAMEY'+string(cas),'MatriceBlimAAMEY');


MatriceBlimMBMEY=[]
MatriceBlimMBMEY=[MatriceBlimMBMEY,BlimDelMB,BlimSusMB,BlimTradMB]
save('ResilienceMEY2\MatriceBlimMBMEY'+string(cas),'MatriceBlimMBMEY');
MatriceFoodssectMEY=[]
MatriceFoodssectMEY=[MatriceFoodssectMEY,FoodssectDel,FoodssectSus,FoodssectTrad]
save('ResilienceMEY2\MatriceFoodssectMEY'+string(cas),'MatriceFoodssectMEY');
MatriceNbBoatMEY=[]
MatriceNbBoatMEY=[MatriceNbBoatMEY,NbBoatDel,NbBoatSus,Nb_boatsTrad]
save('ResilienceMEY2\MatriceNbBoatMEY'+string(cas),'MatriceNbBoatMEY');
////////////////////////////////////////////////////////////////////////////////
////////////////////////CLOSURE/////////////////////////////////////
fichier='ResilienceClosure'
exec('ResilienceMSY\ChargementFichiers.sce');
////////////////////////////////////////////////////////////////////////////////
MatriceProfitClos=[]
MatriceProfitClos=[MatriceProfitClos,ProDel,ProSus,ProTrad]
save('ResilienceClosure\MatriceProfitClos'+string(cas),'MatriceProfitClos');

MatriceBlimAcoupaClos=[]
MatriceBlimAcoupaClos=[MatriceBlimAcoupaClos,BlimDelAcoupa,BlimSusAcoupa,BlimTradAcoupa]
save('ResilienceClosure\MatriceBlimAcoupaClos'+string(cas),'MatriceBlimAcoupaClos');

MatriceBlimARClos=[]
MatriceBlimARClos=[MatriceBlimARClos,BlimDelAR,BlimSusAR,BlimTradAR]
save('ResilienceClosure\MatriceBlimARClos'+string(cas),'MatriceBlimARClos');
MatriceBlimAAClos=[]
MatriceBlimAAClos=[MatriceBlimAAClos,BlimDelAA,BlimSusAA,BlimTradAA]
save('ResilienceClosure\MatriceBlimAAClos'+string(cas),'MatriceBlimAAClos');

MatriceBlimMBClos=[]
MatriceBlimMBClos=[MatriceBlimMBClos,BlimDelMB,BlimSusMB,BlimTradMB]
save('ResilienceClosure\MatriceBlimMBClos'+string(cas),'MatriceBlimMBClos');

MatriceFoodssectClos=[]
MatriceFoodssectClos=[MatriceFoodssectClos,FoodssectDel,FoodssectSus,FoodssectTrad]
save('ResilienceClosure\MatriceFoodssectClos'+string(cas),'MatriceFoodssectClos');

MatriceNbBoatClos=[]
MatriceNbBoatClos=[MatriceNbBoatClos,NbBoatDel,NbBoatSus,Nb_boatsTrad]
save('ResilienceClosure\MatriceNbBoatClos'+string(cas),'MatriceNbBoatClos');

////////////////////////////////////////////////////////////////////////////////
////////////////////////MSY/////////////////////////////////////
fichier='ResilienceMSY'
exec('ResilienceMSY\ChargementFichiers.sce');
////////////////////////////////////////////////////////////////////////////////
MatriceProfitMSY=[]
MatriceProfitMSY=[MatriceProfitMSY,ProDel,ProSus,ProTrad]
save('ResilienceMSY\MatriceProfitMSY'+string(cas),'MatriceProfitMSY');
MatriceBlimAcoupaMSY=[]
MatriceBlimAcoupaMSY=[MatriceBlimAcoupaMSY,BlimDelAcoupa,BlimSusAcoupa,BlimTradAcoupa]
save('ResilienceMSY\MatriceBlimAcoupaMSY'+string(cas),'MatriceBlimAcoupaMSY');
MatriceBlimARMSY=[]
MatriceBlimARMSY=[MatriceBlimARMSY,BlimDelAR,BlimSusAR,BlimTradAR]
save('ResilienceMSY\MatriceBlimARMSY'+string(cas),'MatriceBlimARMSY');
MatriceBlimAAMSY=[]
MatriceBlimAAMSY=[MatriceBlimAAMSY,BlimDelAA,BlimSusAA,BlimTradAA]
save('ResilienceMSY\MatriceBlimAAMSY'+string(cas),'MatriceBlimAAMSY');
MatriceBlimMBMSY=[]
MatriceBlimMBMSY=[MatriceBlimMBMSY,BlimDelMB,BlimSusMB,BlimTradMB]
save('ResilienceMSY\MatriceBlimMBMSY'+string(cas),'MatriceBlimMBMSY');
MatriceFoodssectMSY=[]
MatriceFoodssectMSY=[MatriceFoodssectMSY,FoodssectDel,FoodssectSus,FoodssectTrad]
save('ResilienceMSY\MatriceFoodssectMSY'+string(cas),'MatriceFoodssectMSY');
MatriceNbBoatMSY=[]
MatriceNbBoatMSY=[MatriceNbBoatMSY,NbBoatDel,NbBoatSus,Nb_boatsTrad]
save('ResilienceMSY\MatriceNbBoatMSY'+string(cas),'MatriceNbBoatMSY');

////////////////////////BAU/////////////////////////////////////
fichier='ResilienceBAU'
exec('ResilienceMSY\ChargementFichiers.sce');
////////////////////////////////////////////////////////////////////////////////
MatriceProfitBAU=[]
MatriceProfitBAU=[MatriceProfitBAU,ProDel,ProSus,ProTrad]
save('ResilienceBAU\MatriceProfitBAU'+string(cas),'MatriceProfitBAU');
MatriceBlimAcoupaBAU=[]
MatriceBlimAcoupaBAU=[MatriceBlimAcoupaBAU,BlimDelAcoupa,BlimSusAcoupa,BlimTradAcoupa]

MatriceBlimARBAU=[]
MatriceBlimARBAU=[MatriceBlimARBAU,BlimDelAR,BlimSusAR,BlimTradAR]
save('ResilienceBAU\MatriceBlimARBAU'+string(cas),'MatriceBlimARBAU');
MatriceBlimAABAU=[]
MatriceBlimAABAU=[MatriceBlimAABAU,BlimDelAA,BlimSusAA,BlimTradAA]
save('ResilienceBAU\MatriceBlimAABAU'+string(cas),'MatriceBlimAABAU');

save('ResilienceBAU\MatriceBlimAcoupaBAU'+string(cas),'MatriceBlimAcoupaBAU');
MatriceBlimMBBAU=[]
MatriceBlimMBBAU=[MatriceBlimMBBAU,BlimDelMB,BlimSusMB,BlimTradMB]
save('ResilienceBAU\MatriceBlimMBBAU'+string(cas),'MatriceBlimMBBAU');
MatriceFoodssectBAU=[]
MatriceFoodssectBAU=[MatriceFoodssectBAU,FoodssectDel,FoodssectSus,FoodssectTrad]
save('ResilienceBAU\MatriceFoodssectBAU'+string(cas),'MatriceFoodssectBAU');
MatriceNbBoatBAU=[]
MatriceNbBoatBAU=[MatriceNbBoatBAU,NbBoatDel,NbBoatSus,Nb_boatsTrad]
save('ResilienceBAU\MatriceNbBoatBAU'+string(cas),'MatriceNbBoatBAU');
////////////////////////////////////////////////////////////////////////////////
end

//TRAITEMENT
MatriceProfit=[]
MatriceBlimAcoupa=[]
MatriceBlimMB=[]
MatriceFoodssect=[]
MatriceNbBoat=[]
MatriceBlimAR=[]
MatriceBlimAA=[]
cas="26"
for cas=list("26","85") 
load('ResilienceBAU\MatriceFoodssectBAU'+string(cas),'MatriceFoodssectBAU');
load('ResilienceBAU\MatriceBlimAcoupaBAU'+string(cas),'MatriceBlimAcoupaBAU');
load('ResilienceBAU\MatriceBlimARBAU'+string(cas),'MatriceBlimARBAU');
load('ResilienceBAU\MatriceBlimAABAU'+string(cas),'MatriceBlimAABAU');
MatriceBlimAR=[MatriceBlimAR,MatriceBlimARBAU]
MatriceBlimAA=[MatriceBlimAA,MatriceBlimAABAU]
load('ResilienceBAU\MatriceBlimMBBAU'+string(cas),'MatriceBlimMBBAU');
load('ResilienceBAU\MatriceProfitBAU'+string(cas),'MatriceProfitBAU');
load('ResilienceBAU\MatriceNbBoatBAU'+string(cas),'MatriceNbBoatBAU');
MatriceProfit=[MatriceProfit,MatriceProfitBAU]
MatriceBlimAcoupa=[MatriceBlimAcoupa,MatriceBlimAcoupaBAU]
MatriceBlimMB=[MatriceBlimMB,MatriceBlimMBBAU]
MatriceFoodssect=[MatriceFoodssect,MatriceFoodssectBAU]
MatriceNbBoat=[MatriceNbBoat,MatriceNbBoatBAU]
load('ResilienceMSY\MatriceFoodssectMSY'+string(cas),'MatriceFoodssectMSY');
load('ResilienceMSY\MatriceBlimAcoupaMSY'+string(cas),'MatriceBlimAcoupaMSY');
load('ResilienceMSY\MatriceBlimARMSY'+string(cas),'MatriceBlimARMSY');
load('ResilienceMSY\MatriceBlimAAMSY'+string(cas),'MatriceBlimAAMSY');
MatriceBlimAR=[MatriceBlimAR,MatriceBlimARMSY]
MatriceBlimAA=[MatriceBlimAA,MatriceBlimAAMSY]
load('ResilienceMSY\MatriceBlimMBMSY'+string(cas),'MatriceBlimMBMSY');
load('ResilienceMSY\MatriceProfitMSY'+string(cas),'MatriceProfitMSY');
load('ResilienceMSY\MatriceNbBoatMSY'+string(cas),'MatriceNbBoatMSY');
MatriceProfit=[MatriceProfit,MatriceProfitMSY]
MatriceBlimAcoupa=[MatriceBlimAcoupa,MatriceBlimAcoupaMSY]
MatriceBlimMB=[MatriceBlimMB,MatriceBlimMBMSY]
MatriceFoodssect=[MatriceFoodssect,MatriceFoodssectMSY]
MatriceNbBoat=[MatriceNbBoat,MatriceNbBoatMSY]


load('ResilienceClosure\MatriceFoodssectClos'+string(cas),'MatriceFoodssectClos');
load('ResilienceClosure\MatriceBlimAcoupaClos'+string(cas),'MatriceBlimAcoupaClos');

load('ResilienceClosure\MatriceBlimARClos'+string(cas),'MatriceBlimARClos');
load('ResilienceClosure\MatriceBlimAAClos'+string(cas),'MatriceBlimAAClos');
MatriceBlimAR=[MatriceBlimAR,MatriceBlimARClos]
MatriceBlimAA=[MatriceBlimAA,MatriceBlimAAClos]
load('ResilienceClosure\MatriceBlimMBClos'+string(cas),'MatriceBlimMBClos');
load('ResilienceClosure\MatriceProfitClos'+string(cas),'MatriceProfitClos');
load('ResilienceClosure\MatriceNbBoatClos'+string(cas),'MatriceNbBoatClos');
MatriceProfit=[MatriceProfit,MatriceProfitClos]
MatriceBlimAcoupa=[MatriceBlimAcoupa,MatriceBlimAcoupaClos]
MatriceBlimMB=[MatriceBlimMB,MatriceBlimMBClos]
MatriceFoodssect=[MatriceFoodssect,MatriceFoodssectClos]
MatriceNbBoat=[MatriceNbBoat,MatriceNbBoatClos]


load('ResilienceMEY2\MatriceFoodssectMEY'+string(cas),'MatriceFoodssectMEY');
load('ResilienceMEY2\MatriceBlimAcoupaMEY'+string(cas),'MatriceBlimAcoupaMEY');

load('ResilienceMEY2\MatriceBlimARMEY'+string(cas),'MatriceBlimARMEY');
load('ResilienceMEY2\MatriceBlimAAMEY'+string(cas),'MatriceBlimAAMEY');
MatriceBlimAR=[MatriceBlimAR,MatriceBlimARMEY]
MatriceBlimAA=[MatriceBlimAA,MatriceBlimAAMEY]
load('ResilienceMEY2\MatriceBlimMBMEY'+string(cas),'MatriceBlimMBMEY');
load('ResilienceMEY2\MatriceProfitMEY'+string(cas),'MatriceProfitMEY');
load('ResilienceMEY2\MatriceNbBoatMEY'+string(cas),'MatriceNbBoatMEY');
MatriceProfit=[MatriceProfit,MatriceProfitMEY]
MatriceBlimAcoupa=[MatriceBlimAcoupa,MatriceBlimAcoupaMEY]
MatriceBlimMB=[MatriceBlimMB,MatriceBlimMBMEY]
MatriceFoodssect=[MatriceFoodssect,MatriceFoodssectMEY]
MatriceNbBoat=[MatriceNbBoat,MatriceNbBoatMEY]
end

MatriceProfit=MatriceProfit(49:256,:)
MatriceBlimAcoupa=MatriceBlimAcoupa(49:256,:)
MatriceBlimMB=MatriceBlimMB(49:256,:)
MatriceFoodssect=MatriceFoodssect(49:256,:)
MatriceNbBoat=MatriceNbBoat(49:256,:)
MatriceBlimAA=MatriceBlimAA(49:256,:)
MatriceBlimAR=MatriceBlimAR(49:256,:)

MinProfit=[]
MinProfit=min(MatriceProfit)
MinBlimAR=[]
MinBlimAR=min(MatriceBlimAR)
MinBlimAA=[]
MinBlimAA=min(MatriceBlimAA)
MinBlimAcoupa=[]
MinBlimAcoupa=min(MatriceBlimAcoupa)
MinBlimMB=[]
MinBlimMB=min(MatriceBlimMB)
MinFoodssect=[]
MinFoodssect=min(MatriceFoodssect)
MinNbBoat=[]
MinNbBoat=min(MatriceNbBoat)
/////////////////////////////////////////////////////////////////////////////////////
MaxProfit=[]
MaxProfit=max(MatriceProfit)
MaxBlimAcoupa=[]
MaxBlimAcoupa=max(MatriceBlimAcoupa)
MaxBlimAR=[]
MaxBlimAR=max(MatriceBlimAR)
MaxBlimAA=[]
MaxBlimAA=max(MatriceBlimAA)
MaxBlimMB=[]
MaxBlimMB=max(MatriceBlimMB)
MaxFoodssect=[]
MaxFoodssect=max(MatriceFoodssect)
MaxNbBoat=[]
MaxNbBoat=max(MatriceNbBoat)
/////////////////////////////////////////////////////////////////////////////////////
//NORMALISATION VIA UNE FONCTION AFFINE
B=[0;1];
A=[MinProfit,1;MaxProfit,1];
X=A\B;
NormProf=inv(A)*B;
///////////
B=[0;1]
A=[MinBlimAcoupa,1;MaxBlimAcoupa,1]
X=A\B
NormBLIMAcoupa=inv(A)*B
///////////
B=[0;1]
A=[MinBlimAR,1;MaxBlimAR,1]
X=A\B
NormBLIMAR=inv(A)*B
///////////
B=[0;1]
A=[MinBlimAA,1;MaxBlimAA,1]
X=A\B
NormBLIMAA=inv(A)*B
///////////
B=[0;1]
A=[MinBlimMB,1;MaxBlimMB,1]
X=A\B
NormBLIMMB=inv(A)*B
///////////
B=[0;1]
A=[MinFoodssect,1;MaxFoodssect,1]
X=A\B
NormFoodssect=inv(A)*B
///////////
B=[0;1]
A=[MinNbBoat,1;MaxNbBoat,1]
X=A\B
NormNbBoat=inv(A)*B

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
for cas=list("26","85") 
for fichier=list('ResilienceMSY','ResilienceBAU','ResilienceMEY2','ResilienceClosure')
//Trad SANS CHOC
////////////////////////////CHARGEMENT////////////////////////////////////
load(string(fichier)+'\Blim_sans_choc'+string(cas),'Blim');
load(string(fichier)+'\Pro_sans_choc'+string(cas),'Pro');
load(string(fichier)+'\Foodssect_sans_choc'+string(cas),'Foodssect');
load(string(fichier)+'\nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
BlimTradAR=Blim(:,1)-SeuilBiologie(1)
BlimTradAA=Blim(:,2)-SeuilBiologie(2)
BlimTradAcoupa=(mean(BlimTradAR(49:256,:)+BlimTradAA(49:256,:)))
BlimTradMB=(Blim(:,3)-SeuilBiologie(3))(49:256,:)
ProTrad=sum(Pro,"c")(49:256,:);
FoodssectTrad=(Foodssect-SeuilSocial)(49:256,:);
Nb_boatsTrad=(sum(nb_boats_Post_BAU_t,"c"))(49:256,:)-SeuilBoat


///////////////////////////////////////////////////////////////////////////////////
////////////////////////////SCORING////////////////////////////////////////////////
Taille=size(ProTrad)
Score_ProTrad=(sum(ProTrad*NormProf(1)+NormProf(2))/(Taille(1)*Taille(2)));
Taille=size(BlimTradAR)
Score_BlimTradAR=(sum(BlimTradAR*NormBLIMAR(1)+NormBLIMAR(2))/(Taille(1)*Taille(2)));
Taille=size(BlimTradAA)
Score_BlimTradAA=(sum(BlimTradAA*NormBLIMAA(1)+NormBLIMAA(2))/(Taille(1)*Taille(2)));
Taille=size(BlimTradAcoupa)
Score_BlimTradAcoupa=max(Score_BlimTradAR,Score_BlimTradAA);
Taille=size(BlimTradMB)
Score_BlimTradMB=(sum(BlimTradMB*NormBLIMMB(1)+NormBLIMMB(2))/(Taille(1)*Taille(2)));
Score_BlimTrad=((Score_BlimTradAcoupa)+(Score_BlimTradMB))/((2))
Taille=size(FoodssectTrad)
Score_FoodssectTrad=(sum(FoodssectTrad*NormFoodssect(1)+NormFoodssect(2))/(Taille(1)*Taille(2)));
Taille=size(Nb_boatsTrad)
Score_Nb_boatsTrad=(sum(Nb_boatsTrad*NormNbBoat(1)+NormNbBoat(2))/(Taille(1)*Taille(2)));
ResistanceTrad=[Score_FoodssectTrad,Score_BlimTrad,Score_ProTrad,Score_Nb_boatsTrad]
ResistanceTrad(:,5)=((ResistanceTrad(:,1).^2+ResistanceTrad(:,2).^2+ResistanceTrad(:,3).^2+ResistanceTrad(:,4).^2)^0.5)/(4^0.5)
save(string(fichier)+'\ResistanceTrad'+string(cas),'ResistanceTrad');

//Del 
////////////////////////////CHARGEMENT////////////////////////////////////
load(string(fichier)+'\Blim_Del'+string(cas),'Blim');
load(string(fichier)+'\'+'Pro_Del'+string(cas),'Pro');
load(string(fichier)+'\'+'Foodssect_Del'+string(cas),'Foodssect');
load(string(fichier)+'\'+'Bateau_Del'+string(cas),'nb_boats_Post_BAU_t');
BlimDelAR=Blim(:,1)-SeuilBiologie(1)
BlimDelAA=Blim(:,2)-SeuilBiologie(2)
BlimDelAcoupa=(mean(BlimDelAR(49:256,:)+BlimDelAA(49:256,:)))
BlimDelMB=(Blim(:,3)-SeuilBiologie(3))(49:256,:)
ProDel=sum(Pro,"c")(49:256,:);
FoodssectDel=(Foodssect-SeuilSocial)(49:256,:);
Nb_boatsDel=(sum(nb_boats_Post_BAU_t,"c")-SeuilBoat)(49:256,:)
////////////////////////////SCORING////////////////////////////////////
Taille=size(ProDel)
Score_ProDel=(sum(ProDel*NormProf(1)+NormProf(2))/(Taille(1)*Taille(2)));
Taille=size(BlimDelAcoupa)

Taille=size(BlimDelAR)
Score_BlimDelAR=(sum(BlimDelAR*NormBLIMAR(1)+NormBLIMAR(2))/(Taille(1)*Taille(2)));
Taille=size(BlimDelAA)
Score_BlimDelAA=(sum(BlimDelAA*NormBLIMAA(1)+NormBLIMAA(2))/(Taille(1)*Taille(2)));
Taille=size(BlimDelAcoupa)
Score_BlimDelAcoupa=max(Score_BlimDelAR,Score_BlimDelAA);

Taille=size(BlimDelMB)
Score_BlimDelMB=(sum(BlimDelMB*NormBLIMMB(1)+NormBLIMMB(2))/(Taille(1)*Taille(2)));
Score_BlimDel=(((Score_BlimDelAcoupa)+(Score_BlimDelMB)))/((2))
Taille=size(FoodssectDel)
Score_FoodssectDel=(sum(FoodssectDel*NormFoodssect(1)+NormFoodssect(2))/(Taille(1)*Taille(2)));
Taille=size(Nb_boatsDel)
Score_Nb_boatsDel=(sum(Nb_boatsDel*NormNbBoat(1)+NormNbBoat(2))/(Taille(1)*Taille(2)));
ResistanceDel=[Score_FoodssectDel,Score_BlimDel,Score_ProDel,Score_Nb_boatsDel]
ResistanceDel(:,5)=((ResistanceDel(:,1).^2+ResistanceDel(:,2).^2+ResistanceDel(:,3).^2+ResistanceDel(:,4).^2)^0.5)/(4^0.5)
save(string(fichier)+'\ResistanceDel'+string(cas),'ResistanceDel');

//SUSTAINABLE
//Sus SANS CHOC
load(string(fichier)+'\Blim_Sus'+string(cas),'Blim');
load(string(fichier)+'\Pro_Sus'+string(cas),'Pro');
load(string(fichier)+'\Foodssect_Sus'+string(cas),'Foodssect');
load(string(fichier)+'\Bateau_Sus'+string(cas),'nb_boats_Post_BAU_t');
BlimSusAR=Blim(:,1)-SeuilBiologie(1)
BlimSusAA=Blim(:,2)-SeuilBiologie(2)
BlimSusAcoupa=(mean(BlimSusAR(49:256,:)+BlimSusAA(49:256,:)))
BlimSusMB=(Blim(:,3)-SeuilBiologie(3))(49:256,:)
ProSus=sum(Pro,"c")(49:256,:);
FoodssectSus=(Foodssect-SeuilSocial)(49:256,:);
Nb_boatsSus=(sum(nb_boats_Post_BAU_t,"c")-SeuilBoat)(49:256,:)

////////////////////////////SCORING////////////////////////////////////
Taille=size(ProSus)
Score_ProSus=(sum(ProSus*NormProf(1)+NormProf(2))/(Taille(1)*Taille(2)));
Taille=size(BlimSusAcoupa)

Taille=size(BlimSusAR)
Score_BlimSusAR=(sum(BlimSusAR*NormBLIMAR(1)+NormBLIMAR(2))/(Taille(1)*Taille(2)));
Taille=size(BlimSusAA)
Score_BlimSusAA=(sum(BlimSusAA*NormBLIMAA(1)+NormBLIMAA(2))/(Taille(1)*Taille(2)));
Taille=size(BlimDelAcoupa)

Score_BlimSusAcoupa=max(Score_BlimSusAA,Score_BlimSusAR);
Taille=size(BlimSusMB)
Score_BlimSusMB=(sum(BlimSusMB*NormBLIMMB(1)+NormBLIMMB(2))/(Taille(1)*Taille(2)));
Score_BlimSus=(((Score_BlimSusAcoupa)+(Score_BlimSusMB)))/((2))
Taille=size(FoodssectSus)
Score_FoodssectSus=(sum(FoodssectSus*NormFoodssect(1)+NormFoodssect(2))/(Taille(1)*Taille(2)));
Taille=size(Nb_boatsSus)
Score_Nb_boatsSus=(sum(Nb_boatsSus*NormNbBoat(1)+NormNbBoat(2))/(Taille(1)*Taille(2)));
ResistanceSus=[Score_FoodssectSus,Score_BlimSus,Score_ProSus,Score_Nb_boatsSus]
ResistanceSus(:,5)=((ResistanceSus(:,1).^2+ResistanceSus(:,2).^2+ResistanceSus(:,3).^2+ResistanceSus(:,4).^2)^0.5)/(4^0.5)
save(string(fichier)+'\ResistanceSus'+string(cas),'ResistanceSus');
end
end

for fichier=list('ResilienceMSY','ResilienceBAU','ResilienceMEY2','ResilienceClosure')
    for cas=list("26","85")

////////////////////////////////////////////////////////////////////////////////////////
//SUS
load(string(fichier)+'\RecoverySus'+string(cas),'RecoverySus');
load(string(fichier)+'\RobustnessSus'+string(cas),'RobustnessSus');
load(string(fichier)+'\ResistanceSus'+string(cas),'ResistanceSus');
ResilienceSus=[RecoverySus;RobustnessSus;ResistanceSus]

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Trad
load(string(fichier)+'\RecoveryTrad'+string(cas),'RecoveryTrad');
load(string(fichier)+'\RobustnessTrad'+string(cas),'RobustnessTrad');
load(string(fichier)+'\ResistanceTrad'+string(cas),'ResistanceTrad');
ResilienceTrad=[RecoveryTrad;RobustnessTrad;ResistanceTrad]

////////////////////////////////////////////////////////////////////////////////////////
//Del
load(string(fichier)+'\RecoveryDel'+string(cas),'RecoveryDel');
load(string(fichier)+'\RobustnessDel'+string(cas),'RobustnessDel');
load(string(fichier)+'\ResistanceDel'+string(cas),'ResistanceDel');
ResilienceDel=[RecoveryDel;RobustnessDel;ResistanceDel]
Resilience=[]
Resilience=[ResilienceDel;ResilienceSus;ResilienceTrad]
for i=1:size(Resilience)(1) 
    for j=1:size(Resilience)(2)
        if Resilience(i,j)<0 then
            Resilience(i,j)=0
        end
        if Resilience(i,j)>1 then
            Resilience(i,j)=1
        end
end
end
save(string(fichier)+'\Resilience'+string(cas),'Resilience');
    end
end

fichier='ResilienceMSY'
cas=26
load(string(fichier)+'\Resilience'+string(cas),'Resilience');
ResilienceMSY26=Resilience
cas=85
load(string(fichier)+'\Resilience'+string(cas),'Resilience')
ResilienceMSY85=Resilience

fichier='ResilienceClosure'
cas=26
load(string(fichier)+'\Resilience'+string(cas),'Resilience');
ResilienceClosure26=Resilience
cas=85
load(string(fichier)+'\Resilience'+string(cas),'Resilience')
ResilienceClosure85=Resilience


fichier='ResilienceMEY2'
cas=26
load(string(fichier)+'\Resilience'+string(cas),'Resilience');
ResilienceMEY26=Resilience
cas=85
load(string(fichier)+'\Resilience'+string(cas),'Resilience');
ResilienceMEY85=Resilience

fichier='ResilienceBAU'
cas=26
load(string(fichier)+'\Resilience'+string(cas),'Resilience');
ResilienceBAU26=Resilience
cas=85
load(string(fichier)+'\Resilience'+string(cas),'Resilience');
ResilienceBAU85=Resilience

Resilience=[ResilienceBAU26;ResilienceBAU85;ResilienceMEY26;ResilienceMEY85;ResilienceMSY26;ResilienceMSY85;ResilienceClosure26;ResilienceClosure85]

chdir('');
csvWrite(Resilience,'Resilience.csv');

////////diff resilience/////////
DiffResilience=[]
DiffResBau=(ResilienceBAU85./ResilienceBAU26)-1
DiffResMEY=(ResilienceMEY85./ResilienceMEY26)-1
DiffResMSY=(ResilienceMSY85./ResilienceMSY26)-1
DiffResClos=(ResilienceClosure85./ResilienceClosure26)-1
DiffResilience=[DiffResBau;DiffResMEY;DiffResMSY;DiffResClos]

chdir('');
csvWrite(DiffResilience,'DiffResilience.csv');

//////////////////RESILIENCE OIL IMPACT//////////////////
DiffResOil=[]
///BAU
fichier='ResilienceMEY2'
for fichier=list('ResilienceMSY','ResilienceBAU','ResilienceMEY2','ResilienceClosure')
cas1="26"
cas2="85"
////////////////////////////////////////////////////////////////////////////////////////
//SUS
load(string(fichier)+'\RecoverySus'+string(cas1),'RecoverySus');
RecoverySus1=RecoverySus
load(string(fichier)+'\RecoverySus'+string(cas2),'RecoverySus');
RecoverySus2=RecoverySus
RecoverySus=[RecoverySus1;RecoverySus2]
RecoverySus=mean(RecoverySus,'r') 

load(string(fichier)+'\RobustnessSus'+string(cas1),'RobustnessSus');
RobustnessSus1=RobustnessSus
load(string(fichier)+'\RobustnessSus'+string(cas2),'RobustnessSus');
RobustnessSus2=RobustnessSus
RobustnessSus=[RobustnessSus1;RobustnessSus2]
RobustnessSus=mean(RobustnessSus,'r') 

load(string(fichier)+'\ResistanceSus'+string(cas1),'ResistanceSus');
ResistanceSus1=ResistanceSus
load(string(fichier)+'\ResistanceSus'+string(cas2),'ResistanceSus');
ResistanceSus2=ResistanceSus
ResistanceSus=[ResistanceSus1;ResistanceSus2]
ResistanceSus=mean(ResistanceSus,'r') 
ResilienceSus=[RecoverySus;ResistanceSus;RobustnessSus]

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Trad
load(string(fichier)+'\RecoveryTrad'+string(cas1),'RecoveryTrad');
RecoveryTrad1=RecoveryTrad
load(string(fichier)+'\RecoveryTrad'+string(cas2),'RecoveryTrad');
RecoveryTrad2=RecoveryTrad
RecoveryTrad=[RecoveryTrad1;RecoveryTrad2]
RecoveryTrad=mean(RecoveryTrad,'r') 

load(string(fichier)+'\RobustnessTrad'+string(cas1),'RobustnessTrad');
RobustnessTrad1=RobustnessTrad
load(string(fichier)+'\RobustnessTrad'+string(cas2),'RobustnessTrad');
RobustnessTrad2=RobustnessTrad
RobustnessTrad=[RobustnessTrad1;RobustnessTrad2]
RobustnessTrad=mean(RobustnessTrad,'r') 

load(string(fichier)+'\ResistanceTrad'+string(cas1),'ResistanceTrad');
ResistanceTrad1=ResistanceTrad
load(string(fichier)+'\ResistanceTrad'+string(cas2),'ResistanceTrad');
ResistanceTrad2=ResistanceTrad
ResistanceTrad=[ResistanceTrad1;ResistanceTrad2]
ResistanceTrad=mean(ResistanceTrad,'r') 
ResilienceTrad=[RecoveryTrad;ResistanceTrad;RobustnessTrad]

DiffResOil=[]
DiffResOil=(ResilienceTrad./ResilienceSus)-1

save(string(fichier)+'\DiffResOil','DiffResOil');
end

fichier='ResilienceMSY'
load(string(fichier)+'\DiffResOil','DiffResOil');
DiffResOilMSY=DiffResOil
fichier='ResilienceBAU'
load(string(fichier)+'\DiffResOil','DiffResOil');
DiffResOilBAU=DiffResOil
fichier='ResilienceMEY2'
load(string(fichier)+'\DiffResOil','DiffResOil');
DiffResOilMEY=DiffResOil
fichier='ResilienceClosure'
load(string(fichier)+'\DiffResOil','DiffResOil');
DiffResOilCLos=DiffResOil

DiffResilienceOil=[DiffResOilBAU(:,1:4)';DiffResOilCLos(:,1:4)';DiffResOilMEY(:,1:4)';DiffResOilMSY(:,1:4)']

chdir('');
csvWrite(DiffResilienceOil,'DiffResilienceOil.csv');












//////////////////RESILIENCE OIL IMPACT and CLIMATE IMPACT//////////////////
DiffResOil=[]
///BAU
fichier='ResilienceMEY2'
for fichier=list('ResilienceMSY','ResilienceBAU','ResilienceMEY2','ResilienceClosure')
cas1="26"
cas2="85"
////////////////////////////////////////////////////////////////////////////////////////
//SUS
load(string(fichier)+'\RecoverySus'+string(cas1),'RecoverySus');
RecoverySus=RecoverySus
load(string(fichier)+'\RobustnessSus'+string(cas1),'RobustnessSus');
RobustnessSus=RobustnessSus
load(string(fichier)+'\ResistanceSus'+string(cas1),'ResistanceSus');
ResistanceSus=ResistanceSus
ResilienceSus=[RecoverySus;ResistanceSus;RobustnessSus]

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Trad
load(string(fichier)+'\RecoveryTrad'+string(cas2),'RecoveryTrad');
RecoveryTrad=RecoveryTrad
load(string(fichier)+'\RobustnessTrad'+string(cas2),'RobustnessTrad');
RobustnessTrad=RobustnessTrad
load(string(fichier)+'\ResistanceTrad'+string(cas2),'ResistanceTrad');
ResistanceTrad=ResistanceTrad
ResilienceTrad=[RecoveryTrad;ResistanceTrad;RobustnessTrad]

DiffResOil=[]
DiffResOilClimate=(ResilienceTrad./ResilienceSus)-1

save(string(fichier)+'\DiffResOilClimate','DiffResOilClimate');
end

fichier='ResilienceMSY'
load(string(fichier)+'\DiffResOilClimate','DiffResOilClimate');
DiffResOilMSYClimate=DiffResOilClimate
fichier='ResilienceBAU'
load(string(fichier)+'\DiffResOilClimate','DiffResOilClimate');
DiffResOilBAUClimate=DiffResOilClimate
fichier='ResilienceMEY2'
load(string(fichier)+'\DiffResOilClimate','DiffResOilClimate');
DiffResOilMEYClimate=DiffResOilClimate
fichier='ResilienceClosure'
load(string(fichier)+'\DiffResOilClimate','DiffResOilClimate');
DiffResOilCLosClimate=DiffResOilClimate
DiffResilienceOilClimate=[DiffResOilBAUClimate(:,1:4)';DiffResOilCLosClimate(:,1:4)';DiffResOilMEYClimate(:,1:4)';DiffResOilMSYClimate(:,1:4)']

chdir('');
csvWrite(DiffResilienceOilClimate,'DiffResilienceOilClimate.csv');
