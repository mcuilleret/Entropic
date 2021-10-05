chdir('C:\Users\matve\Desktop\Code These\');
exec('ResilienceMEY2\donnees.sce');
exec('ResilienceMEY2\test_mey.sce');
//Pour RCP 2.6
aij=data_param(2:2+N_species-1,2:2+N_species-1);
Y=20;
PopGuyTr=PopGuyTrim;
///////////////////////////////////////////////////////////////////////////////
[p_opt,Nb_iter]=Calib_MAT_2(iter);
///////////////////////////////////////////////////////////////////////////////
for j=1:length(p_opt)
    param=p_opt(j);
    IndViab_mean=FF_MAT(param); 
    IndViab_op(j,:)=-IndViab_mean; //14*10*200*2
end
///////////////////////////////////////////////////////////////////////////////
b=find(max(IndViab_op(1))==IndViab_op(1));
nb_boats_MEY_=p_opt(b(1));
nb_boats_MEY=matrix(nb_boats_MEY_,[floor(T_s/Y)+1 N_fleet]);
nb_boats_MEY=nb_boats_MEY(1:11,1:3)
T_s=208
T_proj=Horizont+T_s
///////////////////////////////////////////////////////////////////////////////
save('ResilienceMEY2\'+'20'+'nb_boats_mey_','nb_boats_MEY');
