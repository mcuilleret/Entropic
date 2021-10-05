chdir('C:\Users\matve\Desktop\Code These\ResilienceMSY\');
exec('donnees.sce');
exec('test_msy.sce');
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
    //IndViab_op(j,1)=-IndViab_mean(,1); //14*10*200*2
end
///////////////////////////////////////////////////////////////////////////////
b=find(max(IndViab_op(1))==IndViab_op(1));
nb_boats_MSY_=p_opt(b(1));
nb_boats_MSY=matrix(nb_boats_MSY_,[floor(T_s/Y)+1 N_fleet]);
nb_boats_MSY=nb_boats_MSY(1:11,1:3)
T_s=208
T_proj=Horizont+T_s
///////////////////////////////////////////////////////////////////////////////
save('20'+'nb_boats_msy_','nb_boats_MSY');
