use leetcode;

## Problem 1757
Create table If Not Exists Products (product_id int, low_fats ENUM('Y', 'N'), recyclable ENUM('Y','N'));
insert into Products (product_id, low_fats, recyclable) values ('0', 'Y', 'N');
insert into Products (product_id, low_fats, recyclable) values ('1', 'Y', 'Y');
insert into Products (product_id, low_fats, recyclable) values ('2', 'N', 'Y');
insert into Products (product_id, low_fats, recyclable) values ('3', 'Y', 'Y');
insert into Products (product_id, low_fats, recyclable) values ('4', 'N', 'N');

select product_id from Products
where low_fats='Y' and recyclable='Y';

## Problem 2356
Create table If Not Exists Teacher (teacher_id int, subject_id int, dept_id int);
insert into Teacher (teacher_id, subject_id, dept_id) values ('1', '2', '3');
insert into Teacher (teacher_id, subject_id, dept_id) values ('1', '2', '4');
insert into Teacher (teacher_id, subject_id, dept_id) values ('1', '3', '3');
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '1', '1');
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '2', '1');
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '3', '1');
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '4', '1');

select teacher_id, count(distinct subject_id) as cnt from Teacher
group by teacher_id;

## Problem 1741
Create table If Not Exists Employees(emp_id int, event_day date, in_time int, out_time int);
insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '4', '32');
insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '55', '200');
insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-12-3', '1', '42');
insert into Employees (emp_id, event_day, in_time, out_time) values ('2', '2020-11-28', '3', '33');
insert into Employees (emp_id, event_day, in_time, out_time) values ('2', '2020-12-9', '47', '74');

select event_day as day, emp_id, sum(out_time-in_time) as total_time from Employees
group by emp_id, event_day;

## Problem 1693
Create table If Not Exists DailySales(date_id date, make_name varchar(20), lead_id int, partner_id int);
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'toyota', '0', '1');
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'toyota', '1', '0');
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'toyota', '1', '2');
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'toyota', '0', '2');
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'toyota', '0', '1');
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'honda', '1', '2');
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'honda', '2', '1');
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'honda', '0', '1');
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'honda', '1', '2');
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'honda', '2', '1');

select date_id, make_name, count(distinct lead_id) as unique_leads, count(distinct partner_id) as unique_partners from DailySales
group by date_id, make_name;

## Problem 1393
Create Table If Not Exists Stocks (stock_name varchar(15), operation ENUM('Sell', 'Buy'), operation_day int, price int);
insert into Stocks (stock_name, operation, operation_day, price) values ('Leetcode', 'Buy', '1', '1000');
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Buy', '2', '10');
insert into Stocks (stock_name, operation, operation_day, price) values ('Leetcode', 'Sell', '5', '9000');
insert into Stocks (stock_name, operation, operation_day, price) values ('Handbags', 'Buy', '17', '30000');
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Sell', '3', '1010');
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Buy', '4', '1000');
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Sell', '5', '500');
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Buy', '6', '1000');
insert into Stocks (stock_name, operation, operation_day, price) values ('Handbags', 'Sell', '29', '7000');
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Sell', '10', '10000');

select s.stock_name, s.sell_total-sum(price) as capital_gain_loss from Stocks as b
	inner join (
		select stock_name, sum(price) as sell_total from Stocks
		where operation='Sell'
		group by stock_name, operation
    ) as s on b.stock_name = s.stock_name
where operation='Buy'
group by stock_name, operation;

select stock_name, 
	sum(
		case when operation = 'Buy' then
			-price
		else
			price
		end
	) as capital_gain_loss
from Stocks
group by stock_name;

select stock_name,SUM(CASE WHEN operation = 'Sell' then price ELSE -price END) as capital_gain_loss from Stocks 
group by stock_name;

## Problem 1795
DROP TABLE IF EXISTS Products;
Create table If Not Exists Products (product_id int, store1 varchar(10), store2 varchar(10), store3 varchar(10));
insert into Products (product_id, store1, store2, store3) values ('0', '95', '100', '105');
insert into Products (product_id, store1, store2, store3) values ('1', '70', 'None', '80');

SELECT * FROM (
	SELECT p.product_id, "store1" as store, p.store1 as price FROM Products as p
	UNION ALL
	SELECT p.product_id, "store2" as store, p.store2 as price FROM Products as p
	UNION ALL
	SELECT p.product_id, "store3" as store, p.store3 as price FROM Products as p
) as r
WHERE r.price != 'None';

SELECT p.product_id, "store1" as store, p.store1 as price FROM Products as p
WHERE store1 != 'None'
UNION ALL
SELECT p.product_id, "store2" as store, p.store2 as price FROM Products as p
WHERE store2 != 'None'
UNION ALL
SELECT p.product_id, "store3" as store, p.store3 as price FROM Products as p
WHERE store3 != 'None';

## Problem 1683
DROP TABLE IF EXISTS Tweets;
Create table If Not Exists Tweets(tweet_id int, content varchar(50));
insert into Tweets (tweet_id, content) values ('1', 'Vote for Biden');
insert into Tweets (tweet_id, content) values ('2', 'Let us make America great again!');

SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;

## Problem 1587
DROP TABLE IF EXISTS Users;
Create table If Not Exists Users (account int, name varchar(20));
insert into Users (account, name) values ('900001', 'Alice');
insert into Users (account, name) values ('900002', 'Bob');
insert into Users (account, name) values ('900003', 'Charlie');

DROP TABLE IF EXISTS Transactions;
Create table If Not Exists Transactions (trans_id int, account int, amount int, transacted_on date);
insert into Transactions (trans_id, account, amount, transacted_on) values ('1', '900001', '7000', '2020-08-01');
insert into Transactions (trans_id, account, amount, transacted_on) values ('2', '900001', '7000', '2020-09-01');
insert into Transactions (trans_id, account, amount, transacted_on) values ('3', '900001', '-3000', '2020-09-02');
insert into Transactions (trans_id, account, amount, transacted_on) values ('4', '900002', '1000', '2020-09-12');
insert into Transactions (trans_id, account, amount, transacted_on) values ('5', '900003', '6000', '2020-08-07');
insert into Transactions (trans_id, account, amount, transacted_on) values ('6', '900003', '6000', '2020-09-07');
insert into Transactions (trans_id, account, amount, transacted_on) values ('7', '900003', '-4000', '2020-09-11');

SELECT r.name, r.balance FROM (
	SELECT u.name, SUM(t.amount) as balance FROM Transactions as t
	LEFT JOIN Users as u
	ON t.account = u.account
	GROUP BY u.name
) as r
WHERE balance > 10000;

# Problem 627
DROP TABLE IF EXISTS Salary;
Create table If Not Exists Salary (id int, name varchar(100), sex char(1), salary int);
insert into Salary (id, name, sex, salary) values ('1', 'A', 'm', '2500');
insert into Salary (id, name, sex, salary) values ('2', 'B', 'f', '1500');
insert into Salary (id, name, sex, salary) values ('3', 'C', 'm', '5500');
insert into Salary (id, name, sex, salary) values ('4', 'D', 'f', '500');

SET SQL_SAFE_UPDATES=0;

UPDATE Salary
SET sex = (
	CASE sex 
    WHEN 'f' THEN 'm'
    WHEN 'm' THEN 'f'
    END);
    
# Problem 1378
DROP TABLE IF EXISTS Employees;
Create table If Not Exists Employees (id int, name varchar(20));
insert into Employees (id, name) values ('1', 'Alice');
insert into Employees (id, name) values ('7', 'Bob');
insert into Employees (id, name) values ('11', 'Meir');
insert into Employees (id, name) values ('90', 'Winston');
insert into Employees (id, name) values ('3', 'Jonathan');

DROP TABLE IF EXISTS EmployeeUNI;
Create table If Not Exists EmployeeUNI (id int, unique_id int);
insert into EmployeeUNI (id, unique_id) values ('3', '1');
insert into EmployeeUNI (id, unique_id) values ('11', '2');
insert into EmployeeUNI (id, unique_id) values ('90', '3');

SELECT eu.unique_id, e.name FROM Employees as e
LEFT JOIN EmployeeUNI as eu
ON e.id = eu.id;

# Problem 1068
DROP TABLE IF EXISTS Sales;
Create table If Not Exists Sales (sale_id int, product_id int, year int, quantity int, price int);
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000');

DROP TABLE IF EXISTS Product;
Create table If Not Exists Product (product_id int, product_name varchar(10));
insert into Product (product_id, product_name) values ('100', 'Nokia');
insert into Product (product_id, product_name) values ('200', 'Apple');
insert into Product (product_id, product_name) values ('300', 'Samsung');

SELECT p.product_name, s.year, s.price FROM Sales as s
LEFT JOIN Product as p
ON s.product_id = p.product_id;


# Problem 1179
DROP TABLE IF EXISTS Department;
Create table If Not Exists Department (id int, revenue int, month varchar(5));
insert into Department (id, revenue, month) values ('1', '8000', 'Jan');
insert into Department (id, revenue, month) values ('2', '9000', 'Jan');
insert into Department (id, revenue, month) values ('3', '10000', 'Feb');
insert into Department (id, revenue, month) values ('1', '7000', 'Feb');
insert into Department (id, revenue, month) values ('1', '6000', 'Mar');

SELECT id,
	SUM(CASE month WHEN 'Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
    SUM(CASE month WHEN 'Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
    SUM(CASE month WHEN 'Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
    SUM(CASE month WHEN 'Apr' THEN revenue ELSE NULL END) AS Apr_Revenue,
    SUM(CASE month WHEN 'May' THEN revenue ELSE NULL END) AS May_Revenue,
    SUM(CASE month WHEN 'Jun' THEN revenue ELSE NULL END) AS Jun_Revenue,
    SUM(CASE month WHEN 'Jul' THEN revenue ELSE NULL END) AS Jul_Revenue,
    SUM(CASE month WHEN 'Aug' THEN revenue ELSE NULL END) AS Aug_Revenue,
    SUM(CASE month WHEN 'Sep' THEN revenue ELSE NULL END) AS Sep_Revenue,
    SUM(CASE month WHEN 'Oct' THEN revenue ELSE NULL END) AS Oct_Revenue,
    SUM(CASE month WHEN 'Nov' THEN revenue ELSE NULL END) AS Nov_Revenue,
    SUM(CASE month WHEN 'Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY id;


# Problem 1890
DROP TABLE IF EXISTS Logins;
Create table If Not Exists Logins (user_id int, time_stamp datetime);
insert into Logins (user_id, time_stamp) values ('6', '2020-06-30 15:06:07');
insert into Logins (user_id, time_stamp) values ('6', '2021-04-21 14:06:06');
insert into Logins (user_id, time_stamp) values ('6', '2019-03-07 00:18:15');
insert into Logins (user_id, time_stamp) values ('8', '2020-02-01 05:10:53');
insert into Logins (user_id, time_stamp) values ('8', '2020-12-30 00:46:50');
insert into Logins (user_id, time_stamp) values ('2', '2020-01-16 02:49:50');
insert into Logins (user_id, time_stamp) values ('2', '2019-08-25 07:59:08');
insert into Logins (user_id, time_stamp) values ('14', '2019-07-14 09:00:00');
insert into Logins (user_id, time_stamp) values ('14', '2021-01-06 11:59:59');

SELECT r.user_id, r.time_stamp AS last_stamp FROM(
	SELECT *,
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY time_stamp DESC) AS row_num
	FROM Logins
	WHERE time_stamp >= '2020-01-01 00:00:00' and time_stamp <= '2020-12-31 23:59:59'
) as r
WHERE r.row_num = 1;

SELECT user_id, MAX(time_stamp) AS last_stamp FROM Logins
WHERE YEAR(time_stamp) = '2020'
GROUP BY user_id;

# Problem 1484
DROP TABLE IF EXISTS Activities;
Create table If Not Exists Activities (sell_date date, product varchar(20));
insert into Activities (sell_date, product) values ('2020-05-30', 'Headphone');
insert into Activities (sell_date, product) values ('2020-06-01', 'Pencil');
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask');
insert into Activities (sell_date, product) values ('2020-05-30', 'Basketball');
insert into Activities (sell_date, product) values ('2020-06-01', 'Bible');
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask');
insert into Activities (sell_date, product) values ('2020-05-30', 'T-Shirt');

SELECT sell_date, COUNT(DISTINCT product) AS num_sold, GROUP_CONCAT(DISTINCT product order by product) AS products FROM Activities
GROUP BY sell_date;

# Problem 175
DROP TABLE IF EXISTS Person;
Create table If Not Exists Person (personId int, firstName varchar(255), lastName varchar(255));
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen');
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob');

DROP TABLE IF EXISTS Address;
Create table If Not Exists Address (addressId int, personId int, city varchar(255), state varchar(255));
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York');
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California');

SELECT p.firstname, p.lastname, a.city, a.state FROM Person as p
LEFT JOIN Address as a
ON p.personId = a.personId;