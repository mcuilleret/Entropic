//////////Del
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
[DiffDel]=diff(IndDelAn(12:size(IndDelAn)(1),:) ,1,"r")
DebutCriseDelFoodssect=[(find(DiffDel(:,1)==1)+1)']
DebutCriseDelBiologie=[(find(DiffDel(:,2)==1)+1)']
DebutCriseDelEconomie=[(find(DiffDel(:,3)==1)+1)']
DebutCriseDelNbBoat=[(find(DiffDel(:,4)==1)+1)']

[DiffDelTot]=diff(IndDelTotAn(12:size(IndDelTotAn)(1),:) ,1,"r")
DebutCriseDelTotal=[(find(DiffDelTot(:,1)==1)+1)']

//////////////////////////////////////////////////////////////////////////////
FinCriseDelFoodssect=[(find(DiffDel(:,1)==-1)+1)']
FinCriseDelBiologie=[(find(DiffDel(:,2)==-1)+1)']
FinCriseDelEconomie=[(find(DiffDel(:,3)==-1)+1)']
FinCriseDelNbBoat=[(find(DiffDel(:,4)==-1)+1)']
FinCriseDelTotal=[(find(DiffDelTot(:,1)==-1)+1)']
//////////////////////////////////////////////////////////////////////////////
if DebutCriseDelFoodssect(1)==[] & FinCriseDelFoodssect(1)==[]&sum(IndDelAn(12:size(IndDelAn)(1),1))==0 then
    DebutCriseDelFoodssect(1)=[1]
    FinCriseDelFoodssect(1)=[1]
end
if DebutCriseDelTotal(1)==[] & FinCriseDelTotal(1)==[]&sum(IndDelTotAn(12:size(IndDelTotAn)(1),1))==0 then
    DebutCriseDelTotal(1)=[1]
    FinCriseDelTotal(1)=[1]
end
if DebutCriseDelBiologie(1)==[] & FinCriseDelBiologie(1)==[]&sum(IndDelAn(12:size(IndDelAn)(1),2))==0 then
    DebutCriseDelBiologie(1)=[1]
    FinCriseDelBiologie(1)=[1]
end
if DebutCriseDelEconomie(1)==[] & FinCriseDelEconomie(1)==[]&sum(IndDelAn(12:size(IndDelAn)(1),3))==0 then
    DebutCriseDelEconomie(1)=[1]
    FinCriseDelEconomie(1)=[1]
end
if DebutCriseDelNbBoat(1)==[] & FinCriseDelNbBoat(1)==[]&sum(IndDelAn(12:size(IndDelAn)(1),4))==0 then
    DebutCriseDelNbBoat(1)=[1]
    FinCriseDelNbBoat(1)=[1]
end
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
if DebutCriseDelFoodssect(1)==[] then
    DebutCriseDelFoodssect(1)=[0]
end
if DebutCriseDelTotal(1)==[] then
    DebutCriseDelTotal(1)=[0]
end
if DebutCriseDelBiologie(1)==[] then
    DebutCriseDelBiologie(1)=[0]
end
if DebutCriseDelEconomie(1)==[] then
    DebutCriseDelEconomie(1)=[0]
end
if DebutCriseDelNbBoat(1)==[] then
    DebutCriseDelNbBoat(1)=[0]
end

////////////////////////////////////////////////////////////////////////////////
if FinCriseDelFoodssect(1)==[] then
    FinCriseDelFoodssect(1)=[%inf]
end
if FinCriseDelTotal(1)==[] then
    FinCriseDelTotal(1)=[%inf]
end
if FinCriseDelBiologie(1)==[] then
    FinCriseDelBiologie(1)=[%inf]
end
if FinCriseDelEconomie(1)==[] then
    FinCriseDelEconomie(1)=[%inf]
end
if FinCriseDelNbBoat(1)==[] then
    FinCriseDelNbBoat(1)=[%inf]
end
DebutCriseDelNbBoat_=[]
//CAS PARTICULIER nb boat
for i=1:max(size(FinCriseDelNbBoat)(1),size(DebutCriseDelNbBoat)(1))
    disp("a")
    if i>size(FinCriseDelNbBoat)(1) then 
        FinCriseDelNbBoat(i)=[%inf]
    end
    if i>size(DebutCriseDelNbBoat)(1) then 
        DebutCriseDelNbBoat(i)=FinCriseDelNbBoat(i)
    end
    if FinCriseDelNbBoat(i)<DebutCriseDelNbBoat(i) then
        
        if i==1 then
            DebutCriseDelNbBoat_(i)=0
            for i=1:size(DebutCriseDelTotal)(1)
                DebutCriseDelNbBoat_(i+1)=DebutCriseDelNbBoat(i)
            end
            DebutCriseDelNbBoat=DebutCriseDelNbBoat_
        else
            DebutCriseDelNbBoat(i)=DebutCriseDelNbBoat(i)-FinCriseDelNbBoat(i)
        end

        if i<size(FinCriseDelNbBoat)(1) then 
            FinCriseDelNbBoat(i)=FinCriseDelNbBoat(i+1)
        end
        if i==size(FinCriseDelNbBoat)(1) then 
            FinCriseDelNbBoat(i)=[%inf]
        end
    end
end
DebutCriseDelTotal_=[]
//CAS PARTICULIER TOTAL
for i=1:max(size(FinCriseDelTotal)(1),size(DebutCriseDelTotal)(1))
    disp("a")
    if i>size(FinCriseDelTotal)(1) then 
        FinCriseDelTotal(i)=[%inf]
    end
    if i>size(DebutCriseDelTotal)(1) then 
        DebutCriseDelTotal(i)=FinCriseDelTotal(i)
    end
    if FinCriseDelTotal(i)<DebutCriseDelTotal(i) then
        if i==1 then
            DebutCriseDelTotal_(i)=0
            for i=1:size(DebutCriseDelTotal)(1)
                DebutCriseDelTotal_(i+1)=DebutCriseDelTotal(i)
            end
            DebutCriseDelTotal=DebutCriseDelTotal_
        else
            DebutCriseDelTotal(i)=DebutCriseDelTotal(i)-FinCriseDelTotal(i)
        end
        
        if i<size(FinCriseDelTotal)(1) then 
            FinCriseDelTotal(i)=FinCriseDelTotal(i+1)
        end
        if i==size(FinCriseDelTotal)(1) then 
            FinCriseDelTotal(i+1)=[%inf]
        end
    end
end

DebutCriseDelBiologie_=[]
//CAS PARTICULIER Biologie
for i=1:max(size(FinCriseDelBiologie)(1),size(DebutCriseDelBiologie)(1))
    disp("a")
    if i>size(FinCriseDelBiologie)(1) then 
        FinCriseDelBiologie(i)=[%inf]
    end
    if i>size(DebutCriseDelBiologie)(1) then 
        DebutCriseDelBiologie(i)=FinCriseDelBiologie(i)
    end
    if FinCriseDelBiologie(i)<DebutCriseDelBiologie(i) then
        if i==1 then
            DebutCriseDelBiologie_(i)=0
            for i=1:size(DebutCriseDelBiologie)(1)
                DebutCriseDelBiologie_(i+1)=DebutCriseDelBiologie(i)
            end
            DebutCriseDelBiologie=DebutCriseDelBiologie_
        else
            DebutCriseDelBiologie(i)=DebutCriseDelBiologie(i)-FinCriseDelBiologie(i)
        end
        if i<size(FinCriseDelBiologie)(1) then 
            FinCriseDelBiologie(i)=FinCriseDelBiologie(i+1)
        end
        if i==size(FinCriseDelBiologie)(1) then 
            FinCriseDelBiologie(i+1)=[%inf]
        end
    end
end
DebutCriseDelFoodssect_=[]
//CAS PARTICULIER Foodssect
for i=1:max(size(FinCriseDelFoodssect)(1),size(DebutCriseDelFoodssect)(1))
    disp("a")
    if i>size(FinCriseDelFoodssect)(1) then 
        FinCriseDelFoodssect(i)=[%inf]
    end
    if i>size(DebutCriseDelFoodssect)(1) then 
        DebutCriseDelFoodssect(i)=FinCriseDelFoodssect(i)
    end
    if FinCriseDelFoodssect(i)<DebutCriseDelFoodssect(i) then
        if i==1 then
            DebutCriseDelFoodssect_(i)=0
            for i=1:size(DebutCriseDelFoodssect)(1)
                DebutCriseDelFoodssect_(i+1)=DebutCriseDelFoodssect(i)
            end
            DebutCriseDelFoodssect=DebutCriseDelFoodssect_
        else
            DebutCriseDelFoodssect(i)=DebutCriseDelFoodssect(i)-FinCriseDelFoodssect(i)
        end
        if i<size(FinCriseDelFoodssect)(1) then 
            FinCriseDelFoodssect(i)=FinCriseDelFoodssect(i+1)
        end
        if i==size(FinCriseDelFoodssect)(1) then 
            FinCriseDelFoodssect(i+1)=[%inf]
        end
    end
end

//CAS PARTICULIER Economie
for i=1:max(size(FinCriseDelEconomie)(1),size(DebutCriseDelEconomie)(1))
    disp("a")
    if i>size(FinCriseDelEconomie)(1) then 
        FinCriseDelEconomie(i)=[%inf]
    end
    if i>size(DebutCriseDelEconomie)(1) then 
        DebutCriseDelEconomie(i)=FinCriseDelEconomie(i)
    end
    if FinCriseDelEconomie(i)<DebutCriseDelEconomie(i) then
        if i==1 then
            DebutCriseDelEconomie_(i)=0
            for i=1:size(DebutCriseDelEconomie)(1)
                DebutCriseDelEconomie_(i+1)=DebutCriseDelEconomie(i)
            end
            DebutCriseDelEconomie=DebutCriseDelEconomie_
        else
            DebutCriseDelEconomie(i)=DebutCriseDelEconomie(i)-FinCriseDelEconomie(i)
        end
        if i<size(FinCriseDelEconomie)(1) then 
            FinCriseDelEconomie(i)=FinCriseDelEconomie(i+1)
        end
        if i==size(FinCriseDelEconomie)(1) then 
            FinCriseDelEconomie(i+1)=[%inf]
        end
    end
end

//CALCUL TOTAL
Delta=[]
for i=1:size(DebutCriseDelTotal)(1)
    Delta(i)=FinCriseDelTotal(i)-DebutCriseDelTotal(i)
end
RecoveryDelTotal=1/(sum(Delta)+1)


//CALCUL FOODSSECT
Delta=[]
for i=1:size(DebutCriseDelFoodssect)(1)
    Delta(i)=FinCriseDelFoodssect(i)-DebutCriseDelFoodssect(i)
end
RecoveryDelFoodssect=1/(sum(Delta)+1)
//CALCUL BIOLOGIE
Delta=[]
for i=1:size(DebutCriseDelBiologie)(1)
    Delta(i)=FinCriseDelBiologie(i)-DebutCriseDelBiologie(i)
end
RecoveryDelBiologie=1/(sum(Delta)+1)
//CALCUL ECONOMIE
Delta=[]
for i=1:size(DebutCriseDelEconomie)(1)
    Delta(i)=FinCriseDelEconomie(i)-DebutCriseDelEconomie(i)
end
RecoveryDelEconomie=1/(sum(Delta)+1)
//CALCUL BATEAU
Delta=[]
for i=1:size(DebutCriseDelNbBoat)(1)
    Delta(i)=FinCriseDelNbBoat(i)-DebutCriseDelNbBoat(i)
end
RecoveryDelNbBoat=1/(sum(Delta)+1)
RecoveryDel=[RecoveryDelFoodssect,RecoveryDelBiologie,RecoveryDelEconomie,RecoveryDelNbBoat,RecoveryDelTotal]
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//////////Sus
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
[DiffSus]=diff(IndSusAn(12:size(IndSusAn)(1),:) ,1,"r")
DebutCriseSusFoodssect=[(find(DiffSus(:,1)==1)+1)']
DebutCriseSusBiologie=[(find(DiffSus(:,2)==1)+1)']
DebutCriseSusEconomie=[(find(DiffSus(:,3)==1)+1)']
DebutCriseSusNbBoat=[(find(DiffSus(:,4)==1)+1)']

[DiffSusTot]=diff(IndSusTotAn(12:size(IndSusTotAn)(1),:) ,1,"r")
DebutCriseSusTotal=[(find(DiffSusTot(:,1)==1)+1)']

//////////////////////////////////////////////////////////////////////////////
FinCriseSusFoodssect=[(find(DiffSus(:,1)==-1)+1)']
FinCriseSusBiologie=[(find(DiffSus(:,2)==-1)+1)']
FinCriseSusEconomie=[(find(DiffSus(:,3)==-1)+1)']
FinCriseSusNbBoat=[(find(DiffSus(:,4)==-1)+1)']
FinCriseSusTotal=[(find(DiffSusTot(:,1)==-1)+1)']
//////////////////////////////////////////////////////////////////////////////
if DebutCriseSusFoodssect(1)==[] & FinCriseSusFoodssect(1)==[]&sum(IndSusAn(12:size(IndSusAn)(1),1))==0 then
    DebutCriseSusFoodssect(1)=[1]
    FinCriseSusFoodssect(1)=[1]
end
if DebutCriseSusTotal(1)==[] & FinCriseSusTotal(1)==[]&sum(IndSusTotAn(12:size(IndSusTotAn)(1),1))==0 then
    DebutCriseSusTotal(1)=[1]
    FinCriseSusTotal(1)=[1]
end
if DebutCriseSusBiologie(1)==[] & FinCriseSusBiologie(1)==[]&sum(IndSusAn(12:size(IndSusAn)(1),2))==0 then
    DebutCriseSusBiologie(1)=[1]
    FinCriseSusBiologie(1)=[1]
end
if DebutCriseSusEconomie(1)==[] & FinCriseSusEconomie(1)==[]&sum(IndSusAn(12:size(IndSusAn)(1),3))==0 then
    DebutCriseSusEconomie(1)=[1]
    FinCriseSusEconomie(1)=[1]
end
if DebutCriseSusNbBoat(1)==[] & FinCriseSusNbBoat(1)==[]&sum(IndSusAn(12:size(IndSusAn)(1),4))==0 then
    DebutCriseSusNbBoat(1)=[1]
    FinCriseSusNbBoat(1)=[1]
end
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
if DebutCriseSusFoodssect(1)==[] then
    DebutCriseSusFoodssect(1)=[0]
end
if DebutCriseSusTotal(1)==[] then
    DebutCriseSusTotal(1)=[0]
end
if DebutCriseSusBiologie(1)==[] then
    DebutCriseSusBiologie(1)=[0]
end
if DebutCriseSusEconomie(1)==[] then
    DebutCriseSusEconomie(1)=[0]
end
if DebutCriseSusNbBoat(1)==[] then
    DebutCriseSusNbBoat(1)=[0]
end
if DebutCriseSusTotal(1)==[] then
    DebutCriseSusTotal(1)=[0]
end
////////////////////////////////////////////////////////////////////////////////
if FinCriseSusFoodssect(1)==[] then
    FinCriseSusFoodssect(1)=[%inf]
end
if FinCriseSusTotal(1)==[] then
    FinCriseSusTotal(1)=[%inf]
end
if FinCriseSusBiologie(1)==[] then
    FinCriseSusBiologie(1)=[%inf]
end
if FinCriseSusEconomie(1)==[] then
    FinCriseSusEconomie(1)=[%inf]
end
if FinCriseSusNbBoat(1)==[] then
    FinCriseSusNbBoat(1)=[%inf]
end
//CAS PARTICULIER nb boat
for i=1:max(size(FinCriseSusNbBoat)(1),size(DebutCriseSusNbBoat)(1))
    disp("a")
    if i>size(FinCriseSusNbBoat)(1) then 
        FinCriseSusNbBoat(i)=[%inf]
    end
    if i>size(DebutCriseSusNbBoat)(1) then 
        DebutCriseSusNbBoat(i)=FinCriseSusNbBoat(i)
    end
    if FinCriseSusNbBoat(i)<DebutCriseSusNbBoat(i) then
        
        if i==1 then
            DebutCriseSusNbBoat_(i)=0
            for i=1:size(DebutCriseSusTotal)(1)
                DebutCriseSusNbBoat_(i+1)=DebutCriseSusNbBoat(i)
            end
            DebutCriseSusNbBoat=DebutCriseSusNbBoat_
        else
            DebutCriseSusNbBoat(i)=DebutCriseSusNbBoat(i)-FinCriseSusNbBoat(i)
        end

        if i<size(FinCriseSusNbBoat)(1) then 
            FinCriseSusNbBoat(i)=FinCriseSusNbBoat(i+1)
        end
        if i==size(FinCriseSusNbBoat)(1) then 
            FinCriseSusNbBoat(i)=[%inf]
        end
    end
end
DebutCriseSusTotal_=[]
//CAS PARTICULIER TOTAL
for i=1:max(size(FinCriseSusTotal)(1),size(DebutCriseSusTotal)(1))
    disp("a")
    if i>size(FinCriseSusTotal)(1) then 
        FinCriseSusTotal(i)=[%inf]
    end
    if i>size(DebutCriseSusTotal)(1) then 
        DebutCriseSusTotal(i)=FinCriseSusTotal(i)
    end
    if FinCriseSusTotal(i)<DebutCriseSusTotal(i) then
        if i==1 then
            DebutCriseSusTotal_(i)=0
            for i=1:size(DebutCriseSusTotal)(1)
                DebutCriseSusTotal_(i+1)=DebutCriseSusTotal(i)
            end
            DebutCriseSusTotal=DebutCriseSusTotal_
        else
            DebutCriseSusTotal(i)=DebutCriseSusTotal(i)-FinCriseSusTotal(i)
        end
        
        if i<size(FinCriseSusTotal)(1) then 
            FinCriseSusTotal(i)=FinCriseSusTotal(i+1)
        end
        if i==size(FinCriseSusTotal)(1) then 
            FinCriseSusTotal(i+1)=[%inf]
        end
    end
end

DebutCriseSusBiologie_=[]
//CAS PARTICULIER Biologie
for i=1:max(size(FinCriseSusBiologie)(1),size(DebutCriseSusBiologie)(1))
    disp("a")
    if i>size(FinCriseSusBiologie)(1) then 
        FinCriseSusBiologie(i)=[%inf]
    end
    if i>size(DebutCriseSusBiologie)(1) then 
        DebutCriseSusBiologie(i)=FinCriseSusBiologie(i)
    end
    if FinCriseSusBiologie(i)<DebutCriseSusBiologie(i) then
        if i==1 then
            DebutCriseSusBiologie_(i)=0
            for i=1:size(DebutCriseSusBiologie)(1)
                DebutCriseSusBiologie_(i+1)=DebutCriseSusBiologie(i)
            end
            DebutCriseSusBiologie=DebutCriseSusBiologie_
        else
            DebutCriseSusBiologie(i)=DebutCriseSusBiologie(i)-FinCriseSusBiologie(i)
        end
        if i<size(FinCriseSusBiologie)(1) then 
            FinCriseSusBiologie(i)=FinCriseSusBiologie(i+1)
        end
        if i==size(FinCriseSusBiologie)(1) then 
            FinCriseSusBiologie(i+1)=[%inf]
        end
    end
end
DebutCriseSusFoodssect_=[]
//CAS PARTICULIER Foodssect
for i=1:max(size(FinCriseSusFoodssect)(1),size(DebutCriseSusFoodssect)(1))
    disp("a")
    if i>size(FinCriseSusFoodssect)(1) then 
        FinCriseSusFoodssect(i)=[%inf]
    end
    if i>size(DebutCriseSusFoodssect)(1) then 
        DebutCriseSusFoodssect(i)=FinCriseSusFoodssect(i)
    end
    if FinCriseSusFoodssect(i)<DebutCriseSusFoodssect(i) then
        if i==1 then
            DebutCriseSusFoodssect_(i)=0
            for i=1:size(DebutCriseSusFoodssect)(1)
                DebutCriseSusFoodssect_(i+1)=DebutCriseSusFoodssect(i)
            end
            DebutCriseSusFoodssect=DebutCriseSusFoodssect_
        else
            DebutCriseSusFoodssect(i)=DebutCriseSusFoodssect(i)-FinCriseSusFoodssect(i)
        end
        if i<size(FinCriseSusFoodssect)(1) then 
            FinCriseSusFoodssect(i)=FinCriseSusFoodssect(i+1)
        end
        if i==size(FinCriseSusFoodssect)(1) then 
            FinCriseSusFoodssect(i+1)=[%inf]
        end
    end
end

//CAS PARTICULIER Economie
for i=1:max(size(FinCriseSusEconomie)(1),size(DebutCriseSusEconomie)(1))
    disp("a")
    if i>size(FinCriseSusEconomie)(1) then 
        FinCriseSusEconomie(i)=[%inf]
    end
    if i>size(DebutCriseSusEconomie)(1) then 
        DebutCriseSusEconomie(i)=FinCriseSusEconomie(i)
    end
    if FinCriseSusEconomie(i)<DebutCriseSusEconomie(i) then
        if i==1 then
            DebutCriseSusEconomie_(i)=0
            for i=1:size(DebutCriseSusEconomie)(1)
                DebutCriseSusEconomie_(i+1)=DebutCriseSusEconomie(i)
            end
            DebutCriseSusEconomie=DebutCriseSusEconomie_
        else
            DebutCriseSusEconomie(i)=DebutCriseSusEconomie(i)-FinCriseSusEconomie(i)
        end
        if i<size(FinCriseSusEconomie)(1) then 
            FinCriseSusEconomie(i)=FinCriseSusEconomie(i+1)
        end
        if i==size(FinCriseSusEconomie)(1) then 
            FinCriseSusEconomie(i+1)=[%inf]
        end
    end
end

//CALCUL TOTAL
Susta=[]
for i=1:size(DebutCriseSusTotal)(1)
    Susta(i)=FinCriseSusTotal(i)-DebutCriseSusTotal(i)
end
RecoverySusTotal=1/(sum(Susta)+1)


//CALCUL FOODSSECT
Susta=[]
for i=1:size(DebutCriseSusFoodssect)(1)
    Susta(i)=FinCriseSusFoodssect(i)-DebutCriseSusFoodssect(i)
end
RecoverySusFoodssect=1/(sum(Susta)+1)
//CALCUL BIOLOGIE
Susta=[]
for i=1:size(DebutCriseSusBiologie)(1)
    Susta(i)=FinCriseSusBiologie(i)-DebutCriseSusBiologie(i)
end
RecoverySusBiologie=1/(sum(Susta)+1)
//CALCUL ECONOMIE
Susta=[]
for i=1:size(DebutCriseSusEconomie)(1)
    Susta(i)=FinCriseSusEconomie(i)-DebutCriseSusEconomie(i)
end
RecoverySusEconomie=1/(sum(Susta)+1)
//CALCUL BATEAU
Susta=[]
for i=1:size(DebutCriseSusNbBoat)(1)
    Susta(i)=FinCriseSusNbBoat(i)-DebutCriseSusNbBoat(i)
end
RecoverySusNbBoat=1/(sum(Susta)+1)
RecoverySus=[RecoverySusFoodssect,RecoverySusBiologie,RecoverySusEconomie,RecoverySusNbBoat,RecoverySusTotal]
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//////////Trad
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
[DiffTrad]=diff(IndTradAn(12:size(IndTradAn)(1),:) ,1,"r")
DebutCriseTradFoodssect=[(find(DiffTrad(:,1)==1)+1)']
DebutCriseTradBiologie=[(find(DiffTrad(:,2)==1)+1)']
DebutCriseTradEconomie=[(find(DiffTrad(:,3)==1)+1)']
DebutCriseTradNbBoat=[(find(DiffTrad(:,4)==1)+1)']
[DiffTradTot]=diff(IndTradTotAn(12:size(IndTradTotAn)(1),:) ,1,"r")
DebutCriseTradTotal=[(find(DiffTradTot(:,1)==1)+1)']

//////////////////////////////////////////////////////////////////////////////
FinCriseTradFoodssect=[(find(DiffTrad(:,1)==-1)+1)']
FinCriseTradBiologie=[(find(DiffTrad(:,2)==-1)+1)']
FinCriseTradEconomie=[(find(DiffTrad(:,3)==-1)+1)']
FinCriseTradNbBoat=[(find(DiffTrad(:,4)==-1)+1)']
FinCriseTradTotal=[(find(DiffTradTot(:,1)==-1)+1)']
//////////////////////////////////////////////////////////////////////////////
if DebutCriseTradFoodssect(1)==[] & FinCriseTradFoodssect(1)==[]&sum(IndTradAn(12:size(IndTradAn)(1),1))==0 then
    DebutCriseTradFoodssect(1)=[1]
    FinCriseTradFoodssect(1)=[1]
end
if DebutCriseTradTotal(1)==[] & FinCriseTradTotal(1)==[]&sum(IndTradTotAn(12:size(IndTradTotAn)(1),1))==0 then
    DebutCriseTradTotal(1)=[1]
    FinCriseTradTotal(1)=[1]
end
if DebutCriseTradBiologie(1)==[] & FinCriseTradBiologie(1)==[]&sum(IndTradAn(12:size(IndTradAn)(1),2))==0 then
    DebutCriseTradBiologie(1)=[1]
    FinCriseTradBiologie(1)=[1]
end
if DebutCriseTradEconomie(1)==[] & FinCriseTradEconomie(1)==[]&sum(IndTradAn(12:size(IndTradAn)(1),3))==0 then
    DebutCriseTradEconomie(1)=[1]
    FinCriseTradEconomie(1)=[1]
end
if DebutCriseTradNbBoat(1)==[] & FinCriseTradNbBoat(1)==[]&sum(IndTradAn(12:size(IndTradAn)(1),4))==0 then
    DebutCriseTradNbBoat(1)=[1]
    FinCriseTradNbBoat(1)=[1]
end
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
if DebutCriseTradFoodssect(1)==[] then
    DebutCriseTradFoodssect(1)=[0]
end
if DebutCriseTradTotal(1)==[] then
    DebutCriseTradTotal(1)=[0]
end
if DebutCriseTradBiologie(1)==[] then
    DebutCriseTradBiologie(1)=[0]
end
if DebutCriseTradEconomie(1)==[] then
    DebutCriseTradEconomie(1)=[0]
end
if DebutCriseTradNbBoat(1)==[] then
    DebutCriseTradNbBoat(1)=[0]
end

////////////////////////////////////////////////////////////////////////////////
if FinCriseTradFoodssect(1)==[] then
    FinCriseTradFoodssect(1)=[%inf]
end
if FinCriseTradTotal(1)==[] then
    FinCriseTradTotal(1)=[%inf]
end
if FinCriseTradBiologie(1)==[] then
    FinCriseTradBiologie(1)=[%inf]
end
if FinCriseTradEconomie(1)==[] then
    FinCriseTradEconomie(1)=[%inf]
end
if FinCriseTradNbBoat(1)==[] then
    FinCriseTradNbBoat(1)=[%inf]
end
//CAS PARTICULIER nb boat
for i=1:max(size(FinCriseTradNbBoat)(1),size(DebutCriseTradNbBoat)(1))
    disp("a")
    if i>size(FinCriseTradNbBoat)(1) then 
        FinCriseTradNbBoat(i)=[%inf]
    end
    if i>size(DebutCriseTradNbBoat)(1) then 
        DebutCriseTradNbBoat(i)=FinCriseTradNbBoat(i)
    end
    if FinCriseTradNbBoat(i)<DebutCriseTradNbBoat(i) then
        
        if i==1 then
            DebutCriseTradNbBoat_(i)=0
            for i=1:size(DebutCriseTradTotal)(1)
                DebutCriseTradNbBoat_(i+1)=DebutCriseTradNbBoat(i)
            end
            DebutCriseTradNbBoat=DebutCriseTradNbBoat_
        else
            DebutCriseTradNbBoat(i)=DebutCriseTradNbBoat(i)-FinCriseTradNbBoat(i)
        end

        if i<size(FinCriseTradNbBoat)(1) then 
            FinCriseTradNbBoat(i)=FinCriseTradNbBoat(i+1)
        end
        if i==size(FinCriseTradNbBoat)(1) then 
            FinCriseTradNbBoat(i)=[%inf]
        end
    end
end
DebutCriseTradTotal_=[]
//CAS PARTICULIER TOTAL
for i=1:max(size(FinCriseTradTotal)(1),size(DebutCriseTradTotal)(1))
    disp("a")
    if i>size(FinCriseTradTotal)(1) then 
        FinCriseTradTotal(i)=[%inf]
    end
    if i>size(DebutCriseTradTotal)(1) then 
        DebutCriseTradTotal(i)=FinCriseTradTotal(i)
    end
    if FinCriseTradTotal(i)<DebutCriseTradTotal(i) then
        if i==1 then
            DebutCriseTradTotal_(i)=0
            for i=1:size(DebutCriseTradTotal)(1)
                DebutCriseTradTotal_(i+1)=DebutCriseTradTotal(i)
            end
            DebutCriseTradTotal=DebutCriseTradTotal_
        else
            DebutCriseTradTotal(i)=DebutCriseTradTotal(i)-FinCriseTradTotal(i)
        end
        
        if i<size(FinCriseTradTotal)(1) then 
            FinCriseTradTotal(i)=FinCriseTradTotal(i+1)
        end
        if i==size(FinCriseTradTotal)(1) then 
            FinCriseTradTotal(i+1)=[%inf]
        end
    end
end

DebutCriseTradBiologie_=[]
//CAS PARTICULIER Biologie
for i=1:max(size(FinCriseTradBiologie)(1),size(DebutCriseTradBiologie)(1))
    disp("a")
    if i>size(FinCriseTradBiologie)(1) then 
        FinCriseTradBiologie(i)=[%inf]
    end
    if i>size(DebutCriseTradBiologie)(1) then 
        DebutCriseTradBiologie(i)=FinCriseTradBiologie(i)
    end
    if FinCriseTradBiologie(i)<DebutCriseTradBiologie(i) then
        if i==1 then
            DebutCriseTradBiologie_(i)=0
            for i=1:size(DebutCriseTradBiologie)(1)
                DebutCriseTradBiologie_(i+1)=DebutCriseTradBiologie(i)
            end
            DebutCriseTradBiologie=DebutCriseTradBiologie_
        else
            DebutCriseTradBiologie(i)=DebutCriseTradBiologie(i)-FinCriseTradBiologie(i)
        end
        if i<size(FinCriseTradBiologie)(1) then 
            FinCriseTradBiologie(i)=FinCriseTradBiologie(i+1)
        end
        if i==size(FinCriseTradBiologie)(1) then 
            FinCriseTradBiologie(i+1)=[%inf]
        end
    end
end
DebutCriseTradFoodssect_=[]
//CAS PARTICULIER Foodssect
for i=1:max(size(FinCriseTradFoodssect)(1),size(DebutCriseTradFoodssect)(1))
    disp("a")
    if i>size(FinCriseTradFoodssect)(1) then 
        FinCriseTradFoodssect(i)=[%inf]
    end
    if i>size(DebutCriseTradFoodssect)(1) then 
        DebutCriseTradFoodssect(i)=FinCriseTradFoodssect(i)
    end
    if FinCriseTradFoodssect(i)<DebutCriseTradFoodssect(i) then
        if i==1 then
            DebutCriseTradFoodssect_(i)=0
            for i=1:size(DebutCriseTradFoodssect)(1)
                DebutCriseTradFoodssect_(i+1)=DebutCriseTradFoodssect(i)
            end
            DebutCriseTradFoodssect=DebutCriseTradFoodssect_
        else
            DebutCriseTradFoodssect(i)=DebutCriseTradFoodssect(i)-FinCriseTradFoodssect(i)
        end
        if i<size(FinCriseTradFoodssect)(1) then 
            FinCriseTradFoodssect(i)=FinCriseTradFoodssect(i+1)
        end
        if i==size(FinCriseTradFoodssect)(1) then 
            FinCriseTradFoodssect(i+1)=[%inf]
        end
    end
end

//CAS PARTICULIER Economie
for i=1:max(size(FinCriseTradEconomie)(1),size(DebutCriseTradEconomie)(1))
    disp("a")
    if i>size(FinCriseTradEconomie)(1) then 
        FinCriseTradEconomie(i)=[%inf]
    end
    if i>size(DebutCriseTradEconomie)(1) then 
        DebutCriseTradEconomie(i)=FinCriseTradEconomie(i)
    end
    if FinCriseTradEconomie(i)<DebutCriseTradEconomie(i) then
        if i==1 then
            DebutCriseTradEconomie_(i)=0
            for i=1:size(DebutCriseTradEconomie)(1)
                DebutCriseTradEconomie_(i+1)=DebutCriseTradEconomie(i)
            end
            DebutCriseTradEconomie=DebutCriseTradEconomie_
        else
            DebutCriseTradEconomie(i)=DebutCriseTradEconomie(i)-FinCriseTradEconomie(i)
        end
        if i<size(FinCriseTradEconomie)(1) then 
            FinCriseTradEconomie(i)=FinCriseTradEconomie(i+1)
        end
        if i==size(FinCriseTradEconomie)(1) then 
            FinCriseTradEconomie(i+1)=[%inf]
        end
    end
end

//CALCUL TOTAL
Tradta=[]
for i=1:size(DebutCriseTradTotal)(1)
    Tradta(i)=FinCriseTradTotal(i)-DebutCriseTradTotal(i)
end
RecoveryTradTotal=1/(sum(Tradta)+1)
//CALCUL FOODSSECT
Tradta=[]
for i=1:size(DebutCriseTradFoodssect)(1)
    Tradta(i)=FinCriseTradFoodssect(i)-DebutCriseTradFoodssect(i)
end
RecoveryTradFoodssect=1/(sum(Tradta)+1)
//CALCUL BIOLOGIE
Tradta=[]
for i=1:size(DebutCriseTradBiologie)(1)
    Tradta(i)=FinCriseTradBiologie(i)-DebutCriseTradBiologie(i)
end
RecoveryTradBiologie=1/(sum(Tradta)+1)
//CALCUL ECONOMIE
Tradta=[]
for i=1:size(DebutCriseTradEconomie)(1)
    Tradta(i)=FinCriseTradEconomie(i)-DebutCriseTradEconomie(i)
end
RecoveryTradEconomie=1/(sum(Tradta)+1)
//CALCUL BATEAU
Tradta=[]
for i=1:size(DebutCriseTradNbBoat)(1)
    Tradta(i)=FinCriseTradNbBoat(i)-DebutCriseTradNbBoat(i)
end
RecoveryTradNbBoat=1/(sum(Tradta)+1)
RecoveryTrad=[RecoveryTradFoodssect,RecoveryTradBiologie,RecoveryTradEconomie,RecoveryTradNbBoat,RecoveryTradTotal]
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
