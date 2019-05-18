function gend = GenData
%% Generator data

%   bus    P_g   Q_g   Q_max  Q_min  V_g   MVABase  status  P_max  P_min
GenData = [
     1     110    0     150   -100   1.07   100       1      200    50;
     2      50    0     150   -100   1.05   100       1      150    37.5;
     3      50    0     120   -100   1.05   100       1      180    45;
     4       0    0       0      0     0    100       1        0     0;
     5       0    0       0      0     0    100       1        0     0;
     6       0    0       0      0     0    100       1        0     0;];
 
 gend = GenData
end

