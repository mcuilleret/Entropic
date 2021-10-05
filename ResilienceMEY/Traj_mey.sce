chdir('C:\Users\matve\Desktop\Code These\');
exec('ResilienceMEY2\fctdyn_eco.sce');
exec('ResilienceMEY2\fctdyn.sce');
exec('ResilienceMEY2\DynMat2.sce');
////////////////////////////
//Parametre de lancement
////////////////////////////
nb_boats_Post_BAU=nb_boats_MEY;
aij=data_param(2:2+N_species-1,2:2+N_species-1);

Y=20;
PopGuyTr=PopGuyTrim;
[IndGen,IndPro,IndFoodsect,IndBlim,Pro,Catcht,CCt,CCAt,Tt,Xt,IndSP,IndBio,SP,Blim,Foodssect,nb_boats_Post_BAU_t,IndNPV,CompteFi,historical_effort_bu,CompteFi]=dynamique_MAT_2(nb_boats_Post_BAU,gam,aij,B_simul,Y,PopGuyTr)


////////////////////////////////////////////////////////////////////////////////////
    save('ResilienceMEY2\SP_sans_choc'+string(cas),'SP');
    save('ResilienceMEY2\Blim_sans_choc'+string(cas),'Blim');
    save('ResilienceMEY2\Pro_sans_choc'+string(cas),'Pro');
    save('ResilienceMEY2\Foodssect_sans_choc'+string(cas),'Foodssect');
    save('ResilienceMEY2\nb_boats_Post_BAU_t_sans_choc'+string(cas),'nb_boats_Post_BAU_t')
////////////////////////////////////////////////////////////////////////////////////


