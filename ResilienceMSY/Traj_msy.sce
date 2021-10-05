chdir('C:\Users\matve\Desktop\Code These\ResilienceMSY\');
exec('fctdyn.sce');
exec('fctdyn_eco.sce');
////////////////////////////
//Parametre de lancement
////////////////////////////
nb_boats_Post_BAU=nb_boats_MSY;
aij=data_param(2:2+N_species-1,2:2+N_species-1);
choc=0
Y=20;
PopGuyTr=PopGuyTrim;
//PROBLEME
exec('DynMat2.sce');

[IndGen,IndPro,IndFoodsect,IndBlim,Pro,Catcht,CCt,CCAt,Tt,Xt,IndSP,IndBio,SP,Blim,Foodssect,nb_boats_Post_BAU_t,IndNPV,CompteFi]=dynamique_MAT_2(nb_boats_Post_BAU,gam,aij,B_simul,Y,PopGuyTr)
////////////////////////////////////////////////////////////////////////////////////
    save('SP_sans_choc'+string(cas),'SP');
    save('Blim_sans_choc'+string(cas),'Blim');
    save('Pro_sans_choc'+string(cas),'Pro');
    save('Foodssect_sans_choc'+string(cas),'Foodssect');
    save('nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
////////////////////////////////////////////////////////////////////////////////////


