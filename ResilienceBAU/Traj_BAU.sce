chdir('C:\Users\matve\Desktop\Code These\ResilienceBAU\');
exec('donnees.sce');
exec('fctdyn_eco.sce');
exec('fctdyn.sce');
//Business as usual data
sheets=readxls('donnees3.xls');
data_eff=sheets(4);
/////////////////
//EFFORT
/////////////////
cas="26"
// Historical effort data
historical_effort_CC_bu=data_eff(3:T_proj+2,12);
historical_effort_CCA_bu=data_eff(3:T_proj+2,13);
historical_effort_T_bu=data_eff(3:T_proj+2,15);
historical_effort_bu=[historical_effort_CC_bu,historical_effort_CCA_bu,historical_effort_T_bu];
//Revenue and costs
exec('fctdyn_eco.sce');
////////////////
//Number of boats
///////////////
function[nb_boats]=nb_boats_min(nb_jour_peche_per_boats_per_trim,effort,t1)
    for t=t1:T_proj
        for f=1:N_fleet
            nb_boats(t,f)=effort(t,f)./nb_jour_peche_per_boats_per_trim(1,f)
        end
    end
endfunction
[nb_boats_BAU]=nb_boats_min(nb_j_peche_per_boats_per_trim,historical_effort_bu,1);
nb_boats_Post_BAU=nb_boats_BAU


T_s=208
T_proj=T_s+Horizont

function [IndGen,IndPro,IndFoodsect,IndBlim,Pro,Catcht,CCt,CCAt,Tt,Xt,IndSP,IndBio,SP,Blim,Foodssect,nb_boats_Post_BAU_t,IndNPV,CompteFi,historical_effort_bu,CompteFi]=dynamique_MAT_2(nb_boats_Post_BAU,gam,aij,B_simul,Y,PopGuyTr)
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
    Xt=[];
    CCt=[];
    CCAt=[];
    Tt=[];
    Catcht=[];
    Catch=[]
    IndGen=[];
    IndBio_=[]
    Pro=[]
    Bio=B_simul(1,:);
    //Bio=B_simul(Horizont+1,:); Biomasse en 2006
    Foodssect=[];
    PopGuy=PopGuyTr(1:T_proj,:);
//Beginning period 2006-2018
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
    for t=1:Horizont;
//TEMPERATURE
    for i=1:NN_calib;
        gamm(t,i)=[gam(t+int(tho(i)),i)];
    end;
    gammaa=[gamm(t,:),1] ;
//Biomass
   Xt=[Xt;Bio(t,:)];
//interaction between Biomass and trophic interaction
    predation=tauxpredation(Bio(t,:),aij,gammaa);
    predation1=tauxpredation1(Bio(t,:),aij);
    trophic=gi'.*sum(predation,'c')'-sum(predation1,'r');
//Load boat number
///////////////////////////////////////////////////////////////
load('C:\Users\matve\Desktop\Code These\ResilienceMEY2\nb_boats_HorizonT','nb_boats');
///////////////////////////////////////////////////////////////
    nb_boats_Post_BAU_t(t,1:3)=round(nb_boats(t,1:3));
            for f=1:N_fleet
                historical_effort_bu(t,f)=round(nb_boats_Post_BAU_t(t,f)).*nb_j_peche_per_boats_per_trim(1,f);
            end
///////////////////////////////////////////////////////////////
//EFFORT
    historical_effort_CCt(t)=historical_effort_bu(t,1);
    historical_effort_CCAt(t)=historical_effort_bu(t,2);
    historical_effort_Tt(t)=historical_effort_bu(t,3);
///////////////////////////////////////////////////////////////
//CAPTURE=EFFORT * ESPECE*CAPTURABILITE*BIOMASSE PAR FLOTTE
    Catch_CC(t,:)=(((historical_effort_CCt(t)) *ones(N_species,1)').*(q_CC)').*Xt(t,:);
    Catch_CCA(t,:)=(((historical_effort_CCAt(t)).*ones(N_species,1)').*(q_CCA)').*Xt(t,:);
    Catch_T(t,:)=(((historical_effort_Tt(t)).*ones(N_species,1)').*(q_T)').*Xt(t,:);
    Catch_(t,:)=Catch_CC(t,:)+Catch_CCA(t,:)+Catch_T(t,:)
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
//CAPTURES PONDERES PAR FLOTTE
    CC_pond(t,:)=Catch_CC(t,:)./Catch_(t,:);
    CCA_pond(t,:)=Catch_CCA(t,:)./Catch_(t,:);
    T_pond(t,:)=Catch_T(t,:)./Catch_(t,:);
// CAPTURE PAR ESPECE
    for i=1:NN_calib
//CAPTURE DEPASSANT LA BIOMASSE
        if Catch_(t,i) > (Bio (t,i)-M'(1,i).*Bio(t,i)+trophic(1,i))  then
            Catch_CC(t,i)=CC_pond(t,i)*(Bio (1,i)-M'(1,i).*Bio(t,i)+trophic(1,i))
            Catch_CCA(t,i)=CCA_pond(t,i)*(Bio (t,i)-M'(1,i).*Bio(t,i)+trophic(1,i))
            Catch_T(t,i)=T_pond(t,i)*(Bio (t,i)-M'(1,i).*Bio(t,i)+trophic(1,i))
            disp("a")
        end
        CA_T(t,i)=PrixTrim(t,i)*Catch_T(t,i);
        CA_CC(t,i)=PrixTrim(t,i)*Catch_CC(t,i);
        CA_CCA(t,i)=PrixTrim(t,i)*Catch_CCA(t,i);
    end
//PROFIT CC
    CA_f_CC(t)= sum (CA_CC(t),'c')+ProOtSP(t,1);
    C_var_CC(t)=CoutVarTrim(t,1).*nb_boats_Post_BAU_t(t,1);
    C_fix_proj_CC(t)=(fix_cost_trim(1,1).*nb_boats_Post_BAU_t(t,1))./4;
    Profit_CC(t)=(1-bet(1,1))*(CA_f_CC(t)-C_var_CC(t)-C_fix_proj_CC(t));
//PROFIT CCA
    CA_f_CCA(t)= sum (CA_CCA(t),'c')+ProOtSP(t,2);
    C_var_CCA(t)=CoutVarTrim(t,2).*nb_boats_Post_BAU_t(t,2);
    C_fix_proj_CCA(t)=(fix_cost_trim(1,2).*nb_boats_Post_BAU_t(t,2))./4;
    Profit_CCA(t)=(1-bet(1,2))*(CA_f_CCA(t)-C_var_CCA(t)-C_fix_proj_CCA(t));
//PROFIT T
    CA_f_T(t)= sum (CA_T(t),'c')+ProOtSP(t,3);
    C_var_T(t)=CoutVarTrim(t,3).*nb_boats_Post_BAU_t(t,3);
    C_fix_proj_T(t)=(fix_cost_trim(1,3).*nb_boats_Post_BAU_t(t,3))./4;
    Profit_T(t)=(1-bet(1,3))*(CA_f_T(t)-C_var_T(t)-C_fix_proj_T(t));
///////////////////////////////////////////////////////////////////////////////////////
        if Catch_T(t,:)==0 then
            Profit_T(t)=0
            nb_boats_Post_BAU_t(t,3)=0
            C_var_T(t)=0;
            C_fix_proj_T(t)=0;
        end
        if Catch_CCA(t,:)==0 then
            Profit_CCA(t)=0
            nb_boats_Post_BAU_t(t,2)=0
            C_var_CCA(t)=0;
            C_fix_proj_CCA(t)=0;
        end
        if Catch_CC(t,:)==0 then
            Profit_CC(t)=0
            nb_boats_Post_BAU_t(t,1)=0
            C_var_CC(t)=0;
            C_fix_proj_CC(t)=0;
        end
///////////////////////////////////////////////////////////////////////////////////////
//CAPTURE ET BIOMASSE
    for i=1:NN_calib
        Catch(t,i)=Catch_CC(t,i)+Catch_CCA(t,i)+Catch_T(t,i);
        Bio(t+1,i)=(Bio(t,i)-M'(1,i).*Bio(t,i)-Catch(t,i)+trophic(1,i));
    end
//BIOMASSE RESSOURCE PLANCTONIQUE
    Bio(t+1,N_species)=(Bio(t,N_species)+I(t)-aij(1,N_species).*Bio(t,N_species).*Bio(t,1)-aij(2,N_species).*Bio(t,N_species).*Bio(t,2)-aij(3,N_species).*Bio(t,N_species).*Bio(t,3));

//PAS DE BIOMASSE NULLE
    Bio(t+1,:)=max(zeros(Bio(t,:)),Bio(t+1,:));
    Catch_msy=sum(Catch_CC(t,:)+Catch_CCA(t,:)+Catch_T(t,:));
    CCt=[CCt;Catch_CC(t,:)];
    CCAt=[CCAt;Catch_CCA(t,:)];
    Tt=[Tt;Catch_T(t,:)];
    Xt
     /////////////////////////////////////////
     //Profit
     /////////////////////////////////////////
     Pro(t,1)=Profit_CC(t);
     Pro(t,2)=Profit_CCA(t);
     Pro(t,3)=Profit_T(t);
     /////////////////////////////////////////
     //NPV
     /////////////////////////////////////////
     IndNPV(t)=Pro(t)./ActuTrim(t);
     IndPro(t)=bool2s(IndNPV(t)>=0);
     end
////////////////////////////////////////////////////////////////////////////////////////////////////
//PERIODE DES 50 ANNEES 2018-2068
    //PopGuy=PopGuyTr(Horizont+1:T_proj,:);
//////////////////pas de temps de 5ans
    for n=0:floor(T_s/Y)-1;
////50 PREMIERES ANNEES
        for t=Horizont+1+n*Y:Horizont+(n+1)*Y;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            for i=1:NN_calib;
                gamm(t,i)=[gam(t+int(tho(i)),i)];
            end;
            gammaa=[gamm(t,:),1] ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//matrice biomasse
            Xt=[Xt;Bio(t,:)];
//interaction BIOMASSE et MILIEU
            predation=tauxpredation(Bio(t,:),aij,gammaa);
            predation1=tauxpredation1(Bio(t,:),aij);
            trophic=gi'.*sum(predation,'c')'-sum(predation1,'r');
////////////////////////////////////////////////////////////////
//NOMBRE BATEAUX
////////////////////////////////////////////////////////////////

            for f=1:N_fleet
                historical_effort_bu(t+1,f)=round(nb_boats_Post_BAU(t,f)).*nb_j_peche_per_boats_per_trim(1,f);
            end
            historical_effort_CC(n+1)=historical_effort_bu(n+1,1);
            historical_effort_CCA(n+1)=historical_effort_bu(n+1,2);
            historical_effort_T(n+1)=historical_effort_bu(n+1,3);
////////////////////////////////////////////////////////////////
            nb_boats_Post_BAU_t(t,1:3)=round(nb_boats_Post_BAU(t,1:3))
////////////////////////////////////////////////////////////////
            historical_effort_CCt(t)=historical_effort_CC(n+1);
            historical_effort_CCAt(t)=historical_effort_CCA(n+1);
            historical_effort_Tt(t)=historical_effort_bu(n+1,3);
//CAPTURE=EFFORT * ESPECE*CAPTURABILITE*BIOMASSE
            Catch_CC(t,:)=(((historical_effort_CCt(t)) *ones(N_species,1)').*(q_CC)').*Xt(t,:);
            Catch_CCA(t,:)=(((historical_effort_CCAt(t)).*ones(N_species,1)').*(q_CCA)').*Xt(t,:);
            Catch_T(t,:)=(((historical_effort_Tt(t)).*ones(N_species,1)').*(q_T)').*Xt(t,:);
            Catch_(t,:)=Catch_CC(t,:)+Catch_CCA(t,:)+Catch_T(t,:)
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
//CAPTURES PONDERES PAR FLOTTE
            CC_pond(t,:)=Catch_CC(t,:)./Catch_(t,:);
            CCA_pond(t,:)=Catch_CCA(t,:)./Catch_(t,:);
            T_pond(t,:)=Catch_T(t,:)./Catch_(t,:);
// CAPTURE PAR ESPECE
            for i=1:NN_calib
//CAPTURE DEPASSANT LA BIOMASSE
                if Catch_(t,i) > (Bio (t,i)-M'(1,i).*Bio(t,i)+trophic(1,i))  then
                    Catch_CC(t,i)=CC_pond(t,i)*(Bio (1,i)-M'(1,i).*Bio(t,i)+trophic(1,i))
                    Catch_CCA(t,i)=CCA_pond(t,i)*(Bio (t,i)-M'(1,i).*Bio(t,i)+trophic(1,i))
                    Catch_T(t,i)=T_pond(t,i)*(Bio (t,i)-M'(1,i).*Bio(t,i)+trophic(1,i))
                    disp("a")
                end
            CA_T(t,i)=PrixTrim(t,i)*Catch_T(t,i);
            CA_CC(t,i)=PrixTrim(t,i)*Catch_CC(t,i);
            CA_CCA(t,i)=PrixTrim(t,i)*Catch_CCA(t,i);
        end
//PROFIT CC
    CA_f_CC(t)= sum (CA_CC(t),'c')+ProOtSP(t,1);
    C_var_CC(t)=CoutVarTrim(t,1).*nb_boats_Post_BAU_t(t,1);
    C_fix_proj_CC(t)=(fix_cost_trim(1,1).*nb_boats_Post_BAU_t(t,1))./4;
    Profit_CC(t)=(1-bet(1,1))*(CA_f_CC(t)-C_var_CC(t)-C_fix_proj_CC(t));
//PROFIT CCA
    CA_f_CCA(t)= sum (CA_CCA(t),'c')+ProOtSP(t,2);
    C_var_CCA(t)=CoutVarTrim(t,2).*nb_boats_Post_BAU_t(t,2);
    C_fix_proj_CCA(t)=(fix_cost_trim(1,2).*nb_boats_Post_BAU_t(t,2))./4;
    Profit_CCA(t)=(1-bet(1,2))*(CA_f_CCA(t)-C_var_CCA(t)-C_fix_proj_CCA(t));
//PROFIT T
    CA_f_T(t)= sum (CA_T(t),'c')+ProOtSP(t,3);
    C_var_T(t)=CoutVarTrim(t,3).*nb_boats_Post_BAU_t(t,3);
    C_fix_proj_T(t)=(fix_cost_trim(1,3).*nb_boats_Post_BAU_t(t,3))./4;
    Profit_T(t)=(1-bet(1,3))*(CA_f_T(t)-C_var_T(t)-C_fix_proj_T(t));
///////////////////////////////////////////////////////////////////////////////////////
        if Catch_T(t,:)==0 then
            Profit_T(t)=0
            nb_boats_Post_BAU_t(t,3)=0
            C_var_T(t)=0;
            C_fix_proj_T(t)=0;
        end
        if Catch_CCA(t,:)==0 then
            Profit_CCA(t)=0
            nb_boats_Post_BAU_t(t,2)=0
            C_var_CCA(t)=0;
            C_fix_proj_CCA(t)=0;
        end
        if Catch_CC(t,:)==0 then
            Profit_CC(t)=0
            nb_boats_Post_BAU_t(t,1)=0
            C_var_CC(t)=0;
            C_fix_proj_CC(t)=0;
        end
///////////////////////////////////////////////////////////////////////////////////////
//CAPTURE ET BIOMASSE
    for i=1:NN_calib
        Catch(t,i)=Catch_CC(t,i)+Catch_CCA(t,i)+Catch_T(t,i);
        Bio(t+1,i)=(Bio(t,i)-M'(1,i).*Bio(t,i)-Catch(t,i)+trophic(1,i));
    end
//BIOMASSE RESSOURCE PLANCTONIQUE
        Bio(t+1,N_species)=(Bio(t,N_species)+I(t)-aij(1,N_species).*Bio(t,N_species).*Bio(t,1)-aij(2,N_species).*Bio(t,N_species).*Bio(t,2)-aij(3,N_species).*Bio(t,N_species).*Bio(t,3));
//PAS DE BIOMASSE NULLE
        Bio(t+1,:)=max(zeros(Bio(t,:)),Bio(t+1,:));
//RESULTAT
        Catch_msy=sum(Catch_CC(t,:)+Catch_CCA(t,:)+Catch_T(t,:));
        CCt=[CCt;Catch_CC(t,:)];
        CCAt=[CCAt;Catch_CCA(t,:)];
        Tt=[Tt;Catch_T(t,:)];
     /////////////////////////////////////////
     Pro(t,1)=Profit_CC(t);
     Pro(t,2)=Profit_CCA(t);
     Pro(t,3)=Profit_T(t);
     /////////////////////////////////////////
     //NPV
     /////////////////////////////////////////
     IndNPV(t)=Pro(t)./ActuTrim(t);
     IndPro(t)=bool2s(IndNPV(t)>=0);
    end
end
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//2 DERNIERES ANNEES 2068-2070
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
for t=Horizont+floor(T_s/Y)*Y+1:T_proj;
    //TEMPERATURE
    for i=1:NN_calib;
        gamm(t,i)=[gam(t+int(tho(i)),i)];
    end;
    gammaa=[gamm(t,:),1] ;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//BIOMASSE avec en 1ere ligne la Biomasse trouvé avec la calib
    Xt=[Xt;Bio(t,:)];
    //interaction BIOMASSE et MILIEU
    predation=tauxpredation(Bio(t,:),aij,gammaa);
    predation1=tauxpredation1(Bio(t,:),aij);
    trophic=gi'.*sum(predation,'c')'-sum(predation1,'r');
///////////////////////////////////////////////////////////////
//NOMBRE BATEAUX
////////////////////////////////////////////////////////////////
        for f=1:N_fleet
            historical_effort_bu(floor(T_s/Y)+1,f)=round(nb_boats_Post_BAU(floor(T_s/Y)+1,f)).*nb_j_peche_per_boats_per_trim(1,f);
        end
//EFFORT
////////////////////////////////////////////////////////////////
        historical_effort_CC(floor(T_s/Y)+1)=historical_effort_bu(floor(T_s/Y)+1,1);
        historical_effort_CCA(floor(T_s/Y)+1)=historical_effort_bu(floor(T_s/Y)+1,2);
        historical_effort_T(floor(T_s/Y)+1)=historical_effort_bu(floor(T_s/Y)+1,3);
////////////////////////////////////////////////////////////////
        nb_boats_Post_BAU_t(t,1:3)=round(nb_boats_Post_BAU(t,1:3))
///////////////////////////////////////////////////////////////
        historical_effort_CCt(t)=historical_effort_CC(floor(T_s/Y));
        historical_effort_CCAt(t)=historical_effort_CCA(floor(T_s/Y));
        historical_effort_Tt(t)=historical_effort_T(floor(T_s/Y));
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
        //CAPTURES PAR FLOTTE
        Catch_CC(t,:)=(((historical_effort_CCt(t)) *ones(N_species,1)').*(q_CC)').*Xt(t,:);
        Catch_CCA(t,:)=(((historical_effort_CCAt(t)).*ones(N_species,1)').*(q_CCA)').*Xt(t,:);
        Catch_T(t,:)=(((historical_effort_Tt(t)).*ones(N_species,1)').*(q_T)').*Xt(t,:);
        Catch_(t,:)=Catch_CC(t,:)+Catch_CCA(t,:)+Catch_T(t,:)
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
//CAPTURES PONDERES PAR FLOTTE
        CC_pond(t,:)=Catch_CC(t,:)./Catch_(t,:);
        CCA_pond(t,:)=Catch_CCA(t,:)./Catch_(t,:);
        T_pond(t,:)=Catch_T(t,:)./Catch_(t,:);
// CAPTURE PAR ESPECE
        for i=1:NN_calib
//CAPTURE DEPASSANT LA BIOMASSE
            if Catch_(t,i) > (Bio (t,i)-M'(1,i).*Bio(t,i)+trophic(1,i))  then
               Catch_CC(t,i)=CC_pond(t,i)*(Bio (1,i)-M'(1,i).*Bio(t,i)+trophic(1,i))
               Catch_CCA(t,i)=CCA_pond(t,i)*(Bio (t,i)-M'(1,i).*Bio(t,i)+trophic(1,i))
               Catch_T(t,i)=T_pond(t,i)*(Bio (t,i)-M'(1,i).*Bio(t,i)+trophic(1,i))
               disp("a")
            end
            CA_T(t,i)=PrixTrim(t,i)*Catch_T(t,i);
            CA_CC(t,i)=PrixTrim(t,i)*Catch_CC(t,i);
            CA_CCA(t,i)=PrixTrim(t,i)*Catch_CCA(t,i);
        end
//PROFIT CC

    CA_f_CC(t)= sum (CA_CC(t),'c')+ProOtSP(t,1);
    C_var_CC(t)=CoutVarTrim(t,1).*nb_boats_Post_BAU_t(t,1);
    C_fix_proj_CC(t)=(fix_cost_trim(1,1).*nb_boats_Post_BAU_t(t,1))./4;
    Profit_CC(t)=(1-bet(1,1))*(CA_f_CC(t)-C_var_CC(t)-C_fix_proj_CC(t));
//PROFIT CCA
    CA_f_CCA(t)= sum (CA_CCA(t),'c')+ProOtSP(t,2);
    C_var_CCA(t)=CoutVarTrim(t,2).*nb_boats_Post_BAU_t(t,2);
    C_fix_proj_CCA(t)=(fix_cost_trim(1,2).*nb_boats_Post_BAU_t(t,2))./4;
    Profit_CCA(t)=(1-bet(1,2))*(CA_f_CCA(t)-C_var_CCA(t)-C_fix_proj_CCA(t));
//PROFIT T
    CA_f_T(t)= sum (CA_T(t),'c')+ProOtSP(t,3);
    C_var_T(t)=CoutVarTrim(t,3).*nb_boats_Post_BAU_t(t,3);
    C_fix_proj_T(t)=(fix_cost_trim(1,3).*nb_boats_Post_BAU_t(t,3))./4;
    Profit_T(t)=(1-bet(1,3))*(CA_f_T(t)-C_var_T(t)-C_fix_proj_T(t));
///////////////////////////////////////////////////////////////////////////////////////
        if Catch_T(t,:)==0 then
            Profit_T(t)=0
            nb_boats_Post_BAU_t(t,3)=0
            C_var_T(t)=0;
            C_fix_proj_T(t)=0;
        end
        if Catch_CCA(t,:)==0 then
            Profit_CCA(t)=0
            nb_boats_Post_BAU_t(t,2)=0
            C_var_CCA(t)=0;
            C_fix_proj_CCA(t)=0;
        end
        if Catch_CC(t,:)==0 then
            Profit_CC(t)=0
            nb_boats_Post_BAU_t(t,1)=0
            C_var_CC(t)=0;
            C_fix_proj_CC(t)=0;
        end
///////////////////////////////////////////////////////////////////////////////////////
//CAPTURE ET BIOMASSE
        for i=1:NN_calib
            Catch(t,i)=Catch_CC(t,i)+Catch_CCA(t,i)+Catch_T(t,i);
            Bio(t+1,i)=(Bio(t,i)-M'(1,i).*Bio(t,i)-Catch(t,i)+trophic(1,i));
        end
//BIOMASSE RESSOURCE PLANCTONIQUE
        Bio(t+1,N_species)=(Bio(t,N_species)+I(t)-aij(1,N_species).*Bio(t,N_species).*Bio(t,1)-aij(2,N_species).*Bio(t,N_species).*Bio(t,2)-aij(3,N_species).*Bio(t,N_species).*Bio(t,3));
//PAS DE BIOMASSE NULLE
        Bio(t+1,:)=max(zeros(Bio(t,:)),Bio(t+1,:));
//RESULTAT
        Catch_msy=sum(Catch_CC(t,:)+Catch_CCA(t,:)+Catch_T(t,:));
        CCt=[CCt;Catch_CC(t,:)];
        CCAt=[CCAt;Catch_CCA(t,:)];
        Tt=[Tt;Catch_T(t,:)];
        //PROFIT
/////////////////////////////////////////
     Pro(t,1)=Profit_CC(t);
     Pro(t,2)=Profit_CCA(t);
     Pro(t,3)=Profit_T(t);
     /////////////////////////////////////////
     //NPV
     /////////////////////////////////////////
     IndNPV(t)=Pro(t)./ActuTrim(t);
     IndPro(t)=bool2s(IndNPV(t)>=0);
end
/////////////////////////////////////////////////////////
//Contrainte securite alimentaire
/////////////////////////////////////////////////////////
    FoodsecLim=1.6//A CHANGER
    IndFoodsect=bool2s(Foodssect>FoodsecLim);
/////////////////////////////////////////////////////////
//Contrainte biologique
/////////////////////////////////////////////////////////
//Biomasse limite
Blim=[]
Blimt0=[]
Blimt0=[0,0,0]
for t=1:T_proj
        for i=1:N_species-1
            Blim(t,i)=Xt(t,i)-Blimt0(1,i)
        end
end
    IndBlim=bool2s(Blim>=0);
//diversite specifique
for t=1:T_proj
    for i=1:N_species
        SPt(t,i)=bool2s(Xt(t,i)>0);
    end
end
SP=sum(SPt,"c");
IndSP=bool2s(SP==4);
//////////////////////////////////////////////////
//Indice biologique
IndBio_=[IndBio_,IndSP];
IndBio_=[IndBio_,IndBlim];
IndBio=bool2s(sum(IndBio_,"c")==2);
//////////////////////////////////////////////////
/////////////////////////////////////////
//Pro
/////////////////////////////////////////
Pro(t,1)=Profit_CC(t);
Pro(t,2)=Profit_CCA(t);
Pro(t,3)=Profit_T(t);
CompteFi=[]
CompteFi=[CompteFi,CA_f_CC,C_var_CC,C_fix_proj_CC,CA_f_CCA,C_var_CCA,C_fix_proj_CCA,CA_f_T,C_var_T,C_fix_proj_T]
     Catcht=sum(CCt,"c")+sum(CCAt,"c")+sum(Tt,"c");
    Foodssect=(Catcht(:,1).*1000)./PopGuy(:);
/////////////////////////////////////////
//NPV
/////////////////////////////////////////
IndNPV(t)=Pro(t)./ActuTrim(t);
IndPro(t)=bool2s(IndNPV(t)>=0);
IndNPV=sum(Pro,"c")./ActuTrim(1:256,:);
IndPro=bool2s(IndNPV>=0);
IndGen=[IndGen,IndBio];
IndGen=[IndGen,IndFoodsect];
IndGen=[IndGen,IndPro];
//IndViab=sum(IndPro);//indgen est le score de viabilite
IndViab=bool2s(sum(IndGen,"c")==3);
IndGen=[IndGen,IndViab];
endfunction
nb_boats_Post_BAU_t=nb_boats_BAU;
aij=data_param(2:2+N_species-1,2:2+N_species-1);
if cas=="26" then
    gam=gam_26;
    load('C:\Users\matve\Desktop\Code These\ResilienceMSY\Bsimul26','B_simul_26');
    B_simul=B_simul_26;
end
if cas=="85" then
    gam=gam_85;
    load('C:\Users\matve\Desktop\Code These\ResilienceMSY\Bsimul85','B_simul_85');
    B_simul=B_simul_85;
end
Y=20;
PopGuyTr=PopGuyTrim;

///////////////////////////////////////////////////
//Traj Del sans choc
///////////////////////////////////////////////////

load('CoutVarDel','CoutVarTrim');
CoutVarTrim=CoutVarTrimDel
[IndGen,IndPro,IndFoodsect,IndBlim,Pro,Catcht,CCt,CCAt,Tt,Xt,IndSP,IndBio,SP,Blim,Foodssect,nb_boats_Post_BAU_t,IndNPV,CompteFi,historical_effort_bu,CompteFi]=dynamique_MAT_2(nb_boats_Post_BAU,gam,aij,B_simul,Y,PopGuyTr)
Blim=Blim(1:256,:)
Pro=Pro(1:256,:)
Foodssect=Foodssect(1:256,:)
nb_boats_Post_BAU_t=nb_boats_Post_BAU_t(1:256,:)
save('Blim_Del'+string(cas),'Blim');
save('Pro_Del'+string(cas),'Pro')
save('Foodssect_Del'+string(cas),'Foodssect')
save('Bateau_Del'+string(cas),'nb_boats_Post_BAU_t')
///////////////////////////////////////////////////
///////////////////////////////////////////////////
//Traj Sus sans choc
///////////////////////////////////////////////////
load('CoutVarSus','CoutVarTrim');
[IndGen,IndPro,IndFoodsect,IndBlim,Pro,Catcht,CCt,CCAt,Tt,Xt,IndSP,IndBio,SP,Blim,Foodssect,nb_boats_Post_BAU_t,IndNPV,CompteFi,historical_effort_bu,CompteFi]=dynamique_MAT_2(nb_boats_Post_BAU,gam,aij,B_simul,Y,PopGuyTr)
Blim=Blim(1:256,:)
Pro=Pro(1:256,:)
Foodssect=Foodssect(1:256,:)
nb_boats_Post_BAU_t=nb_boats_Post_BAU_t(1:256,:)
save('Blim_Sus'+string(cas),'Blim');
save('Pro_Sus'+string(cas),'Pro')
save('Foodssect_Sus'+string(cas),'Foodssect')
save('Bateau_Sus'+string(cas),'nb_boats_Post_BAU_t')
///////////////////////////////////////////////////
///////////////////////////////////////////////////
//Traj Trad
///////////////////////////////////////////////////
load('CoutVarTrad','CoutVarTrim');
[IndGen,IndPro,IndFoodsect,IndBlim,Pro,Catcht,CCt,CCAt,Tt,Xt,IndSP,IndBio,SP,Blim,Foodssect,nb_boats_Post_BAU_t,IndNPV,CompteFi,historical_effort_bu,CompteFi]=dynamique_MAT_2(nb_boats_Post_BAU,gam,aij,B_simul,Y,PopGuyTr)
Blim=Blim(1:256,:)
Pro=Pro(1:256,:)
Foodssect=Foodssect(1:256,:)
nb_boats_Post_BAU_t=nb_boats_Post_BAU_t(1:256,:)

save('Blim_sans_choc'+string(cas),'Blim');
save('Pro_sans_choc'+string(cas),'Pro')
save('Foodssect_sans_choc'+string(cas),'Foodssect')
save('nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
///////////////////////////////////////////////////

