% structs = load('Birds5TriangleQuery285workers.mat');
% 
% observed = structs.CAdj;
% % 
% % rawAdj = structs.Adj;
% 
% % entrywise multiplication
% 
% Adj = observed .* rawAdj;

structs = load('strawberry.mat');

Adj = structs.adjzeros;

n = size(Adj);
regParam = 1; % lambda >= 0

cvx_begin
    variable x(n) symmetric;
    minimize(trace(x) + regParam * sum(sum(abs(Adj - x))))
    subject to
          x == semidefinite(n);
%         issymmetric(x) == 1
%         x >= 0
cvx_end

imagesc(x)

[V, D] = eig(x);
v1Opt = V(:,30);
v2Opt = V(:,29);

% v1Opt = V(:,342);
% v2Opt = V(:,341);
% v1Opt = V(:,340);
% v2Opt = V(:,339);
% v1Opt = V(:,338);
% 
% MOpt = [v1Opt v2Opt v3Opt v4Opt v5Opt v6Opt];
MOpt = [v1Opt v2Opt];
cOpt = kmeans(MOpt, 2);
% 
% plot(cOpt, '*');
