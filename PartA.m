%Plot the initial Waveforms
figure;
Waves = Data1.Waves;
plot(Waves(1:100:end,:)');
grid on;
title('Plot of every 100th Original Waveforms');

%Find the mode of the minimum of all waves
sizeOfData = size(Waves, 1);
minimumOfWave = zeros(sizeOfData,1);
for i = 1:sizeOfData
    [minVal, minIdx] = min(Waves(i,:));
    minimumOfWave(i) = minIdx;
end
modeOfMin = mode(minimumOfWave);

%Shift waves backward or forward in time so align them to have the same
%minimum
Awaves = Waves;
for i = 1:sizeOfData
    B = abs(minimumOfWave(i)-modeOfMin); 
    if(B > 3)
        B = 3;
    end
    if(minimumOfWave(i) > modeOfMin)
        Awaves(i,:) = circshift(Awaves(i,:),[0 -B]);
    end
    if(minimumOfWave(i) < modeOfMin)
        J = B;
        Awaves(i,:) = circshift(Awaves(i,:),[0 B]);
    end
end

figure;
plot(Awaves(1:100:end,:)');
grid on;
title('Plot of every 100th Aligned Waveforms');

[coeff,score,latent,tsquared,explained,mu] = pca(Awaves);
figure
par = pareto(explained);
title('Cumulative Variance for Each PC');

figure
edg=prctile(score(:,1:2),[0.1,99.9]);
De=min(diff(edg))/30;
e1{1}=[edg(1,1):De:edg(2,1)];
e1{2}=[edg(1,2):De:edg(2,2)];
hst=hist3(score(:,1:2),e1);
Shand=pcolor(e1{1},e1{2},hst');
set(Shand,'LineStyle','none');

rng default  % For reproducibility


[clusteridxWave] = kmeans(Awaves, 4);
% 
figure
[silh3,h] = silhouette(Awaves,clusteridxWave);
h = gca;
h.Children.EdgeColor = [.8 .8 1];
xlabel 'Silhouette Value'
ylabel 'Cluster'

Tw = Data1.Tw;
T0 = Data1.T0;
T19 = Data1.T19;
[clusteridxSpike] = kmeans(Tw, 4);
figure
[silh4,q] = silhouette(Tw,clusteridxSpike);
h = gca;
h.Children.EdgeColor = [.8 .8 1];
xlabel 'Silhouette Value'
ylabel 'Cluster'

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
  for j = 1:length(unit3Ts1)
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



