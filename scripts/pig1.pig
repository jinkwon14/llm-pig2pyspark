-- Load the data from a CSV file
transactions = LOAD 'data/sample1.csv' USING PigStorage(',') 
    AS (depStore:chararray, date:chararray, amount:int);

-- Filter transactions to include only those where the amount is greater than 200
high_value_transactions = FILTER transactions BY amount > 200;

-- Group the transactions by store
grouped_by_store = GROUP high_value_transactions BY depStore;

-- Calculate total and average sales per depStore
sales_summary = FOREACH grouped_by_store GENERATE 
    group AS depStore,
    SUM(high_value_transactions.amount) AS total_sales,
    AVG(high_value_transactions.amount) AS average_sales;

-- Store the summary in a CSV file
STORE sales_summary INTO 'output/sales_summary' USING PigStorage(',');

-- Optional: Just for demonstration, store filtered data to another directory
STORE high_value_transactions INTO 'output/high_value_transactions' USING PigStorage(',');
