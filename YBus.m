
function Y = YBus
branchd = BranchData;
fb = branchd(:,1);
tb = branchd(:,2);
r = branchd(:,3);
x = branchd(:,4);
b = branchd(:,5); % Homework Data uses b. Other Code uses B/2
a = branchd(:,6); % Homework a = 100 or a = 60. Other Code uses a=1
z = r + 1i*x;
y = 1./z; % inverse of z
b = i*b; % make b imaginary
nb = max(max(fb),max(tb)); % number of buses
nl = length(fb); % number of branches
Y = zeros(nb,nb);
 
%% elements of off-diagonal
 for k = 1:nl
     Y(fb(k),tb(k)) = Y(fb(k),tb(k)) - y(k)/a(k);
     Y(tb(k),fb(k)) = Y(fb(k),tb(k));
 end
 
%% elements of diagonal - USE THIS ONE OR THE ONE BELOW?
 for m = 1:nb
     for n = 1:nl
         if fb(n) == m
             Y(m,m) = Y(m,m) + y(n)/(a(n)^2) + b(n);
         elseif tb(n) == m
             Y(m,m) = Y(m,m) + y(n) + b(n);
         end
    end
 end
 
%% or [ (ys) = y/a, Y1 = y*(1-a)/(a^2), Y2 = y*(a-1)/a ]
%  for m = 1:nb
%    for n = 1:nl
%        if fb(n) == m
%            Y(m,m) = Y(m,m) + y(n)/a(n) + y(n)*((1-a(n))/(a(n)^2)) + b(n);
%        elseif tb(n) == m
%            Y(m,m) = Y(m,m) + y(n)/a(n) + y(n)*((a(n)-1)/a(n)) + b(n);
%        end
%    end
% end
 
 
end