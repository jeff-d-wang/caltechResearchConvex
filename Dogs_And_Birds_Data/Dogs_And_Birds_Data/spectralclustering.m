structs = load('Birds5EdgeQuery300workers.mat');

observed = structs.CAdj;

rawAdj = structs.Adj;

% entrywise multiplication

Adj = observed .* rawAdj;
 
% for i = 1:473,
%     for j = i+1:473,
%         if rawAdj(i, j) == -1,
%             rawAdj(i, j) = ceil((rand - 2/3));
%             rawAdj(j, i) = rawAdj(i, j);
%         end;
%     end;
% end;
% 
% rawAdj

[V, D] = eig(Adj);

plot(diag(D), '*')

%2nd number is number of datapoints to that minus # of eigen values it finds
plot(V(:,300))
