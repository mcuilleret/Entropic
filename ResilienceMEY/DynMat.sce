function [IndViab]=dynamique_MAT(nb_boats_Post_BAU,gam,aij,B_simul,Y,PopGuyTr)
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
    Foodssect=[];
    PopGuy=PopGuyTr(1:T_proj,:);
//VARIABLE SUR LES PREMIERES ANNEES 2006-2018
/////////////////////////////////////////////////////////////////////////////////
    for t=1:Horizont;
//TEMPERATURE
    for i=1:NN_calib;
        gamm(t,i)=[gam(t+int(tho(i)),i)];
    end;
    gammaa=[gamm(t,:),1] ;
//BIOMASSE avec en 1ere ligne la Biomasse trouvé avec la calib
    Xt=[Xt;Bio(t,:)];
//interaction BIOMASSE et MILIEU
    predation=tauxpredation(Bio(t,:),aij,gammaa);
    predation1=tauxpredation1(Bio(t,:),aij);
    trophic=gi'.*sum(predation,'c')'-sum(predation1,'r');
//NOMBRE BATEAUX
///////////////////////////////////////////////////////////////
load('nb_boats_HorizonT','nb_boats');
///////////////////////////////////////////////////////////////
    nb_boats_Post_BAU_t(t,1:3)=round(nb_boats(t,1:3));
    for f=1:N_fleet
        historical_effort_bu(t,f)=round(nb_boats(t,f)).*nb_j_peche_per_boats_per_trim(1,f);
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
        end
        CA_T(t,i)=PrixTrim(t,i)*Catch_T(t,i);
        CA_CC(t,i)=PrixTrim(t,i)*Catch_CC(t,i);
        CA_CCA(t,i)=PrixTrim(t,i)*Catch_CCA(t,i);
    end
//PROFIT CC
        CA_f_CC(t)= sum (CA_CC(t),'c')+ProOtSP(t,1).*nb_boats_Post_BAU_t(t,1);
        C_var_CC(t)=CoutVarTrim(t,1).*nb_boats_Post_BAU_t(t,1);
        C_fix_proj_CC(t)=(fix_cost_trim(1,1).*nb_boats_Post_BAU_t(t,1))./4;
        Profit_CC(t)=(1-bet(1,1))*(CA_f_CC(t)-C_var_CC(t)-C_fix_proj_CC(t));
        PV_CC(t)=(1-bet(1,1))*(CA_f_CC(t)-C_var_CC(t));
//PROFIT CCA
        CA_f_CCA(t)= sum (CA_CCA(t),'c')+ProOtSP(t,2).*nb_boats_Post_BAU_t(t,2);
        C_var_CCA(t)=CoutVarTrim(t,2).*nb_boats_Post_BAU_t(t,2);
        C_fix_proj_CCA(t)=(fix_cost_trim(1,2).*nb_boats_Post_BAU_t(t,2))./4;
        Profit_CCA(t)=(1-bet(1,2))*(CA_f_CCA(t)-C_var_CCA(t)-C_fix_proj_CCA(t));
        PV_CCA(t)=(1-bet(1,2))*(CA_f_CCA(t)-C_var_CCA(t));
//PROFIT T
        CA_f_T(t)= sum (CA_T(t),'c')+ProOtSP(t,3).*nb_boats_Post_BAU_t(t,3);
        C_var_T(t)=CoutVarTrim(t,3).*nb_boats_Post_BAU_t(t,3);
        C_fix_proj_T(t)=(fix_cost_trim(1,3).*nb_boats_Post_BAU_t(t,3))./4;
        Profit_T(t)=(1-bet(1,3))*(CA_f_T(t)-C_var_T(t)-C_fix_proj_T(t));
        PV_T(t)=(1-bet(1,3))*(CA_f_T(t)-C_var_T(t));
//PROFIT INFERIEUR A 0
        if Profit_CC(t)<(-849.5*(1/(1-bet(1,1)))*nb_boats_Post_BAU_t(t,1)) then
            Catch_CC(t,:)=0
        end
        if Profit_CCA(t)<(-1632.5*(1/(1-bet(1,2)))*nb_boats_Post_BAU_t(t,2)) then
            Catch_CCA(t,:)=0
        end
        if Profit_T(t)<(-3470*(1/(1-bet(1,3)))*nb_boats_Post_BAU_t(t,3)) then
            Catch_T(t,:)=0
        end
///////////////////////////////////////////////////////////////////////////////////////
        if Catch_T(t,:)==0 then
            Profit_T(t)=-3470*(1/(1-bet(1,3)))*nb_boats_Post_BAU_t(t,3)
            C_var_T(t)=0;
            C_fix_proj_T(t)=3470;
        end
        if Catch_CCA(t,:)==0 then
            Profit_CCA(t)=-1632.5*(1/(1-bet(1,2)))*nb_boats_Post_BAU_t(t,2)
            C_var_CCA(t)=0;
            C_fix_proj_CCA(t)=0;
        end
        if Catch_CC(t,:)==0 then
            Profit_CC(t)=-849.5*(1/(1-bet(1,1)))*nb_boats_Post_BAU_t(t,1)
            C_var_CC(t)=0;
            C_fix_proj_CC(t)=0;
        end
///////////////////////////////////////////////////////////////////////////////////////

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
///RESULTAT
        Catch_msy=sum(Catch_CC(t,:)+Catch_CCA(t,:)+Catch_T(t,:));
        CCt=[CCt;Catch_CC(t,:)];
        CCAt=[CCAt;Catch_CCA(t,:)];
        Tt=[Tt;Catch_T(t,:)];
/////////////////////////////////////////
/////////Profit
/////////////////////////////////////////
     Pro(t,1)=Profit_CC(t);
     Pro(t,2)=Profit_CCA(t);
     Pro(t,3)=Profit_T(t);
     PV(t,1)=PV_CC(t);
     PV(t,2)=PV_CCA(t);
     PV(t,3)=PV_T(t);
     end
//////////////////////////
//PERIODE DES 50 ANNEES 2018-2068
    for n=0:floor(T_s/Y)-1;
        for t=Horizont+1+n*Y:Horizont+(n+1)*Y;
///////////////////////////////////////////////////////////////////////////////////////////////
            for i=1:NN_calib;
                gamm(t,i)=[gam(t+int(tho(i)),i)];
            end;
            gammaa=[gamm(t,:),1] ;
///////////////////////////////////////////////////////////////////////////////////////////////
//MATRICE BIOMASSE
            Xt=[Xt;Bio(t,:)];
//interaction BIOMASSE et MILIEU
            predation=tauxpredation(Bio(t,:),aij,gammaa);
            predation1=tauxpredation1(Bio(t,:),aij);
            trophic=gi'.*sum(predation,'c')'-sum(predation1,'r');
////////////////////////////////////////////////////////////////
//NOMBRE BATEAUX
////////////////////////////////////////////////////////////////
            for f=1:N_fleet
                historical_effort_bu(n+1,f)=round(nb_boats_Post_BAU(n+1,f)).*nb_j_peche_per_boats_per_trim(1,f);
            end
            historical_effort_CC(n+1)=historical_effort_bu(n+1,1);
            historical_effort_CCA(n+1)=historical_effort_bu(n+1,2);
            historical_effort_T(n+1)=historical_effort_bu(n+1,3);
////////////////////////////////////////////////////////////////
            nb_boats_Post_BAU_t(t,1:3)=round(nb_boats_Post_BAU(n+1,1:3))
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
                end
            CA_T(t,i)=PrixTrim(t,i)*Catch_T(t,i);
            CA_CC(t,i)=PrixTrim(t,i)*Catch_CC(t,i);
            CA_CCA(t,i)=PrixTrim(t,i)*Catch_CCA(t,i);
        end
//PROFIT CC
        CA_f_CC(t)= sum (CA_CC(t),'c')+ProOtSP(t,1).*nb_boats_Post_BAU_t(t,1);
        C_var_CC(t)=CoutVarTrim(t,1).*nb_boats_Post_BAU_t(t,1);
        C_fix_proj_CC(t)=(fix_cost_trim(1,1).*nb_boats_Post_BAU_t(t,1))./4;
        Profit_CC(t)=(1-bet(1,1))*(CA_f_CC(t)-C_var_CC(t)-C_fix_proj_CC(t));
        PV_CC(t)=(1-bet(1,1))*(CA_f_CC(t)-C_var_CC(t));
//PROFIT CCA
        CA_f_CCA(t)= sum (CA_CCA(t),'c')+ProOtSP(t,2).*nb_boats_Post_BAU_t(t,2);
        C_var_CCA(t)=CoutVarTrim(t,2).*nb_boats_Post_BAU_t(t,2);
        C_fix_proj_CCA(t)=(fix_cost_trim(1,2).*nb_boats_Post_BAU_t(t,2))./4;
        Profit_CCA(t)=(1-bet(1,2))*(CA_f_CCA(t)-C_var_CCA(t)-C_fix_proj_CCA(t));
        PV_CCA(t)=(1-bet(1,2))*(CA_f_CCA(t)-C_var_CCA(t));
//PROFIT T
        CA_f_T(t)= sum (CA_T(t),'c')+ProOtSP(t,3).*nb_boats_Post_BAU_t(t,3);
        C_var_T(t)=CoutVarTrim(t,3).*nb_boats_Post_BAU_t(t,3);
        C_fix_proj_T(t)=(fix_cost_trim(1,3).*nb_boats_Post_BAU_t(t,3))./4;
        Profit_T(t)=(1-bet(1,3))*(CA_f_T(t)-C_var_T(t)-C_fix_proj_T(t));
        PV_T(t)=(1-bet(1,3))*(CA_f_T(t)-C_var_T(t));
//PROFIT INFERIEUR A 0
        if Profit_CC(t)<(-849.5*(1/(1-bet(1,1)))*nb_boats_Post_BAU_t(t,1)) then
            Catch_CC(t,:)=0
        end
        if Profit_CCA(t)<(-1632.5*(1/(1-bet(1,2)))*nb_boats_Post_BAU_t(t,2)) then
            Catch_CCA(t,:)=0
        end
        if Profit_T(t)<(-3470*(1/(1-bet(1,3)))*nb_boats_Post_BAU_t(t,3)) then
            Catch_T(t,:)=0
        end
///////////////////////////////////////////////////////////////////////////////////////
        if Catch_T(t,:)==0 then
            Profit_T(t)=-3470*(1/(1-bet(1,3)))*nb_boats_Post_BAU_t(t,3)
            C_var_T(t)=0;
            C_fix_proj_T(t)=3470;
        end
        if Catch_CCA(t,:)==0 then
            Profit_CCA(t)=-1632.5*(1/(1-bet(1,2)))*nb_boats_Post_BAU_t(t,2)
            C_var_CCA(t)=0;
            C_fix_proj_CCA(t)=0;
        end
        if Catch_CC(t,:)==0 then
            Profit_CC(t)=-849.5*(1/(1-bet(1,1)))*nb_boats_Post_BAU_t(t,1)
            C_var_CC(t)=0;
            C_fix_proj_CC(t)=0;
        end
///////////////////////////////////////////////////////////////////////////////////////

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
///RESULTAT
        Catch_msy=sum(Catch_CC(t,:)+Catch_CCA(t,:)+Catch_T(t,:));
        CCt=[CCt;Catch_CC(t,:)];
        CCAt=[CCAt;Catch_CCA(t,:)];
        Tt=[Tt;Catch_T(t,:)];
/////////////////////////////////////////
/////////Profit
/////////////////////////////////////////
     Pro(t,1)=Profit_CC(t);
     Pro(t,2)=Profit_CCA(t);
     Pro(t,3)=Profit_T(t);
     PV(t,1)=PV_CC(t);
     PV(t,2)=PV_CCA(t);
     PV(t,3)=PV_T(t);
     end
    end
///////////////////////////////////////////////////////////////////////////////////////////////
//2 DERNIERES ANNEES 2068-2100
///////////////////////////////////////////////////////////////////////////////////////////////
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
        nb_boats_Post_BAU_t(t,1:3)=round(nb_boats_Post_BAU(n+1,1:3))
///////////////////////////////////////////////////////////////
        historical_effort_CCt(t)=historical_effort_CC(floor(T_s/Y));
        historical_effort_CCAt(t)=historical_effort_CCA(floor(T_s/Y));
        historical_effort_Tt(t)=historical_effort_Tt(floor(T_s/Y));
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
            end
            CA_T(t,i)=PrixTrim(t,i)*Catch_T(t,i);
            CA_CC(t,i)=PrixTrim(t,i)*Catch_CC(t,i);
            CA_CCA(t,i)=PrixTrim(t,i)*Catch_CCA(t,i);
        end
//PROFIT CC
        CA_f_CC(t)= sum (CA_CC(t),'c')+ProOtSP(t,1).*nb_boats_Post_BAU_t(t,1);
        C_var_CC(t)=CoutVarTrim(t,1).*nb_boats_Post_BAU_t(t,1);
        C_fix_proj_CC(t)=(fix_cost_trim(1,1).*nb_boats_Post_BAU_t(t,1))./4;
        Profit_CC(t)=(1-bet(1,1))*(CA_f_CC(t)-C_var_CC(t)-C_fix_proj_CC(t));
        PV_CC(t)=(1-bet(1,1))*(CA_f_CC(t)-C_var_CC(t));
//PROFIT CCA
        CA_f_CCA(t)= sum (CA_CCA(t),'c')+ProOtSP(t,2).*nb_boats_Post_BAU_t(t,2);
        C_var_CCA(t)=CoutVarTrim(t,2).*nb_boats_Post_BAU_t(t,2);
        C_fix_proj_CCA(t)=(fix_cost_trim(1,2).*nb_boats_Post_BAU_t(t,2))./4;
        Profit_CCA(t)=(1-bet(1,2))*(CA_f_CCA(t)-C_var_CCA(t)-C_fix_proj_CCA(t));
        PV_CCA(t)=(1-bet(1,2))*(CA_f_CCA(t)-C_var_CCA(t));
//PROFIT T
        CA_f_T(t)= sum (CA_T(t),'c')+ProOtSP(t,3).*nb_boats_Post_BAU_t(t,3);
        C_var_T(t)=CoutVarTrim(t,3).*nb_boats_Post_BAU_t(t,3);
        C_fix_proj_T(t)=(fix_cost_trim(1,3).*nb_boats_Post_BAU_t(t,3))./4;
        Profit_T(t)=(1-bet(1,3))*(CA_f_T(t)-C_var_T(t)-C_fix_proj_T(t));
        PV_T(t)=(1-bet(1,3))*(CA_f_T(t)-C_var_T(t));
//PROFIT INFERIEUR A 0
        if Profit_CC(t)<(-849.5*(1/(1-bet(1,1)))*nb_boats_Post_BAU_t(t,1)) then
            Catch_CC(t,:)=0
        end
        if Profit_CCA(t)<(-1632.5*(1/(1-bet(1,2)))*nb_boats_Post_BAU_t(t,2)) then
            Catch_CCA(t,:)=0
        end
        if Profit_T(t)<(-3470*(1/(1-bet(1,3)))*nb_boats_Post_BAU_t(t,3)) then
            Catch_T(t,:)=0
        end
///////////////////////////////////////////////////////////////////////////////////////
        if Catch_T(t,:)==0 then
            Profit_T(t)=-3470*(1/(1-bet(1,3)))*nb_boats_Post_BAU_t(t,3)
            C_var_T(t)=0;
            C_fix_proj_T(t)=3470;
        end
        if Catch_CCA(t,:)==0 then
            Profit_CCA(t)=-1632.5*(1/(1-bet(1,2)))*nb_boats_Post_BAU_t(t,2)
            C_var_CCA(t)=0;
            C_fix_proj_CCA(t)=0;
        end
        if Catch_CC(t,:)==0 then
            Profit_CC(t)=-849.5*(1/(1-bet(1,1)))*nb_boats_Post_BAU_t(t,1)
            C_var_CC(t)=0;
            C_fix_proj_CC(t)=0;
        end
///////////////////////////////////////////////////////////////////////////////////////

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
///RESULTAT
        Catch_msy=sum(Catch_CC(t,:)+Catch_CCA(t,:)+Catch_T(t,:));
        CCt=[CCt;Catch_CC(t,:)];
        CCAt=[CCAt;Catch_CCA(t,:)];
        Tt=[Tt;Catch_T(t,:)];
/////////////////////////////////////////
/////////Profit
/////////////////////////////////////////
     Pro(t,1)=Profit_CC(t);
     Pro(t,2)=Profit_CCA(t);
     Pro(t,3)=Profit_T(t);
     PV(t,1)=PV_CC(t);
     PV(t,2)=PV_CCA(t);
     PV(t,3)=PV_T(t);
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
Blimt0=[0,0,0]
for t=1:T_proj
        for i=1:N_species-1
            Blim(t,i)=Xt(t,i)-Blimt0(1,i)
        end
end
//////////////////////////////////////////////////
//Pro
/////////////////////////////////////////
CompteFi=[];
CompteFi=[CompteFi,CA_f_CC,C_var_CC,C_fix_proj_CC,CA_f_CCA,C_var_CCA,C_fix_proj_CCA,CA_f_T,C_var_T,C_fix_proj_T];
     Catcht=sum(CCt,"c")+sum(CCAt,"c")+sum(Tt,"c");
    Foodssect=(Catcht(:,1).*1000)./PopGuy(:);
/////////////////////////////////////////
//NPV
/////////////////////////////////////////
IndNPV=sum(PV,'c')./ActuTrim
//IndGen=[IndGen,IndBio];
IndGen=[IndGen,IndFoodsect];
IndGen=[IndGen,IndNPV];
//IndViab=sum(IndPro);//indgen est le score de viabilite
IndViab=IndNPV;
endfunction
