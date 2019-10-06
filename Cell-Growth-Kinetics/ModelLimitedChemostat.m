%% Function file describing the model
function ydot = ModelLimitedChemostat(y,par)
 
% The ode-solver sends x, s and p in the vector y and wants
% back the derivatives dX/dt, dS/dt, dP/dt in the vector ydot
 
x = y(1);
s = y(2);
O = y(3);
p = y(4);


Sf = 100;
Dr = par.D;
  
% Calculate the derivatives and send back
% Put in your calculations here

%Growth model
Cos = par.omax; %g/L
Kso = Cos*0.01;
Kio = Kso;

rxR = par.umaxR*s/(par.KsR+s)*O/(Kso+O); % u respiratory
rxF = par.umaxF*s/(par.KsF+s)*1/(1+O/Kio); % u fermentative
rx = rxR+rxF;
rxRp = rxR/(rxR+rxF);
rxFp = rxF/(rxR+rxF);

%Calculate yields

YsxR = par.YsxR;
YsxF = par.YsxF;
Yse = par.Yse; % fermentation
Yso = (4-YsxR*4.2)/4;
Yxo = Yso/YsxR; %calculated from DRB. respiration
Yxp = Yse/YsxF;
Kla = 10*60;

%Mass balances

% Version not accounting for biomass concentration in outlet
dXRdt = rxR*x; % uses respirative rx
dXFdt = rxF*x; % uses fermentative rx
dXdt = dXRdt + dXFdt -Dr*x; % total biomass growth
dSdt = -(dXRdt/YsxR + dXFdt/YsxF) + Dr*(Sf-s); % combines biomass growth from respiration and fermentation
dOdt = -(Yxo*dXRdt)+Kla*(Cos-O) - Dr*O; % oxygen in g. uses rxR
dPdt = dXFdt*Yxp - Dr*p; % uses rxF
% send the derivatives back. 
 
ydot = [dXdt;dSdt;dOdt;dPdt];
