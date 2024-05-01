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


# Problem 1148
DROP TABLE IF EXISTS Views;
Create table If Not Exists Views (article_id int, author_id int, viewer_id int, view_date date);
insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '5', '2019-08-01');
insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '6', '2019-08-02');
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '7', '2019-08-01');
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '6', '2019-08-02');
insert into Views (article_id, author_id, viewer_id, view_date) values ('4', '7', '1', '2019-07-22');
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21');
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21');

SELECT DISTINCT author_id AS id FROM Views
WHERE author_id=viewer_id
ORDER BY author_id ASC;


# Problem 577
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (empId int, name varchar(255), supervisor varchar(255), salary int);
insert into Employee (empId, name, supervisor, salary) values ('3', 'Brad', 'None', '4000');
insert into Employee (empId, name, supervisor, salary) values ('1', 'John', '3', '1000');
insert into Employee (empId, name, supervisor, salary) values ('2', 'Dan', '3', '2000');
insert into Employee (empId, name, supervisor, salary) values ('4', 'Thomas', '3', '4000');

DROP TABLE IF EXISTS Bonus;
Create table If Not Exists Bonus (empId int, bonus int);
insert into Bonus (empId, bonus) values ('2', '500');
insert into Bonus (empId, bonus) values ('4', '2000');

SELECT e.name, b.bonus FROM Employee as e
LEFT JOIN Bonus as b
ON e.empId=b.empId
WHERE b.bonus<1000 or b.bonus is NULL;


# Problem 511
DROP TABLE IF EXISTS Activity;
Create table If Not Exists Activity (player_id int, device_id int, event_date date, games_played int);
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5');
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-05-02', '6');
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5');

SELECT player_id, MIN(event_date) AS first_login FROM Activity
GROUP BY player_id;


# Problem 620
DROP TABLE IF EXISTS cinema;
Create table If Not Exists cinema (id int, movie varchar(255), description varchar(255), rating float(2, 1));
insert into cinema (id, movie, description, rating) values ('1', 'War', 'great 3D', '8.9');
insert into cinema (id, movie, description, rating) values ('2', 'Science', 'fiction', '8.5');
insert into cinema (id, movie, description, rating) values ('3', 'irish', 'boring', '6.2');
insert into cinema (id, movie, description, rating) values ('4', 'Ice song', 'Fantacy', '8.6');
insert into cinema (id, movie, description, rating) values ('5', 'House card', 'Interesting', '9.1');

SELECT * FROM cinema
WHERE id % 2 = 1 and description != 'boring'
ORDER BY rating DESC;


# Problem 608
DROP TABLE IF EXISTS Tree;
Create table If Not Exists Tree (id int, p_id varchar(255));
insert into Tree (id, p_id) values ('1', 'None');
insert into Tree (id, p_id) values ('2', '1');
insert into Tree (id, p_id) values ('3', '1');
insert into Tree (id, p_id) values ('4', '2');
insert into Tree (id, p_id) values ('5', '2');

SELECT id,
	CASE
		WHEN p_id = 'None' THEN 'Root'
		WHEN id in (SELECT DISTINCT p_id from tree) THEN 'Inner'
		ELSE 'Leaf'
	END AS type
FROM Tree;


# Problem 610
DROP TABLE IF EXISTS Triangle;
Create table If Not Exists Triangle (x int, y int, z int);
insert into Triangle (x, y, z) values ('13', '15', '30');
insert into Triangle (x, y, z) values ('10', '20', '15');

SELECT *,
	CASE 
		WHEN x+y>z and x+z>y and y+z>x THEN 'Yes'
        ELSE 'No'
	END AS 'triangle'
FROM Triangle;

SELECT *,
	IF (x+y>z and x+z>y and y+z>x, 'Yes', 'No') AS 'triangle'
FROM Triangle;


# Problem 1965
DROP TABLE IF EXISTS Employees;
Create table If Not Exists Employees (employee_id int, name varchar(30));
insert into Employees (employee_id, name) values ('2', 'Crew');
insert into Employees (employee_id, name) values ('4', 'Haven');
insert into Employees (employee_id, name) values ('5', 'Kristian');

DROP TABLE IF EXISTS Salaries;
Create table If Not Exists Salaries (employee_id int, salary int);
insert into Salaries (employee_id, salary) values ('5', '76071');
insert into Salaries (employee_id, salary) values ('1', '22517');
insert into Salaries (employee_id, salary) values ('4', '63539');

SELECT * FROM (
	SELECT e.employee_id FROM Employees as e
	LEFT JOIN Salaries as s
	ON e.employee_id=s.employee_id
	WHERE e.name is NULL or s.salary is NULL
	UNION ALL
	SELECT s.employee_id FROM Salaries as s
	LEFT JOIN Employees as e
	ON e.employee_id=s.employee_id
	WHERE e.name is NULL or s.salary is NULL
) AS r
ORDER BY employee_id ASC;


# Problem 182
DROP TABLE IF EXISTS Person;
Create table If Not Exists Person (id int, email varchar(255));
insert into Person (id, email) values ('1', 'a@b.com');
insert into Person (id, email) values ('2', 'c@d.com');
insert into Person (id, email) values ('3', 'a@b.com');

SELECT email FROM (
	SELECT email, 
		ROW_NUMBER() OVER (PARTITION BY email) as row_num
	FROM Person
) as r
WHERE r.row_num=2;

SELECT email FROM Person
GROUP BY email
HAVING COUNT(email)>1;


# Problem 1327
DROP TABLE IF EXISTS Products;
Create table If Not Exists Products (product_id int, product_name varchar(40), product_category varchar(40));
insert into Products (product_id, product_name, product_category) values ('1', 'Leetcode Solutions', 'Book');
insert into Products (product_id, product_name, product_category) values ('2', 'Jewels of Stringology', 'Book');
insert into Products (product_id, product_name, product_category) values ('3', 'HP', 'Laptop');
insert into Products (product_id, product_name, product_category) values ('4', 'Lenovo', 'Laptop');
insert into Products (product_id, product_name, product_category) values ('5', 'Leetcode Kit', 'T-shirt');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (product_id int, order_date date, unit int);
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-05', '60');
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-10', '70');
insert into Orders (product_id, order_date, unit) values ('2', '2020-01-18', '30');
insert into Orders (product_id, order_date, unit) values ('2', '2020-02-11', '80');
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-17', '2');
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-24', '3');
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-01', '20');
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '30');
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '60');
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-25', '50');
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-27', '50');
insert into Orders (product_id, order_date, unit) values ('5', '2020-03-01', '50');

SELECT p.product_name, o.unit FROM Products as p
INNER JOIN (
	SELECT product_id, SUM(unit) as unit FROM Orders
	WHERE YEAR(order_date)='2020' and MONTH(order_date)='2'
	GROUP BY product_id
	HAVING SUM(unit)>=100
) AS o
ON p.product_id=o.product_id;


# Problem 1050
DROP TABLE IF EXISTS ActorDirector;
Create table If Not Exists ActorDirector (actor_id int, director_id int, timestamp int);
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '0');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '1');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '2');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '3');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '4');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '5');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '6');

SELECT CAST(SUBSTRING_INDEX(r.ad, ',', 1) AS UNSIGNED) AS actor_id, CAST(SUBSTRING_INDEX(r.ad, ',', -1) AS UNSIGNED) AS director_id FROM (
	SELECT CONCAT(actor_id, ',', director_id) AS ad
	FROM ActorDirector
	GROUP BY CONCAT(actor_id, ',', director_id)
	HAVING COUNT(CONCAT(actor_id, ',', director_id)) >=3
) AS r;

SELECT actor_id, director_id FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp)>=3;


