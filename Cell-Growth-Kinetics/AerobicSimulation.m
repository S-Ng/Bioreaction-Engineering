close all;
clear all;
%clc
% AEROBIC PROBLEM 1 
 

% Define parameters (such as yields and maximal growth rate)
% store all the parameters in the structure par. to be able to send them
% between the differnt functions
 
% Random values
par.umax = 0.5;
par.Ks = 0.1;
par.Ysx = 0.4;

 
%% simulation of Batch1 
% Integration time and start value for variables (volume, cellmass, substrate and product)
 
tint = [0 12];   % Time interval (h) [start stop]
x0 = 0.50;        % Cell conc in the reactor at time zero (g/L) 
s0 = 98.010;        % Substrate conc in the reactor at time zero (g/L)
 
% y0 is a vector with all the start values for the variables you want to follow as function of time
 
y0 = [x0 s0];
 
% Call the ODE-solver and get results, “Model” is your m-file with the differential equations, the structure par contains all the parameters that you defined earlier
% t1 is a vector containing the time, and y1 is a matrix with all the variables 
 
[t,y] = ode15s(@ModelAerobic,tint,y0,[],par);
 
x = y(:,1);
s = y(:,2);

% Plot simulated and experimental data
load('ExpData.mat');

figure 
hold on
plot(t,x,'b-',t,s,'r--')
plot(aerobic.time, aerobic.X, 'bo', aerobic.time, aerobic.S, 'ro')
tit = ['Aerobic Growth: umax=', num2str(par.umax), ' Ks=', num2str(par.Ks), ' Ysx=', num2str(par.Ysx)];
title(tit)
xlabel('Time (h)')
ylabel('Conc (g/L)')
legend('X_sim','S_sim', 'X_exp', 'S_exp')
hold off
figtit = ['Assignment2.1_AerobicGrowth_umax=', num2str(par.umax), '_Ks=', num2str(par.Ks), '_Ysx=', num2str(par.Ysx), '.fig'];
savefig(figtit);
