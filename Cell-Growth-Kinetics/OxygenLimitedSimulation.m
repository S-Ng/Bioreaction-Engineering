close all;
clear all;
%clc
% OXYGEN LIMITED PROBLEM 3
 
% Define parameters (such as yields and maximal growth rate)
% store all the parameters in the structure par. to be able to send them
% between the differnt functions
 
% Random values
par.umaxR = 0.5;
par.umaxF = 0.4;
par.KsR = 0.1;
par.KsF = 0.1;
par.YsxR = 0.4;
par.YsxF = 0.2;
par.Yse = 0.5;
 
%% simulation of Batch1 
% Integration time and start value for variables (volume, cellmass, substrate and product)
 
tint = [0 12];   % Time interval (h) [start stop]
x0 = 0.50;        % Cell conc in the reactor at time zero (g/L) 
s0 = 100;        % Substrate conc in the reactor at time zero (g/L)
p0 = 0;        % product conc in the reactor at time zero (g/L)
Oo = 1.16*0.21/1000;  % oxygen conc in the reactor at time zero (mol/L)
 
% y0 is a vector with all the start values for the variables you want to follow as function of time
 
y0 = [x0 s0 p0 Oo];
 
% Call the ODE-solver and get results, “Model” is your m-file with the differential equations, the structure par contains all the parameters that you defined earlier
% t1 is a vector containing the time, and y1 is a matrix with all the variables 
 
[t,y] = ode15s(@ModelO2Limited,tint,y0,[],par);
 
x = y(:,1);
s = y(:,2);
p = y(:,3);
O = y(:,4);

% Plot simulated and experimental data
load('ExpData.mat');

figure 
hold on
plot(t,x,'b-',t,s,'r--', t,p,'k-.') %, t,O*10^5,'m.')
%plot(anaerobic.time, anaerobic.X, 'bo', anaerobic.time, anaerobic.S, 'ro', anaerobic.time, anaerobic.P, 'ko');
tit = ['O2 Limited Growth: umaxR=', num2str(par.umaxR), ' KsR=', num2str(par.KsR), ' YsxR=', num2str(par.YsxR), ' Yse=', num2str(par.Yse), ' umaxF=', num2str(par.umaxF), ' KsF=', num2str(par.KsF), ' YsxF=', num2str(par.YsxF)];
title(tit);
xlabel('Time (h)')
ylabel('Conc (g/L)')
legend('X','S', 'P', 'O')
hold off
figtit = ['Assignment2.3_O2LimitedGrowth_umaxR=', num2str(par.umaxR), ' KsR=', num2str(par.KsR), ' YsxR=', num2str(par.YsxR), ' Yse=', num2str(par.Yse), ' umaxF=', num2str(par.umaxF), ' KsF=', num2str(par.KsF), ' YsxF=', num2str(par.YsxF), '.fig'];
savefig(figtit);

figure 
plot(t,O)
title('Oxygen concentration')
xlabel('Time (h)')
ylabel('Conc (g/L)')
figtit2 = ['Assignment2.3_O2_umaxR=', num2str(par.umaxR), ' KsR=', num2str(par.KsR), ' YsxR=', num2str(par.YsxR), ' Yse=', num2str(par.Yse), ' umaxF=', num2str(par.umaxF), ' KsF=', num2str(par.KsF), ' YsxF=', num2str(par.YsxF), '.fig'];
savefig(figtit2);
