%% Function file describing the model
function ydot = ModelO2Limited(t,y,par)
 
% The ode-solver sends x, s and p in the vector y and wants
% back the derivatives dX/dt, dS/dt, dP/dt in the vector ydot
 
x = y(1);
s = y(2);
p = y(3);
O = y(4);
  
% Calculate the derivatives and send back
% Put in your calculations here

%Growth model
Cos = 1.16*0.21/1000; %mol/L
Kso = Cos*0.01;
Kio = Kso;

rxR = par.umaxR*s/(par.KsR+s)*O/(Kso+O); % u respiratory
rxF = par.umaxF*s/(par.KsF+s)*1/(1+O/Kio); % u fermentative

%Calculate yields

YsxR = par.YsxR;
YsxF = par.YsxF;
Yse = par.Yse; % fermentation
Yso = (4-YsxR*4.2)/4; %calculated from DRB. respiration

%Mass balances

dXRdt = rxR*x; % uses respirative rx
dXFdt = rxF*x; % uses fermentative rx
dXdt = dXRdt + dXFdt; % total biomass growth
dSdt = -(dXRdt/YsxR+dXFdt/YsxF); % combines biomass growth from respiration and fermentation
dOdt = -(Yso/YsxR*rxR*x)+(600*(Cos-O)*32); % oxygen in mole. uses rxR
dPdt = (rxF*x/YsxF)*Yse; % uses rxF

% send the derivatives back. 
 
ydot = [dXdt;dSdt;dPdt;dOdt];
