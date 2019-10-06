%% Function file describing the model
function ydot = ModelAerobic(t,y,par)
 
% The ode-solver sends x, s and p in the vector y and wants
% back the derivatives dX/dt, dS/dt, dP/dt in the vector ydot
 
x = y(1);
s = y(2);
  
% Calculate the derivatives and send back
% Put in your calculations here

%Growth model
rx = par.umax*s/(par.Ks+s); % filled in

%Calculate yields

Ysx = par.Ysx;
Yxs = 1/Ysx;

%Mass balances 

dXdt = rx*x; % filled in
dSdt = -dXdt*Yxs; % filled in

% send the derivatives back. 
 
ydot = [dXdt;dSdt];
