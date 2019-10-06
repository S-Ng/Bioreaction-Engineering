close all
clear
clc;
 
% Define parameters (such as yields and maximal growth rate)
% store all the parameters in the structure par. to be able to send them
% between the differnt functions
 
par.umaxR = 0.5;
par.umaxF = 0.4;
par.KsR = 0.1;
par.KsF = 0.1;
par.YsxR = 0.4;
par.YsxF = 0.2;
par.Yse = 0.5;
par.omax = 1.16*0.21/1000*32; %g/L

%% simulation
 
%Initial guesses-

x0 = 100;      
s0 = 3; 
o0 = 0.001; %g/L 0.0078g/L saturated
e0 = 30;

y0 = [x0 s0 o0 e0];
 
%Dilution rate span
D = 0.01:0.01:0.6;

% Solver configurations
options = optimset('Display','off');
lb = [0.1 0 0 0];
ub = [100 100 100 100];

%Simulate model at varying D
for i = 1:length(D)
    par.D = D(i);
    y = lsqnonlin(@ModelLimitedChemostat,y0,lb,ub,[],par);
    x(i) = y(1);
    s(i) = y(2);
    o(i) = y(3);
    e(i) = y(4);
end
 
% Plot simulated and experimental data
figure 
plot(D,[x;s;o./par.omax*100;e])
title('Chemostat')
xlabel('D (h^{-1})')
ylabel('Conc (g/L), DO (%)')
legend('X','S','O','E','location','north')

 
