function [] = LoadFlow(V,del)
Y = YBus;
busd = BusData;
branchd = BranchData;
Pl = busd(:,3);
Ql = busd(:,4);
fb = branchd(:,1);
tb = branchd(:,2);
nb = max(max(fb),max(tb));
nl = length(fb);
BMva = 100;
Vm = V.*cos(del) + 1i*V.*sin(del); %polar to rectangular
Del = 180/pi*del; % bus voltage angle in degree
Del = rem(Del,360); % limit angles to 360

Iij = zeros(nb,nb); 
Lij = zeros(nl,1);
Sij = zeros(nb,nb);
Si = zeros(nb,1);

% line current flows
for m = 1:nl
    p = fb(m); q = tb(m);
    Iij(p,q) = -(Vm(p) - Vm(q))*Y(p,q); % Y(m,n) = -y(m,n).
    Iij(q,p) = -Iij(p,q);
end

% line power flows
for m = 1:nb
    for n = 1:nb
        if m ~= n % ~= means not equal
            Sij(m,n) = Vm(m)*conj(Iij(m,n))*BMva;
        end
    end
end

% line losses
for m = 1:nl
    p = fb(m); q = tb(m);
    Lij(m) = Sij(p,q) + Sij(q,p);
end

% Bus Power Injections.
for i = 1:nb
    for k = 1:nb
        Si(i) = Si(i) + conj(Vm(i))*Vm(k)*Y(i,k)*BMva;
    end
end
Lpij = real(Lij);
Lqij = imag(Lij);
Pij = real(Sij);
Qij = imag(Sij);
Pi = real(Si);
Qi = -imag(Si);
Pg = Pi+Pl;
Qg = Qi+Ql;
%% Displaying the Results:
%    disp('-----------------------------------------------------------------------------------------');
%    disp('                                      Loadflow Analysis ');
%    disp('-----------------------------------------------------------------------------------------');
%    disp('| Bus |    V   |  Angle  |     Injection      |     Generation     |          Load      |');
%    disp('| No  |    pu  |  Degree |    MW   |   MVar   |    MW   |  Mvar    |     MW     |  MVar |');
%for m = 1:nb
%    disp('-----------------------------------------------------------------------------------------');
%    fprintf('%4g', m); fprintf('  %8.4f', V(m)); fprintf('   %8.4f', Del(m));
%    fprintf('  %8.3f', Pi(m)); fprintf('   %8.3f', Qi(m));
%    fprintf('  %8.3f', Pg(m)); fprintf('   %8.3f', Qg(m));
%    fprintf('  %8.3f', Pl(m)); fprintf('   %8.3f', Ql(m)); fprintf('\n');
%end
%    disp('-----------------------------------------------------------------------------------------');
%    fprintf(' Total                   ');fprintf('  %8.3f', sum(Pi)); fprintf('   %8.3f', sum(Qi));
%    fprintf('  %8.3f', sum(Pi+Pl)); fprintf('   %8.3f', sum(Qi+Ql));
%    fprintf('  %8.3f', sum(Pl)); fprintf('   %8.3f', sum(Ql)); fprintf('\n');
%    disp('-----------------------------------------------------------------------------------------');
%    disp('-----------------------------------------------------------------------------------------');
%    disp('                              Line FLow and Losses ');
%    disp('-----------------------------------------------------------------------------------------');
%    disp('| From | To  |    P    |    Q     |  From | To  |    P    |    Q     |     Line Loss    |');
%    disp('| Bus  | Bus |   MW    |   MVar   |  Bus  | Bus |    MW   |    MVar  |    MW   |  MVar  |');
%    
%for m = 1:nl
%    p = fb(m); q = tb(m);
%    disp('-----------------------------------------------------------------------------------------');
%    fprintf('%4g', p); fprintf('%7g', q); fprintf('  %8.3f', Pij(p,q)); fprintf('   %8.3f', Qij(p,q));
%    fprintf('   %4g', q); fprintf('%7g', p); fprintf('   %8.3f', Pij(q,p)); fprintf('   %8.3f', Qij(q,p));
%    fprintf('  %8.3f', Lpij(m)); fprintf(' %8.3f', Lqij(m));
%    fprintf('\n');
%end
%    disp('-----------------------------------------------------------------------------------------');
%    fprintf('   Total Loss                                                    ');
%    fprintf('     %8.3f', sum(Lpij)); fprintf('  %8.3f', sum(Lqij));  fprintf('\n');
%    disp('-----------------------------------------------------------------------------------------');
%    
%    
%% Writing the Results to the Excel File Results:    
    
%    Bus_No = [1;2;3;4;5;6];
%    Voltage = V;
%    Delta = Del;
%    PG = Pg;
%    QG = Qg;
    
%    T = table(Bus_No,Voltage,Delta,Pi,Qi,PG,QG);
%    writetable(T,'Results.xlsx');
        
end

