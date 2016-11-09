Tw = Data1.Tw;
T0 = Data1.T0;
T19 = Data1.T19;
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
%spkTrials1 
for i = 1:length(T0)
  spkInTrial = [];
  tsByTrial =[];
  for j = 1:length(unit1Ts1)
    if (unit1Ts1(j) > T0(i) && unit1Ts1(j) < T19(i))
      spkInTrial = [spkInTrial, j]; 
    end
  end
  spkInTrial = spkInTrial';
  for j = 1:length(spkInTrial)
      tsByTrial = [tsByTrial,unit1Ts1(spkInTrial(j))]; 
  end
  tsByTrial =tsByTrial';
  if ~isempty(tsByTrial)
  spkTrials1(i, 1:length(spkInTrial)) = tsByTrial - tsByTrial(1);
  end
end

%spkTrials2 
for i = 1:length(T0)
  spkInTrial = [];
  tsByTrial =[];
  for j = 1:length(unit2Ts1)
    if (unit2Ts1(j) > T0(i) && unit2Ts1(j) < T19(i))
      spkInTrial = [spkInTrial, j]; 
    end
  end
  spkInTrial = spkInTrial';
  for j = 1:length(spkInTrial)
      tsByTrial = [tsByTrial,unit2Ts1(spkInTrial(j))]; 
  end
  tsByTrial =tsByTrial';
  if ~isempty(tsByTrial)
  spkTrials2(i, 1:length(spkInTrial)) = tsByTrial - tsByTrial(1);
  end
end

%spkTrials3 
for i = 1:length(T0)
  spkInTrial = [];
  tsByTrial =[];
  for j = 1:length(unit3Ts1)
    if (unit3Ts1(j) > T0(i) && unit3Ts1(j) < T19(i))
      spkInTrial = [spkInTrial, j]; 
    end
  end
  spkInTrial = spkInTrial';
  for j = 1:length(spkInTrial)
      tsByTrial = [tsByTrial,unit3Ts1(spkInTrial(j))]; 
  end
  tsByTrial =tsByTrial';
  if ~isempty(tsByTrial)
  spkTrials3(i, 1:length(spkInTrial)) = tsByTrial - tsByTrial(1);
  end
end

%spkTrials4 
for i = 1:length(T0)
  spkInTrial = [];
  tsByTrial =[];
  for j = 1:length(unit4Ts1)
    if (unit4Ts1(j) > T0(i) && unit4Ts1(j) < T19(i))
      spkInTrial = [spkInTrial, j]; 
    end
  end
  spkInTrial = spkInTrial';
  for j = 1:length(spkInTrial)
      tsByTrial = [tsByTrial,unit4Ts1(spkInTrial(j))]; 
  end
  tsByTrial =tsByTrial';
  if ~isempty(tsByTrial)
  spkTrials4(i, 1:length(spkInTrial)) = tsByTrial - tsByTrial(1);
  end
end

%spkTrialsUnsorted 
for i = 1:length(T0)
  spkInTrial = [];
  tsByTrial =[];
  for j = 1:length(Tw)
    if (Tw(j) > T0(i) && Tw(j) < T19(i))
      spkInTrial = [spkInTrial, j]; 
    end
  end
  spkInTrial = spkInTrial';
  for j = 1:length(spkInTrial)
      tsByTrial = [tsByTrial,Tw(spkInTrial(j))]; 
  end
  tsByTrial =tsByTrial';
  if ~isempty(tsByTrial)
  spkTrialsU(i, 1:length(spkInTrial)) = tsByTrial - tsByTrial(1);
  end
end


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

%Plot tuing curves
% figure
% errorbar(FRMem1, SE1);
% figure
% errorbar(FRMem2, SE2);
% figure
% errorbar(FRMem3, SE3);
% figure
% errorbar(FRMem4, SE4);
% figure
% errorbar(FRMemU, SEU);

%Test using anova
% [p,tbl,stats1] = anova1(FRMem1,Data1.Hang, 'off');
% figure
% multcompare(stats1);
% [p,tbl,stats2] = anova1(FRMem2,Data1.Hang, 'off');
% figure
% multcompare(stats2);
% [p,tbl,stats3] = anova1(FRMem3,Data1.Hang, 'off');
% figure
% multcompare(stats3);
% [p,tbl,stats4] = anova1(FRMem4,Data1.Hang, 'off');
% figure
% multcompare(stats4);
% [p,tbl,statsu] = anova1(FRMemU,Data1.Hang, 'off');
% figure
% multcompare(statsu);

% x = [-20:.1:20];
% kernel = normpdf(x,0,20);
% figure
% plot(kernel);
