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

sparseError = rawAdj;

for i = 1:473,
    for j = 1:473,
        if sparseError(i, j) ~= -1
            sparseError(i, j) = 0;
        end;
    end;
end;

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

surf(M)

%our goal --> minimize the addition of the rank of the matrix and # of
%non-zero entires in the matrix

nuclearNorm = norm(eig(Adj), 1); %finds low rank matrices, generally trusted
%nuclearNorm = norm(svd(Adj), 1);

x = Adj(:);

% Generating random sampling points
T = randperm(numel(Adj));
IDX = T(1:round(0.4*numel(Adj))); % 40% sampling

M = opRestriction(numel(Adj), IDX); % Creating operator for selecting entries at the chosen random locations

y = M(x, 1); % Sampled data

XRec = IST_MC(y,M,sizeX); % Regularized Iterated Soft Thresholding
result = norm(X-XRec,'fro')/norm(X,'fro'); % Normalized Mean Squared Error
result

%we want a low-ranked matrix
cvx_begin
    minimize(nuclearNorm + norm(sparseError, 1))
    subject to
        
cvx_end

%vStack = vertcat(v1, v2, v3);
%each node is its corresponding row of the new matrix --> rows form feature
%vectors of them???