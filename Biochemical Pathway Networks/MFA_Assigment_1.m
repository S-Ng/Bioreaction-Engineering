% MFA Homework
% KETN30, Dr. Gunnar Liden
%2019 09 30

clear all;
clc;
% Measured: glucose, citrate, isocitrate, protein, carbohydrate, CO2
% Steady state: Glucose-6-P, Pyruvate, AcCoA, GOX, OGT, SUC, MAL, OAA
% Unknown: Lipid NH4
%{
1  Lipid
2  NH4
3  Glucose
4  CIT
5  ICIT
6  Pro
7  Carb
8  CO2
9  G6P
10 Pyr
11 AcCoA
12 GOX
13 OGT
14 SUC
15 MAL
16 OAA
%}
%       [1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16]
omega = [0   0   -1  0   0   0   0   0   1   0   0   0   0   0   0   0   ;%1
    0   0   0   0   0   0   0   0   -1  1   0   0   0   0   0   0   ;%2
    0   0   0   0   0   0   0   1/3 0   -1  2/3 0   0   0   0   0   ;%3
    0   0   0   0   0   0   0  -1/4 0  -3/4  0   0   0   0   0  1   ;%4
    0   0   0   3   0   0   0   0   0   0   -1  0   0   0   0   -2  ;%5
    0   0   0   -1  1   0   0   0   0   0   0   0   0   0   0   0   ;%6
    0   0   0   0   -1  0   0   1/6 0   0   0   0   5/6 0   0   0   ;%7
    0   0   0   0   0   0   0   1/5 0   0   0   0   -1  4/5 0   0   ;%8
    0   0   0   0   0   0   0   0   0   0   0   0   0   -1  1   0   ;%9
    0   0   0   0   0   0   0   0   0   0   0   0   0   0   -1  1   ;%10
    0   0   0   0   -1  0   0   0   0   0   0   1/3 0   2/3 0   0   ;%11
    0   0   0   0   0   0   0   0   0   0   -1  -1  0   0   2   0   ;%12
    0   0   0   0   0   0   1   0   -1  0   0   0   0   0   0   0   ;%13
    1   0   0   0   0   0   0   0   0   0   -1  0   0   0   0   0   ;%14
    0   -1  0   0   0   1   0   0   0   0   0   0   -1  0   0   0   ;%15
    ];

% Remove row 11 or 4 (per problem statement) and columns 1 and 2 because they
% are unmeasured and not steady state (i.e. unknown)
number = 1; % to allow flux storage in 3D matrix
for removed_rxn = [11, 4] % for each reaction to be removed
    T2 = [omega(1:removed_rxn-1 , 3:16) ; omega(removed_rxn+1:15 , 3:16)]; %reduce matrix to T2 matrix
    
    if rank(T2) ~= 14 % check rank of matrix to confirm invertability
        fprintf("Rank isn't 14\n"); return;
    end
    
    T2_tInv = inv(T2'); % transpose and invert matrix
    
    % Build r-vector
    r_tot = [xlsread('MFA_Rates_Yields.xlsx', 'Rates', 'B2:E7') ; zeros(8, 4)]; % import rates calculated in excel and add steady state zeros
    
    % Get fluxes
    Xg_L = load('MFA_Xg_L'); % load biomass concentrations
    for i = 1:4 % calculate fluxes for each dilution rate
        flux(:, i, number) = (T2_tInv*r_tot(:,i))./Xg_L.Xg_L(i); % (T2*r)/[X]
    end
    number = number+1; % move storage location for fluxes with different reaction removed
end
