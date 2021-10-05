chdir('C:\Users\matve\Desktop\Code These\');
sheets=readxls('ResilienceBAU\donnees3.xls');
data=sheets(1);
data_cli=sheets(3);
data_param=sheets(2);
data_eff=sheets(4);
data_eco=sheets(5);
data_bio=sheets(6);
data_demo=sheets(7);
data_trophi=sheets(8);
data_cost=sheets(9);
data_actu=sheets(10);
data_prix=sheets(11);
data_otsp=sheets(12);
Horizont=48;
N_species=4;
N_fleet=3;
NN_calib=N_species-1;
Hort=Horizont-1;

//T_proj=Horizont;

//Pour 2050
//T_proj=Horizont+128;

//Pour 2070
//T_s=208;
//T_proj= Horizont+T_s;

//Pour 2100
T_s=328;
T_proj=Horizont+T_s;


t_0=2006;
t_donnees_final=t_0+(T_proj)/4;
c=0;
species=["Acoupa Weakfish";"Green Weakfish";"Crucifix Catfish";"14 eme espece"];




///capture///////
historical_catch_CC_AR=data(4:Hort+4,4)./(1000*1000);
historical_catch_CCA_AR=data(4:Hort+4,5)./(1000*1000);
historical_catch_T_AR=data(4:Hort+4,7)./(1000*1000);

historical_catch_CC_AA=data(102:Hort+102,4)./(1000*1000);
historical_catch_CCA_AA=data(102:Hort+102,5)./(1000*1000);
historical_catch_T_AA=data(102:Hort+102,7)./(1000*1000);

historical_catch_CC_MB=data(53:Hort+53,4)./(1000*1000);
historical_catch_CCA_MB=data(53:Hort+53,5)./(1000*1000);
historical_catch_T_MB=data(53:Hort+53,7)./(1000*1000);
historical_catch_CC=[historical_catch_CC_AR,historical_catch_CC_AA,historical_catch_CC_MB];
historical_catch_CCA=[historical_catch_CCA_AR,historical_catch_CCA_AA,historical_catch_CCA_MB];
historical_catch_T=[historical_catch_T_AR,historical_catch_T_AA,historical_catch_T_MB];


catch_hist_sum=historical_catch_CCA+historical_catch_CC+historical_catch_T;

sum_capture_CC_h=[sum(historical_catch_CC,'c')];
sum_capture_CCA_h=[sum(historical_catch_CCA,'c')];
sum_capture_T_h=[sum(historical_catch_T,'c')];
sum_capture_h=[sum_capture_CC_h,sum_capture_CCA_h,sum_capture_T_h];
sum_capture_agg_h=sum(sum_capture_h,'c');


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Pour RCP 8.5
//8.5 moy
gam_AR_85=data_cli(4:395,3);
gam_AA_85=data_cli(4:395,4);
gam_MB_85=data_cli(4:395,5);
//gam_AR_85=data_cli(16:T_proj+16,3);
//gam_AA_85=data_cli(4:T_proj+4,4);
//gam_MB_85=data_cli(20:T_proj+20,5);


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Pour RCP 2.6

//2.6 moy
gam_AR_26=data_cli(4:395,7);
gam_AA_26=data_cli(4:395,8);
gam_MB_26=data_cli(4:395,9);
gam_85=[gam_AR_85,gam_AA_85,gam_MB_85];
gam_26=[gam_AR_26,gam_AA_26,gam_MB_26];

//Pour temperature standard
gam_AR_stand=data_cli(4:395,11);
gam_AA_stand=data_cli(4:395,12);
gam_MB_stand=data_cli(4:395,13);

gam_stand=[gam_AR_stand,gam_AA_stand,gam_MB_stand];

//PARAMETRE CALIB
I=data_param(2:T_proj+1,1);
aij=data_param(2:2+N_species-1,2:2+N_species-1);
q_CC=data_param(2:2+N_species-1,6);
q_CCA=data_param(2:2+N_species-1,7);
q_P=data_param(2:2+N_species-1,8);
q_T=data_param(2:2+N_species-1,9);
M=data_param(2:2+N_species-1,10);
gi=data_param(2:2+N_species-1,11);
Bio_1=data_param(7,2:2+N_species-1);
tho=data_param(9,2:2+N_species-2);

//ECONOMIE OLD
nb_boats=data_eco(4,6:8);
Var_cost=data_eco(5,6:8);
fix_cost=data_eco(6,6:8);
//On a une valeur de couts fixes par année, on trimestrialise
fix_cost_trim=fix_cost./4;
//PRIX OLD
pr_AW=data_eco(8,6:8);
pr_GW=data_eco(9,6:8);
pr_CrC=data_eco(10,6:8);
pr=[pr_AW;pr_GW;pr_CrC];
//pr: stock sur lignes et flot sur colonnes==> on inverse
P=pr';
//On recupère les prix par stock (sur des lignes)
p_CC=P(1,1:3);
p_CCA=P(2,1:3);
p_T=P(3,1:3);
nb_j_peche_per_boats_per_trim=data_eco(11,6:8);
//nb_j_peche_per_boats_per_trim=nb_j_peche_per_boats_per_trim.*3;
bet=[0,0.5,0.5];
r=0.03/4;
alpha_add=data_eco(12,6:8);
alpha_mul=data_eco(13,6:8);


//INDICATEURS BIOLOGIQUES
poids_moy=data_bio(2,2:4);
poids_moy_kt=poids_moy.*(10^-6);
T=data_bio(3,2:4);

//POPULATION GUYANE
PopGuy=round(data_demo(3:97,3));
PopGuyTrim=zeros(T_proj,1);
//ligne decrivant le nombre de ligne initial du fichier
for n=1:(T_proj/4);
//ligne decrivant le nombre de ligne souhaite du fichier
    for t=1+n*4-4:(n+1)*4-4;
      PopGuyTrim(t)=PopGuy(n);
      //PopGuyTrim(t)=PopGuy(n)
    end
end
for i=1:N_fleet
    for t=1:T_proj
//        AE(t,i)=rand();
    end
end
//save('C:\Users\matve\Desktop\Code These\ResilienceMEY\'+'AE','AE');

CoutVar=data_cost(2:95,2:7);
PrixPet=CoutVar(:,1);
CoutVarAnCC=(1403.84*PrixPet(:,1)+1946.51)
CoutVarAnCCA=(7372.68*PrixPet(:,1)+2933.77)
CoutVarAnT=(10978.63*PrixPet(:,1)+10416.4)
Coutss=[];
Coutss=[Coutss,CoutVarAnCC];
Coutss=[Coutss,CoutVarAnCCA];
Coutss=[Coutss,CoutVarAnT];

///////////////////////////////////////////////////////////////////////////////
PrixPetDel=CoutVar(:,2);
CoutVarAnCCDel=(1403.84*PrixPetDel(:,1)+1946.51)
CoutVarAnCCADel=(7372.68*PrixPetDel(:,1)+2933.77)
CoutVarAnTDel=(10978.63*PrixPetDel(:,1)+10416.4)
CoutDel=[];
CoutDel=[CoutDel,CoutVarAnCCDel];
CoutDel=[CoutDel,CoutVarAnCCADel];
CoutDel=[CoutDel,CoutVarAnTDel];

///////////////////////////////////////////////////////////////////////////////
PrixPetSus=CoutVar(:,3);
CoutVarAnCCSus=(1403.84*PrixPetSus(:,1)+1946.51)
CoutVarAnCCASus=(7372.68*PrixPetSus(:,1)+2933.77)
CoutVarAnTSus=(10978.63*PrixPetSus(:,1)+10416.4)
CoutSus=[];
CoutSus=[CoutSus,CoutVarAnCCSus];
CoutSus=[CoutSus,CoutVarAnCCASus];
CoutSus=[CoutSus,CoutVarAnTSus];

CoutVarAgg(:,1)=CoutVarAnCC;
CoutVarAgg(:,2)=CoutVarAnCCA;
CoutVarAgg(:,3)=CoutVarAnT;
for n=1:(T_proj/4);
//ligne decrivant le nombre de ligne souhaite du fichier
    for t=1+n*4-4:(n+1)*4-4;
        CoutVarTrim(t,1:3)=CoutVarAgg(n,1:3)./4;
        CoutVarTrimDel(t,1:3)=CoutDel(n,1:3)./4;
        CoutVarTrimSus(t,1:3)=CoutSus(n,1:3)./4;
        CoutVarTrimTrad(t,1:3)=Coutss(n,1:3)./4;
      // CoutVarTrim(t,1:3)=CoutVar(1,1:3)./4;
    end
end
CoutVarTrim=CoutVarTrimSus;
save('ResilienceBAU\CoutVarSus','CoutVarTrim');
save('ResilienceMEY2\CoutVarSus','CoutVarTrim');
save('ResilienceMSY\CoutVarSus','CoutVarTrim');
CoutVarTrim=CoutVarTrimTrad;
save('ResilienceBAU\CoutVarTrad','CoutVarTrim');
save('ResilienceMEY2\CoutVarTrad','CoutVarTrim');
save('ResilienceMSY\CoutVarTrad','CoutVarTrim');
CoutVarTrim=CoutVarTrimDel;
save('ResilienceBAU\CoutVarDel','CoutVarTrim');
save('ResilienceMEY2\CoutVarDel','CoutVarTrim');
save('ResilienceMSY\CoutVarDel','CoutVarTrim');



//LIEN TROPHIQUE
Trophi=data_trophi(2:5,2);

//DATE CHOC
DateChoc=15


//ACTUALISATION
Actu=data_actu(2:96,5);
for n=1:(T_proj/4);
//ligne decrivant le nombre de ligne souhaite du fichier
    for t=1+n*4-4:(n+1)*4-4;
      ActuTrim(t,1)=Actu(n,1);
    end
end
//PRIX AVEC INFLATION
prix=data_prix(2:96,2:4);
//ligne decrivant le nombre de ligne souhaite du fichier 
//Possibilite de lever l'evolution du prix base sur l inflation CE

for n=1:(T_proj/4);
    for t=1+n*4-4:(n+1)*4-4;
      PrixTrim(t,1:3)=prix(n,1:3)*1000;
    end
end

//AE
load('AE','AE'); 

Inflation=data_prix(2:96,5);
ProfOtSP=data_otsp(1:3,16)';
ProfOtSPinf=[ProfOtSP(1)*Inflation,ProfOtSP(2)*Inflation,ProfOtSP(3)*Inflation];
for n=1:(T_proj/4);
    for t=1+n*4-4:(n+1)*4-4;
      ProOtSP(t,1:3)=ProfOtSPinf(n,1:3)./4;
    end
end

