chdir('C:\Users\matve\Desktop\Code These\ResilienceMSY\');
exec('fctdyn.sce');
exec('fctdyn_eco.sce');
exec('donnees.sce');
cas="85"
iter=100
exec('ResMSY_Trad_Sus_Del_exec.sce');
cas="26"
iter=100
exec('ResMSY_Trad_Sus_Del_exec.sce');
