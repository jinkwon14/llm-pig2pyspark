-- Load the data from the CSV file
A = LOAD 'data.csv' USING PigStorage(',') AS (store:chararray, date:chararray, amount:int);

-- Filter out transactions with amount < 200
B = FILTER A BY amount >= 200;

-- Group by store
C = GROUP B BY store;

-- Calculate total sales per store
D = FOREACH C GENERATE group AS store, SUM(B.amount) AS total_sales;

-- Store the output in a file
STORE D INTO 'output' USING PigStorage(',');