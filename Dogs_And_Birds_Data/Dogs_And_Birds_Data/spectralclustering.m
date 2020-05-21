structs = load('Dogs3TriangleQuery320workers.mat');

observed = structs.CAdj;

rawAdj = structs.Adj;

% entrywise multiplication

Adj = observed .* rawAdj;

% for i = 1:473,
%     for j = i+1:473,
%         if rawAdj(i, j) == -1
%             rawAdj(i, j) = ceil((rand - 0.9));
%             rawAdj(j, i) = rawAdj(i, j);
%         end;
%         if rawAdj(i, j) == 1
%             rawAdj(i, j) = ceil((rand - 0.3));
%             rawAdj(j, i) = rawAdj(i, j);
%         end;
%     end;
% end;

% rawAdj

[V, D] = eig(Adj);

%plot(diag(D), '*')
%return

%2nd number is number of datapoints to that minus # of eigen values it finds
%plot(V(:,472))

%find laplacian --> normalize the adj. matrix? i don't know

% find eigenvalues + eigenvectors

%find laplacian so that L * eigenvalues = eigenvalues * eigenvectors??
%for k clusters compute first k eigen vectors k= # clusters
v1 = V(:,473);
v2 = V(:,472);
v3 = V(:,471);

% v1 = V(:, 342);
% v2 = V(:, 341);
% v3 = V(:, 340);
% v4 = V(:, 339);
% v5 = V(:, 338);
% v6 = V(:, 337);

%subplot(3, 1, 1);
%plot(v1);
%subplot(3, 1, 2);
%plot(v2);
%subplot(3, 1, 3);
%plot(v3);

%stack them horizontally
M = [v1 v2 v3];
c = kmeans(M, 3);

% M = [v1 v2 v3 v4 v5 v6];
% c = kmeans(M, 6);

%plot(c, '*');

%surf(M)

%our goal --> minimize the addition of the rank of the matrix and # of
%non-zero entires in the matrix

L = zeros(size(Adj));

c1 = 172;
c2 = 323;
c3 = 473;

for i = 1:473
    for j = 1:473
        if i <= c1 && j <= c1
            L(i, j) = 1;
        elseif (c1 < i && i <= c2) && (c1 < j && j <= c2)
            L(i, j) = 1;
        elseif (c2 < i && i <= c3) && (c2 < j && j <= c3)
            L(i, j) = 1;
        end
    end
end

%nuclearNorm = norm(svd(Adj), 1);

regParam = 1;

% Do trace of L matrix to get nuclear norm
% We want a low-ranked matrix
% Get L hat and do spectral clustering on it

n = size(Adj);

cvx_begin
    variable x(n) symmetric;
    minimize(trace(x) + regParam * sum(sum(abs(Adj - x))))
    subject to
          x == semidefinite(n);
%         issymmetric(x) == 1
%         x >= 0
cvx_end

imagesc(x)

[V, D] = eig(lHat);
v1Opt = V(:,473);
v2Opt = V(:,472);
v3Opt = V(:,471);

MOpt = [v1Opt v2Opt v3Opt];
cOpt = kmeans(MOpt, 3);

% plot(cOpt, '*');

%vStack = vertcat(v1, v2, v3);
%each node is its corresponding row of the new matrix --> rows form feature
%vectors of them???