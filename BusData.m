function busd = BusData
%% Bus data

%  Type: 3 = slack/swing/root-bus
%            (voltage angle [V_a] & voltage magnitude [V_m] given)
%  Type: 2 = generator bus aka PV-bus
%            (real power [P] & generator bus voltage [Q] given)
%  Type: 1 = load bus aka PQ-bus
%            (real [P] & reactive [Q] power given)

%   bus_i  type  P_l   Q_l  G_s  B_s  area  V_m  V_a  baseKV  zone   V_max   V_min
BusData = [
     1      3     0     0    0    0     1    1    0    230      1    1.07    0.95;
     2      2     0     0    0    0     1    1    0    230      1    1.07    0.95;
     3      2     0     0    0    0     1    1    0    230      1    1.07    0.95;
     4      1    100   15    0    0     1    1    0    230      1    1.07    0.95;
     5      1    100   15    0    0     1    1    0    230      1    1.07    0.95;
     6      1    100   15    0    0     1    1    0    230      1    1.07    0.95;];
 
 busd = BusData;
end

