structs = load('Dogs3TriangleQuery320workers.mat');

observed = structs.CAdj;

rawAdj = structs.Adj;

% entrywise multiplication

Adj = observed .* rawAdj;

noloops = Adj - eye(length(Adj));

G = graph(noloops);

L = laplacian(G);

idx = spectralcluster(L, 3);

groundTruth = structs.groundtruth;

C = confusionmat(groundTruth, idx);

confusionchart(C);