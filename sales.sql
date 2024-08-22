/*create database*/
CREATE DATABASE yuma;
USE yuma;

/*Create table sales transaction*/
CREATE TABLE sales_transactions (
    TransactionID INT,
    CustomerID INT,
    TransactionDate TIMESTAMP,
    ProductID INT,
    ProductCategory VARCHAR(25),
    Quantity INT,
    PricePerUnit DECIMAL(10, 2),
    TotalAmount DECIMAL(10, 2),
    TrustPointsUsed INT,
    PaymentMethod VARCHAR(25),
    DiscountApplied DECIMAL(10, 2)
);

/*show the path where dataset has to be stored*/
SHOW VARIABLES LIKE 'secure_file_priv';

/*load the dataset*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_transactions.csv'
INTO TABLE sales_transactions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM sales_transactions LIMIT 5;

/*Information about the data*/
SELECT column_name, data_type FROM information_schema.columns 
WHERE table_name = 'sales_transactions';

/*Validation Query Example: Ensure no negative values*/
SELECT * FROM sales_transactions
WHERE Quantity < 0 OR TotalAmount < 0 OR TrustPointsUsed < 0;

SELECT 
    AVG(Quantity) AS mean, 
    STDDEV(Quantity) AS std, 
    MIN(Quantity) AS min, 
    MAX(Quantity) AS max
FROM sales_transactions;

SELECT 
    AVG(PricePerUnit) AS mean, 
    STDDEV(PricePerUnit) AS std, 
    MIN(PricePerUnit) AS min, 
    MAX(PricePerUnit) AS max
FROM sales_transactions;

SELECT 
    AVG(DiscountApplied) AS mean, 
    STDDEV(DiscountApplied) AS std, 
    MIN(DiscountApplied) AS min, 
    MAX(DiscountApplied) AS max
FROM sales_transactions;

/*Aggregation Queries*/
SELECT SUM(Quantity) as TotalQuantitySold,
       SUM(TotalAmount) as TotalSalesRevenue,
       AVG(PricePerUnit) as AvgPricePerUnit,
       SUM(DiscountApplied) as TotalDiscounts,
       SUM(TrustPointsUsed) as TotalTrustPointsUsed
FROM sales_transactions;

Select ProductCategory, TotalAmount from sales_transactions where CustomerID=1001;

Select CustomerID, sum(DiscountApplied) from sales_transactions group by CustomerID;

Select CustomerID, sum(TotalAmount) from sales_transactions group by CustomerID;