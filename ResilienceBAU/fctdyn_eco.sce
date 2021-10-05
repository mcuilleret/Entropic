
//exec('traj_BAU.sce');
//exec('traj_MEY.sce');
// definition de la fonction nombre de bateau minimal
function[nb_boats]=nb_boats_min(nb_jour_peche_per_boats_per_trim,effort,t1)
    for t=t1:T_proj
        for f=1:N_fleet
       nb_boats(t,f)=effort(t,f)./nb_jour_peche_per_boats_per_trim(1,f)
    end
    end
endfunction
// COUT
function [C_var] =Cout_variable(Effort,Var_cost,fleet)
    for t=1:T_proj
        C_var(t)=Var_cost(t,fleet).*Effort(t)
//integration de l effort dans excel C_var(t)=Var_cost(t,fleet)*Effort(t) *Effort(t)// effort nombre de bateaux
    end
endfunction

function [C_fix]=Cout_fixe(nb_boats,fix_cost,fleet)
    for f=1:N_fleet
        C_fix(1,f)=fix_cost(1,fleet).*nb_boats(1)
    end
endfunction

function [C_fix_proj]=Cout_fixe_proj(nb_boats,fix_cost,t1,fleet)
    for t=t1:T_proj
        C_fix_proj(t)=(fix_cost(1,fleet).*nb_boats(t))./4
    end
endfunction

//CHIFFRE D AFFAIRE
function [CA,CA_f,ProOtSP]=Chiffre_daff(Capture,prix,fleet)
OtSp=[]
for t=1:T_proj
        for i =1: NN_calib
            CA(t,i)=prix(t,i)*Capture(t,i)
        end
        if fleet==1 then
            OtSp(t) = (AE(t,fleet)*28.3)+30.8; 
            elseif fleet==2 then
            if AE(t,fleet)< 1./3 then
                OtSp(t) = (AE(t,fleet)*4.5)+16.4; 
                else OtSp(t)=AE(t,fleet)+15.4;
            end
         elseif fleet==3 then
            if AE(t,fleet)< 1./3 then
                OtSp(t) = (AE(t,fleet)*14.7)+8.3; 
            else OtSp(t)=(AE(t,fleet)*3.2)+5.1;
            end
        end
ProOtSP(t)=1+( OtSp(t)./100)
CA_f(t)= sum (CA(t),'c').*ProOtSP(t)
end
endfunction

//PROFIT
function[Profit]=profit(Chif_daff,cou_var,cou_fix,bet,fleet)
    for t=1:T_proj
        Profit(t)=(1-bet(1,fleet))*(Chif_daff(t)-cou_var(t)-cou_fix(t))
    end
endfunction




