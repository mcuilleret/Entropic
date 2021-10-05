//Interaction especes
function Q=tauxpredation(X,aij,gammaa)
    for i=1:N_species;
        for j=1:N_species;
            Q(i,j)=aij(i,j)*X(i)*X(j)*gammaa(i);
        end;
    end;
endfunction
function Q=tauxpredation1(X,aij)

    for i=1:N_species;
        for j=1:N_species;
            Q(i,j)=aij(i,j)*X(i)*X(j);
        end;
    end;

endfunction

//DYNAMIQUE-> suppprrrrr-> sauf si traj bau
function [B,CC,CCA,T,sum_capture_CC,sum_capture_CCA,sum_capture_T,sum_capture,catch_estim_sum,sum_capture_agg,trophiq]=dynamique(gam,aij,historical_effort_CC,historical_effort_CCA,historical_effort_T)
    Xt=[];
    CCt=[];
    CCAt=[];
    Tt=[];
    trop=[];
    Bio=Bio_1;
//definition de la matrice des gammas par espece temperature
    for t=1:T_proj;
        for i=1:NN_calib;
            gamm(t,i)=[gam(t+int(tho(i)),i)];
        end;
    gammaa=[gamm(t,:),1] ;
//creation de matrice de croissance ? Xt
    Xt=[Xt;Bio];
//interaction biomasse milieu
    predation=tauxpredation(Bio,aij,gammaa);
    predation1=tauxpredation1(Bio,aij);
    trophic=gi'.*sum(predation,'c')'-sum(predation1,'r');
//jointure verticale trop trophic
//calcul des captures par flotte
    Catch_CC=(((historical_effort_CC(t)) *ones(N_species,1)).*(q_CC))'.*Bio;
    Catch_CCA=(((historical_effort_CCA(t))*ones(N_species,1)).*(q_CCA))'.*Bio;
    Catch_T=(((historical_effort_T(t))*ones(N_species,1)).*(q_T))'.*Bio; 
    Catch=Catch_CC+Catch_CCA+Catch_T;
//calcul des captures ponderes par les captures totales
    CC_pond=Catch_CC./Catch
    CCA_pond=Catch_CCA./Catch
    T_pond=Catch_T./Catch
    for i=1:NN_calib
//cas des captures depassant la biomasse
        if Catch(1,i) > (Bio (1,i)-M'(1,i).*Bio(1,i)+trophic(1,i))  then
           Catch_CC(1,i)=CC_pond(1,i)*(Bio (1,i)-M'(1,i).*Bio(1,i)+trophic(1,i))
           Catch_CCA(1,i)=CCA_pond(1,i)*(Bio (1,i)-M'(1,i).*Bio(1,i)+trophic(1,i))
           Catch_T(1,i)=T_pond(1,i)*(Bio (1,i)-M'(1,i).*Bio(1,i)+trophic(1,i))
        end
        Catch(1,i)=Catch_CC(1,i)+Catch_CCA(1,i)+Catch_T(1,i)
        Bio(1,i)=(Bio(1,i)-M'(1,i).*Bio(1,i)-Catch(1,i)+trophic(1,i));
    end
//determination de la biomasse totale de la ressource planctonique
    Bio(1,N_species)=(Bio(1,N_species)+I(t)-aij(1,N_species).*Bio(1,N_species).*Bio(1,1)-aij(2,N_species).*Bio(1,N_species).*Bio(1,2)-aij(3,N_species).*Bio(1,N_species).*Bio(1,3));
//choix de la situation qui maximise la biomasse 
    Bio=max(zeros(Bio),Bio);
    CCt=[CCt;Catch_CC];
    CCAt=[CCAt;Catch_CCA];
    Tt=[Tt;Catch_T];
end 
//lien entre parametres d entree de la fonction et algo
B=Xt;
CC=CCt;
CCA=CCAt;
T=Tt;
trophiq=trop
sum_capture_CC=[sum(CC,'c')];
sum_capture_CCA=[sum(CCA,'c')];
sum_capture_T=[sum(T,'c')];
sum_capture=[sum_capture_CC,sum_capture_CCA,sum_capture_T];
catch_estim_sum=CCA+CC+T;
sum_capture_agg=sum(sum_capture,'c');
endfunction
