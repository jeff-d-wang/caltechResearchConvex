number_entries = 150;
number_objects = 56;

table1 = load('clean');
cleandata = table1.clean;
table2 = load('malicious');
maliciousdata = table2.malicious;
g = load('truth');
gt = g.groundtruth;


totaliters = 5;
overall = zeros(1, number_entries); 

for numberiters = 1:totaliters
    adjzeros = zeros(number_objects);

    performancezeros = zeros(1, number_entries); % one row

    sub150 = cleandata{1:150, (1:6)};  % change for different dataset.

    sub150 = sub150(randperm(size(sub150, 1)), :); 

    for iter = 1:150
        row = sub150(iter, :);

        adjzeros(row(1)+1, row(2)+1) = row(4);
        adjzeros(row(1)+1, row(3)+1) = row(5);
        adjzeros(row(2)+1, row(3)+1) = row(6);

        adjzeros(row(2)+1, row(1)+1) = row(4);
        adjzeros(row(3)+1, row(1)+1) = row(5);
        adjzeros(row(3)+1, row(2)+1) = row(6);

        %disp(iter)
        resultszero = spectralcluster(adjzeros, 2);
        indicatorzeros = (resultszero~=gt);
        performancezeros(iter) =  min(sum(indicatorzeros ), number_objects-sum(indicatorzeros ));
        overall(iter) = overall(iter)+ performancezeros(iter);
        G = graph(adjzeros);
    end
end

overallclean = overall/totaliters

number_entries1 = 180;
overall1 = zeros(1, number_entries1); 

for numberiters = 1:totaliters
    adjzeros1 = zeros(number_objects);

    performancezeros = zeros(1, number_entries1); % one row

    sub180 = maliciousdata{1:180, (1:6)};  % change for different dataset.

    sub180 = sub180(randperm(size(sub180, 1)), :); 

    for iter = 1:number_entries1
        row1 = sub180(iter, :);

        adjzeros1(row1(1)+1, row1(2)+1) = row1(4);
        adjzeros1(row1(1)+1, row1(3)+1) = row1(5);
        adjzeros1(row1(2)+1, row1(3)+1) = row1(6);

        adjzeros1(row1(2)+1, row1(1)+1) = row1(4);
        adjzeros1(row1(3)+1, row1(1)+1) = row1(5);
        adjzeros1(row1(3)+1, row1(2)+1) = row1(6);

        %disp(iter)
        resultszero1 = spectralcluster(adjzeros1, 2);
        indicatorzeros1 = (resultszero1~=gt);
        performancezeros1(iter) =  min(sum(indicatorzeros1 ), number_objects-sum(indicatorzeros1 ));
        overall1(iter) = overall1(iter)+ performancezeros1(iter);
        G1 = graph(adjzeros1);
    end
end

overallmalicious = overall1/totaliters
plot(overallclean)
hold
plot(overallmalicious)
title('number of errors vs. number of queries for Cat dataset')
xlabel('number of queries')
ylabel('number of errors')