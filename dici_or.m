function S = dici_or(Z, S_0, g)
%One step of the DICI-OR algorithm.
%L hardcoded to 1
L = 1;
dim = size(S_0,1);

%Collapse step to compute values replacing off-limit elements of S_0
%Only works for L=1
start_j = L+2;
while start_j<=dim
    i=1;
    j=start_j;
    while i<=dim && j<=dim
        S_0(i,j) = S_0(i,j-1)*S_0(i+1,j)/S_0(i+1,j-1);
        S_0(j,i) = S_0(i,j);
        i = i+1;
        j = j+1;
    end
    start_j = start_j + 1;
end

%Iterate step to calculate one time step forward
M = diag(diag(Z));
M_inv = diag(1./diag(Z));
P = (1 - g)*eye(dim) + gamma*M_inv*(M - Z);
S = zeros(size(Z));
for i = 1:dim
    for j = 1:dim
        if abs(i-j) <= L
            if i == j
                S(i,j) = P(i,:)*S_0(:,j) + gamma/M(i,i);
            else
                S(i,j) = P(i,:)*S_0(:,j);
            end
        end
    end
end