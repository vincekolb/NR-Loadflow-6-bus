
nbus = 6;
Y = YBus;
busd = BusData;
gend = GenData;
BMva = 100;
bus = busd(:,1);
type = busd(:,2); % bustype: 3 = Swing, 2 = Genbus = PV, 1 = Loadbus = PQ
V = busd(:,8);
del = busd(:,9);
Pg = gend(:,2)/BMva;
Qg = gend(:,3)/BMva;
Pl = busd(:,3)/BMva;
Ql = busd(:,4)/BMva;
Qmin = gend(:,5)/BMva;
Qmax = gend(:,4)/BMva;
P = Pg - Pl;
Q = Qg - Ql;
Psp = P; % P specified
Qsp = Q; % Q specified
G = real(Y); %conductance matrix
B = imag(Y); %susceptance matrix
pv = find(type == 2 | type == 3); % pv buses
pq = find(type == 1); % pq buses
npv = length(pv); % number pv buses
npq = length(pq); % number pq buses
Tol = 1;  
Iter = 1;

while (Tol > 0.0001)
    
    P = zeros(nbus,1);
    Q = zeros(nbus,1);
    
    for i = 1:nbus
        for k = 1:nbus
            P(i) = P(i) + V(i)*V(k)*(G(i,k)*cos(del(i)-del(k)) + B(i,k)*sin(del(i)-del(k)));
            Q(i) = Q(i) + V(i)*V(k)*(G(i,k)*sin(del(i)-del(k)) - B(i,k)*cos(del(i)-del(k)));
        end
    end
    % checking Q-limit violations
    if Iter <= 3                     % only check for 3 iterations
        for n = 2:nbus
            if type(n) == 2 % type 2 = genbus or pvbus
                QG = Q(n)+Ql(n);
                if QG < Qmin(n)
                    V(n) = V(n) + 0.01;
                elseif QG > Qmax(n)
                    V(n) = V(n) - 0.01;
                end
            end
         end
    end
    
    % change from specified value
    dPa = Psp-P;
    dQa = Qsp-Q;
    k = 1;
    dQ = zeros(npq,1);
    
    for i = 1:nbus
        if type(i) == 1
            dQ(k,1) = dQa(i);
            k = k+1;
        end
    end
    
    dP = dPa(2:nbus);
    M = [dP; dQ]; % mismatch vector
    
    J = Jacobian(nbus,npq,pq,V,G,B,del); % load jacobian
       
    X = J\M;                             % Correction Vector.
    dTh = X(1:nbus-1);                   % Change in Voltage Angle.
    dV = X(nbus:end);                    % Change in Voltage Magnitude.
    
    % Updating State Vectors.
    del(2:nbus) = dTh + del(2:nbus);     % updated voltage angle
    
    k = 1;
    for i = 2:nbus
        if type(i) == 1
            V(i) = dV(k) + V(i);         % updated voltage magnitude 
            k = k+1;
        end
    end
    
    Iter = Iter + 1;
    Tol = max(abs(M));                   % Tolerance
    
end
LoadFlow(V,del);                         % Calling Loadflow.m