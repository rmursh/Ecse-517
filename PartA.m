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

edg=prctile(score(:,1:2),[0.1,99.9]);
De=min(diff(edg))/30;
e1{1}=[edg(1,1):De:edg(2,1)];
e1{2}=[edg(1,2):De:edg(2,2)];
hst=hist3(score(:,1:2),e1);
Shand=pcolor(e1{1},e1{2},hst');
set(Shand,'LineStyle','none');
