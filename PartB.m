Tw = Data1.Tw;
[clusteridxSpike] = kmeans(Tw, 4);

unit4Ts1 =[];
unit3Ts1 =[];
unit2Ts1 =[];
unit1Ts1 =[];

for i = 1: length(clusteridxSpike)
 if clusteridxSpike(i) == 3
   unit3Ts1 = [unit3Ts1, Tw(i)];    
 elseif clusteridxSpike(i) == 2
   unit2Ts1 = [unit2Ts1, Tw(i)]; 
 elseif clusteridxSpike(i) == 4
   unit4Ts1 = [unit4Ts1, Tw(i)];
 else
   unit1Ts1 = [unit1Ts1, Tw(i)];
 end 
end

unit4Ts1 = unit4Ts1';
unit3Ts1 = transpose(unit3Ts1);
unit2Ts1 = transpose(unit2Ts1);
unit1Ts1 = transpose(unit1Ts1);

Tmem1 = Data1.Tmem1;
Tmem2 = Data1.Tmem2;

FRMem1 = [];
SE1 = [];
for i = 1 : length(Tmem1)
    sum = 0;
    count = 0;
    for j = 1: length(unit1Ts1)
     if (unit1Ts1(j)> Tmem1(i)) && (unit1Ts1(j) < Tmem2(i))
       count = count + 1;
     end
    end
    firingRate = (count / (Tmem2(i)- Tmem1(i)));
    se = (std(firingRate)/sqrt(length(Tmem1)));
    FRMem1 = [FRMem1,firingRate];
    SE1 = [SE1,se]; 
end
FRMem1 = FRMem1';
SE1 = SE1';

FRMem2 = [];
SE2 = [];
for i = 1 : length(Tmem1)
    sum = 0;
    count = 0;
    for j = 1: length(unit2Ts1)
     if (unit2Ts1(j)> Tmem1(i)) && (unit2Ts1(j) < Tmem2(i))
       count = count + 1;
     end
    end
    firingRate = count / (Tmem2(i)- Tmem1(i));
    se = std(firingRate)/sqrt(length(Tmem1));
    FRMem2 = [FRMem2,firingRate];
    SE2 = [SE2,se];
end
SE2 = SE2';
FRMem2 = FRMem2';

FRMem3 = [];
SE3 = [];
for i = 1 : length(Tmem1)
    sum = 0;
    count = 0;
    for j = 1: length(unit3Ts1)
     if (unit3Ts1(j)> Tmem1(i)) && (unit3Ts1(j) < Tmem2(i))
       count = count + 1;
     end
    end
    firingRate = count / (Tmem2(i)- Tmem1(i));
    se = std(firingRate)/sqrt(length(Tmem1));
    FRMem3 = [FRMem3,firingRate];
    SE3 = [SE3, se];
end
SE3 = SE3';
FRMem3 = FRMem3';

FRMem4=[];
SE4 = [];
for i = 1 : length(Tmem1)
    sum = 0;
    count = 0;
    for j = 1: length(unit4Ts1)
     if (unit4Ts1(j)> Tmem1(i)) && (unit4Ts1(j) < Tmem2(i))
       count = count + 1;
     end
    end
    firingRate = count / (Tmem2(i)- Tmem1(i));
    se = std(firingRate)/sqrt(length(Tmem1));
    FRMem4 = [FRMem4,firingRate];
    SE4 = [SE4, se];
end
SE4 = SE4';
FRMem4 = FRMem4';

FRMemU=[];
SEU = [];
for i = 1 : length(Tmem1)
    sum = 0;
    count = 0;
    for j = 1: length(Tw)
     if (Tw(j)> Tmem1(i)) && (Tw(j) < Tmem2(i))
       count = count + 1;
     end
    end
    firingRate = count / (Tmem2(i)- Tmem1(i));
    se = std(firingRate)/sqrt(length(Tmem1));
    FRMemU = [FRMemU,firingRate];
    SEU = [SEU, se];
end
SEU = SEU';
FRMemU = FRMemU';


figure
errorbar(FRMem1, SE1);
figure
errorbar(FRMem2, SE2);
figure
errorbar(FRMem3, SE3);
figure
errorbar(FRMem4, SE4);
figure
errorbar(FRMemU, SEU);