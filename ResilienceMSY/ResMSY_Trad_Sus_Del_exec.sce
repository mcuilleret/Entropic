chdir('');
//STATED
//Etape1: Absence de choc
exec('donnees.sce');
load('CoutVarTrad','CoutVarTrim');
/////////////////////////////////////////////////////////////////////////////////////////////////////////
if cas=="26" then
    gam=gam_26;
    load('Bsimul26','B_simul_26');
    B_simul=B_simul_26;
end
if cas=="85" then
    gam=gam_85;
    load('Bsimul85','B_simul_85');
    B_simul=B_simul_85;
end
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// A CHANGER POUR LANCER LA DECOUVERTE NOUVELLE
//exec('lanceur_msy.sce');
exec('donnees.sce');
T_s=208
T_proj=Horizont+T_s
test=0
if test==1 then
    //PARAMETRE CALIB
    I=I*1.1;
    aij=aij;
    q_CC=q_CC;
    q_CCA=q_CCA;
    q_T=q_T;
    M=M;
    gi=gi;
    tho=tho;
end
load('CoutVarTrad','CoutVarTrim');
load('20nb_boats_msy_','nb_boats_MSY');

exec('Traj_msy.sce');
//////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//DELAYED 
//Etape1: Absence de choc
load('CoutVarDel','CoutVarTrim');
/////////////////////////////////////////////////////////////////////////////////////////////////////////
if cas=="26" then
    gam=gam_26;
    load('Bsimul26','B_simul_26');
    B_simul=B_simul_26;
end
if cas=="85" then
    gam=gam_85;
    load('Bsimul85','B_simul_85');
    B_simul=B_simul_85;
    
end
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//exec('lanceur_msyDel.sce');
//load('20nb_boats_msy_Del_'+string(cas),'nb_boats_MSY');
exec('donnees.sce');
T_s=208
T_proj=Horizont+T_s
load('CoutVarDel','CoutVarTrim');
load('20nb_boats_msy_','nb_boats_MSY');
exec('Traj_msyDel.sce');
/////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Sus 
//Etape1: Absence de choc
load('CoutVarSus','CoutVarTrim');
/////////////////////////////////////////////////////////////////////////////////////////////////////////
if cas=="26" then
    gam=gam_26;
    load('Bsimul26','B_simul_26');
    B_simul=B_simul_26;
end
if cas=="85" then
    gam=gam_85;
    load('Bsimul85','B_simul_85');
    B_simul=B_simul_85;
end
//////////////////////////////////////////////////////////////////////////////////////////////
//exec('lanceur_msySus.sce');
//load('20nb_boats_msy_Sus_'+string(cas),'nb_boats_MSY');
exec('donnees.sce');
T_s=208
T_proj=Horizont+T_s
load('CoutVarSus','CoutVarTrim');
load('20nb_boats_msy_','nb_boats_MSY');
exec('Traj_msySus.sce');
//////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

