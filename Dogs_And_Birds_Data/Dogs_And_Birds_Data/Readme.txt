Each file has 6 variables

Adj: Adjacency matrix with 0 = no edge, 1 = edge, -1 = not observed.
AdjWithMultiples: Adj with a few entries observed more than once (which happens with random queries).
CAdj: Matrix which shows which entries are observed. 0 = not observed. 1 = Observed.
count: Total number of unique edges observed (without counting multiples).
groundtruth: true clusters
m: total number of nodes in the graph

Unweighted adjacency matrix that zeros out all unobserved entries can be obtained by entry wise multiplying variable Adj with CAdj.
