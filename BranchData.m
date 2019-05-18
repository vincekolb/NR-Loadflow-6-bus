function branchd = BranchData
%% Branch data

%	fbus   tbus    r      x      b     rateA   rateB   rateC   ratio   angle   status
BranchData = [
    1       2     0.1    0.2    0.04    100      0       0       0       0       1;
    1       4     0.05   0.2    0.04    100      0       0       0       0       1;
    1       5     0.08   0.3    0.06    100      0       0       0       0       1;
    2       3     0.05   0.25   0.06     60      0       0       0       0       1;
    2       4     0.05   0.1    0.02     60      0       0       0       0       1;
    2       5     0.1    0.3    0.04     60      0       0       0       0       1;
    2       6     0.07   0.2    0.05     60      0       0       0       0       1;
    3       5     0.12   0.26   0.05     60      0       0       0       0       1;
    3       6     0.02   0.1    0.02     60      0       0       0       0       1;
    4       5     0.2    0.4    0.08     60      0       0       0       0       1;
    5       6     0.1    0.3    0.06     60      0       0       0       0       1;];

branchd = BranchData;

end

