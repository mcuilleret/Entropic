chdir('C:\Users\matve\Desktop\Code These\ResilienceMEY\');
exec('fctdyn.sce');
exec('DynMat.sce');
////////////////////////////
////////////////////////////
////////////////////////////
// on veut maximiser les captures
            load('Bsimul26','B_simul_26');
            load('Bsimul85','B_simul_85');
            
function f=FF_MAT(p) 
    nb_boats_Post_BAU=matrix(p,[floor(T_s/Y)+1 N_fleet]);
    climate=["26","85"]
    oilprice=["Trad","Sus","Del"]
    load('CoutVarDel','CoutVarTrim');
    MatIndviab=[]
    for i=1:size(climate)(2)
        if climate(i)=="26" then
            gam=gam_26(:,1:3);
            B_simul=B_simul_26;
        end
        if climate(i)=="85" then
            gam=gam_85(:,1:3);
            B_simul=B_simul_85;
        end
    for j=1:size(oilprice)(2)
        if oilprice(j)=="Trad" then
            CoutVarTrim=CoutVarTrimTrad
        end
        if oilprice(j)=="Del" then
            CoutVarTrim=CoutVarTrimDel
        end
        if oilprice(j)=="Sus" then
            CoutVarTrim=CoutVarTrimSus
        end
            [IndViab]=dynamique_MAT(nb_boats_Post_BAU,gam,aij,B_simul,Y,PopGuyTr)
            MatIndviab=[MatIndviab,IndViab]
        end
    end
    f=-mean(MatIndviab)
    //f(1,2)=stdev(IndViab)
endfunction

////////////////////////////
////////////////////////////
////////////////////////////
function [p_opt,NbGen]=Calib_MAT_2(iter)
    //// Limits;
    b_sup=[ones((floor(T_s/Y)+1)*1,1)*150;ones((floor(T_s/Y)+1)*1,1)*100;ones((floor(T_s/Y)+1)*1,1)*30]//*1000;
    b_inf=ones((floor(T_s/Y)+1)*N_fleet,1)//*1000;
    /// Algorithm parameters
    PopSize     = 50;
    Proba_cross = 0.7;//0.7
    Proba_mut   = 0.1;
    NbGen=iter; 
    NbCouples   = 21;
    Log         = %T; // si on mets Log=%F alors on n'a pas d'affichage
    nb_disp     = 2; // Nb point to display from the optimal population
    pressure    = 0.05;
    ga_params = init_param();
    // Parameters to adapt to the shape of the optimization problem
    ga_params = add_param(ga_params,'minbound',[b_inf]); //fixe les bornes inf (les especes qui sont des proies ne peuvent descendre en dessous de -1) | Ceci N'EST PAS la taille minimale du vecteur
    ga_params = add_param(ga_params,'maxbound',[b_sup]); //fixe les bornes sup (les especes qui sont des prédateurs ne peuvent monter au dessus de 1)
    ga_params = add_param(ga_params,'dimension',40);//////////////////////////////////////////////////////////////////////////////////////////////***
    ga_params = add_param(ga_params,'beta',0); //créé l'intervalle [-beta,beta+1] (=[0,1]) qui représente la plage du générateur aléatoire. On prend une valeur aléatoire dans cet intervalle et on l'utilise pour effectuer une combinaison convexe entre les deux individus de la fct crossover_ga_default. 
    ga_params = add_param(ga_params,'delta',0.1); //0.1 créé l'intervalle [-delta+delta] (=[-0.1,0.1]) qui représente la plage de générateur aléatoire rreprésentant la PERTURBATION aléatoire utilisée dans mutation_ga_default. Elle permet de faire muter les individus.
    // Parameters to fine tune the Genetic algorithm. All these parameters are optional for continuous optimization
    // If you need to adapt the GA to a special problem, you 
    //ga_params = add_param(ga_params,'p_guess',p_guess);
    //    ga_params = add_param(ga_params,'init_func',init_ga_AL);    
    ga_params = add_param(ga_params,'init_func',init_ga_default);
    ga_params = add_param(ga_params,'crossover_func',crossover_ga_default);
    ga_params = add_param(ga_params,'mutation_func',mutation_ga_default);
    //ga_params = add_param(ga_params,'codage_func',codage_identity);
    ga_params = add_param(ga_params,'selection_func',selection_ga_elitist);
    //    ga_params = add_param(ga_params,'selection_func',selection_ga_random);
    ga_params = add_param(ga_params,'nb_couples',NbCouples);
    ga_params = add_param(ga_params,'pressure',pressure); //la valeur du pire individu

    //    Min = get_param(ga_params,'minbound');
    //    Max = get_param(ga_params,'maxbound');
    //    x0 = 0.5 .* (Max + Min);
    //    x0  = (Max - Min) .* grand(size(Min,1),size(Min,2),'def') + Min;

    
        [p_opt, fobj_p_opt, Pop_init, fobj_p_init]=optim_ga(FF_MAT, PopSize,NbGen, Proba_mut, Proba_cross, Log, ga_params);
    //l'algorithme d'optimisation crée le vecteur RS (tx de croissance et matrice trophique) car l'argumen d'entrée de la focntion erreur estimation est un vecteur RS de la même taille et contruction que celui en sortie.
endfunction
