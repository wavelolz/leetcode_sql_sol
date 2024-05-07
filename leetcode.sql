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


# Problem 584
DROP TABLE IF EXISTS Custormer;
Create table If Not Exists Customer (id int, name varchar(25), referee_id VARCHAR(255));
insert into Customer (id, name, referee_id) values ('1', 'Will', 'None');
insert into Customer (id, name, referee_id) values ('2', 'Jane', 'None');
insert into Customer (id, name, referee_id) values ('3', 'Alex', '2');
insert into Customer (id, name, referee_id) values ('4', 'Bill', 'None');
insert into Customer (id, name, referee_id) values ('5', 'Zack', '1');
insert into Customer (id, name, referee_id) values ('6', 'Mark', '2');

SELECT name FROM Customer
WHERE referee_id != '2';


# Problem 626
DROP TABLE IF EXISTS Seat;
Create table If Not Exists Seat (id int, student varchar(255));
insert into Seat (id, student) values ('1', 'Field');
insert into Seat (id, student) values ('2', 'Sherwood');
insert into Seat (id, student) values ('3', 'Aly');
insert into Seat (id, student) values ('4', 'Harriman');
insert into Seat (id, student) values ('5', 'Christ');
insert into Seat (id, student) values ('6', 'Pullan');
insert into Seat (id, student) values ('7', 'Harry');
insert into Seat (id, student) values ('8', 'Roosevelt');
insert into Seat (id, student) values ('9', 'Richard');
insert into Seat (id, student) values ('10', 'Evan');
insert into Seat (id, student) values ('11', 'Pansy');
insert into Seat (id, student) values ('12', 'Darwin');
insert into Seat (id, student) values ('13', 'Chamberian');
insert into Seat (id, student) values ('14', 'Kennedy');
insert into Seat (id, student) values ('15', 'Clapham');
insert into Seat (id, student) values ('16', 'Hart');
insert into Seat (id, student) values ('17', 'Carllyle');
insert into Seat (id, student) values ('18', 'Esther');
insert into Seat (id, student) values ('19', 'Rhodes');
insert into Seat (id, student) values ('20', 'Hodgson');


SELECT ROW_NUMBER() OVER (PARTITION BY (SELECT 1) ORDER BY r.rown ASC, r.id DESC) AS id,
	r.student
FROM (
	SELECT *,
		ROW_NUMBER() OVER (ORDER BY id) AS rown
	FROM Seat
	WHERE id % 2 = 1
	UNION ALL
	SELECT *,
		ROW_NUMBER() OVER (ORDER BY id) AS rown
	FROM Seat
	WHERE id % 2 = 0
	ORDER BY rown ASC, id DESC
) AS r;

SELECT 
	CASE
		WHEN id = (SELECT MAX(id) FROM Seat) AND id % 2 = 1 THEN id
        WHEN id % 2 = 1 THEN id + 1
        WHEN id % 2 = 0 THEN id - 1
    END AS id,
    student
FROM Seat
ORDER BY id;


# Problem 181
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (id int, name varchar(255), salary int, managerId VARCHAR(255));
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3');
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4');
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', 'None');
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', 'None');

SELECT e1.name AS employee FROM Employee as e1
INNER JOIN Employee as e2
ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;


# Problem 183
DROP TABLE IF EXISTS Customers;
Create table If Not Exists Customers (id int, name varchar(255));
insert into Customers (id, name) values ('1', 'Joe');
insert into Customers (id, name) values ('2', 'Henry');
insert into Customers (id, name) values ('3', 'Sam');
insert into Customers (id, name) values ('4', 'Max');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (id int, customerId int);
insert into Orders (id, customerId) values ('1', '3');
insert into Orders (id, customerId) values ('2', '1');

SELECT c.name AS customers FROM Customers AS c
LEFT OUTER JOIN Orders AS o
ON c.id = customerId
WHERE o.id is NULL;


# Problem 1729
DROP TABLE IF EXISTS Followers;
Create table If Not Exists Followers(user_id int, follower_id int);
insert into Followers (user_id, follower_id) values ('0', '1');
insert into Followers (user_id, follower_id) values ('1', '0');
insert into Followers (user_id, follower_id) values ('2', '0');
insert into Followers (user_id, follower_id) values ('2', '1');

SELECT user_id, COUNT(follower_id) AS followers_count FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;


# Problem 1581
DROP TABLE IF EXISTS Visits;
Create table If Not Exists Visits(visit_id int, customer_id int);
insert into Visits (visit_id, customer_id) values ('1', '23');
insert into Visits (visit_id, customer_id) values ('2', '9');
insert into Visits (visit_id, customer_id) values ('4', '30');
insert into Visits (visit_id, customer_id) values ('5', '54');
insert into Visits (visit_id, customer_id) values ('6', '96');
insert into Visits (visit_id, customer_id) values ('7', '54');
insert into Visits (visit_id, customer_id) values ('8', '54');

DROP TABLE IF EXISTS Transactions;
Create table If Not Exists Transactions(transaction_id int, visit_id int, amount int);
insert into Transactions (transaction_id, visit_id, amount) values ('2', '5', '310');
insert into Transactions (transaction_id, visit_id, amount) values ('3', '5', '300');
insert into Transactions (transaction_id, visit_id, amount) values ('9', '5', '200');
insert into Transactions (transaction_id, visit_id, amount) values ('12', '1', '910');
insert into Transactions (transaction_id, visit_id, amount) values ('13', '2', '970');

SELECT v.customer_id, COUNT(*) AS count_no_trans FROM Visits AS v
LEFT OUTER JOIN Transactions AS t
ON v.visit_id=t.visit_id
WHERE t.transaction_id is NULL
GROUP BY v.customer_id;


# Problem 595
DROP TABLE IF EXISTS World;
Create table If Not Exists World (name varchar(255), continent varchar(255), area int, population int, gdp bigint);
insert into World (name, continent, area, population, gdp) values ('Afghanistan', 'Asia', '652230', '25500100', '20343000000');
insert into World (name, continent, area, population, gdp) values ('Albania', 'Europe', '28748', '2831741', '12960000000');
insert into World (name, continent, area, population, gdp) values ('Algeria', 'Africa', '2381741', '37100000', '188681000000');
insert into World (name, continent, area, population, gdp) values ('Andorra', 'Europe', '468', '78115', '3712000000');
insert into World (name, continent, area, population, gdp) values ('Angola', 'Africa', '1246700', '20609294', '100990000000');

SELECT name, population, area FROM World
WHERE area>=3000000 or population>=25000000;


# Problem 1661
DROP TABLE IF EXISTS Activity;
Create table If Not Exists Activity (machine_id int, process_id int, activity_type ENUM('start', 'end'), timestamp float);
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '0', 'start', '0.712');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '0', 'end', '1.52');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '1', 'start', '3.14');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '1', 'end', '4.12');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '0', 'start', '0.55');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '0', 'end', '1.55');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '1', 'start', '0.43');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '1', 'end', '1.42');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '0', 'start', '4.1');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '0', 'end', '4.512');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '1', 'start', '2.5');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '1', 'end', '5');

SELECT r.machine_id, ROUND(AVG(r.nn), 3) AS processing_time FROM (
	SELECT machine_id,
		SUM(
			CASE activity_type
				WHEN 'start' THEN ROUND(-timestamp, 3)
				WHEN 'end' THEN ROUND(timestamp, 3)
			END
		) AS nn
	FROM Activity
	GROUP BY machine_id, process_id
) AS r
GROUP BY r.machine_id;

SELECT a1.machine_id, ROUND(AVG(a2.timestamp-a1.timestamp), 3) AS processing_time FROM Activity AS a1
INNER JOIN Activity AS a2
ON a1.machine_id=a2.machine_id AND a1.process_id=a2.process_id AND a1.activity_type='start' AND a2.activity_type='end'
GROUP BY a1.machine_id; 


# Problem 1204
DROP TABLE IF EXISTS Queue;
Create table If Not Exists Queue (person_id int, person_name varchar(30), weight int, turn int);
insert into Queue (person_id, person_name, weight, turn) values ('5', 'Alice', '250', '1');
insert into Queue (person_id, person_name, weight, turn) values ('4', 'Bob', '175', '5');
insert into Queue (person_id, person_name, weight, turn) values ('3', 'Alex', '350', '2');
insert into Queue (person_id, person_name, weight, turn) values ('6', 'John Cena', '400', '3');
insert into Queue (person_id, person_name, weight, turn) values ('1', 'Winston', '500', '6');
insert into Queue (person_id, person_name, weight, turn) values ('2', 'Marie', '200', '4');

SELECT q1.person_name
FROM Queue AS q1
WHERE (SELECT SUM(q2.weight) FROM Queue as q2 WHERE q2.turn <= q1.turn) <= 1000
ORDER BY q1.turn DESC LIMIT 1;

SELECT r.person_name FROM (
	SELECT person_name, turn,
		@running_total := @running_total + q.weight AS cum
	FROM Queue AS q
	INNER JOIN (SELECT @running_total := 0) AS r
	ORDER BY q.turn ASC
) AS r
WHERE r.cum <= 1000
ORDER BY r.turn DESC LIMIT 1;


# Problem 607
DROP TABLE IF EXISTS SalesPerson;
Create table If Not Exists SalesPerson (sales_id int, name varchar(255), salary int, commission_rate int, hire_date date);
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('1', 'John', '100000', '6', '2006-01-04');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('2', 'Amy', '12000', '5', '2010-01-05');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('3', 'Mark', '65000', '12', '2008-12-25');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('4', 'Pam', '25000', '25', '2005-01-01');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('5', 'Alex', '5000', '10', '2007-02-03');

DROP TABLE IF EXISTS Company;
Create table If Not Exists Company (com_id int, name varchar(255), city varchar(255));
insert into Company (com_id, name, city) values ('1', 'RED', 'Boston');
insert into Company (com_id, name, city) values ('2', 'ORANGE', 'New York');
insert into Company (com_id, name, city) values ('3', 'YELLOW', 'Boston');
insert into Company (com_id, name, city) values ('4', 'GREEN', 'Austin');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (order_id int, order_date date, com_id int, sales_id int, amount int);
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('1', '2014-01-01', '3', '4', '10000');
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('2', '2014-02-01', '4', '5', '5000');
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('3', '2014-03-01', '1', '1', '50000');
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('4', '2014-04-01', '1', '4', '25000');

SELECT s.name FROM SalesPerson AS s
LEFT OUTER JOIN (
	SELECT * FROM Orders
	WHERE com_id IN (
		SELECT com_Id FROM Company 
		WHERE name = "RED"
)) AS oc
ON s.sales_id=oc.sales_id
WHERE oc.order_id IS NULL;


# Problem 586
DROP TABLE IF EXISTS orders;
Create table If Not Exists orders (order_number int, customer_number int);
insert into orders (order_number, customer_number) values ('1', '1');
insert into orders (order_number, customer_number) values ('2', '2');
insert into orders (order_number, customer_number) values ('3', '3');
insert into orders (order_number, customer_number) values ('4', '3');

SELECT r.customer_number FROM(
	SELECT customer_number,
		COUNT(*) AS order_num
	FROM orders
	GROUP BY customer_number
) AS r
ORDER BY r.order_num DESC LIMIT 1;


# Problem 2988
DROP TABLE IF EXISTS Employees;
Create table if not exists Employees ( emp_id int, emp_name varchar(50), dep_id int, position varchar(30));
insert into Employees (emp_id, emp_name, dep_id, position) values ('156', 'Michael', '107', 'Manager');
insert into Employees (emp_id, emp_name, dep_id, position) values ('112', 'Lucas', '107', 'Consultant');
insert into Employees (emp_id, emp_name, dep_id, position) values ('8', 'Isabella', '101', 'Manager');
insert into Employees (emp_id, emp_name, dep_id, position) values ('160', 'Joseph', '100', 'Manager');
insert into Employees (emp_id, emp_name, dep_id, position) values ('80', 'Aiden', '100', 'Engineer');
insert into Employees (emp_id, emp_name, dep_id, position) values ('190', 'Skylar', '100', 'Freelancer');
insert into Employees (emp_id, emp_name, dep_id, position) values ('196', 'Stella', '101', 'Coordinator');
insert into Employees (emp_id, emp_name, dep_id, position) values ('167', 'Audrey', '100', 'Consultant');
insert into Employees (emp_id, emp_name, dep_id, position) values ('97', 'Nathan', '101', 'Supervisor');
insert into Employees (emp_id, emp_name, dep_id, position) values ('128', 'Ian', '101', 'Administrator');
insert into Employees (emp_id, emp_name, dep_id, position) values ('81', 'Ethan', '107', 'Administrator');

SELECT e.emp_name AS manager_name, e.dep_id FROM Employees AS e
INNER JOIN (
	SELECT dep_id FROM Employees
	GROUP BY dep_id
	HAVING COUNT(*) = (
	SELECT COUNT(*) AS num FROM Employees
	GROUP BY dep_id
    ORDER BY COUNT(*) DESC LIMIT 1
)) AS d
WHERE e.dep_id=d.dep_id AND e.position='Manager'
ORDER BY e.dep_id ASC;

WITH largest(dep_id, rnk) AS (
	SELECT dep_id,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
	FROM Employees
	GROUP BY dep_id
)
SELECT emp_name AS manager_name, dep_id FROM Employees
WHERE position='manager' AND dep_id IN (
	SELECT dep_id FROM largest
    WHERE rnk='1'
)
ORDER BY dep_id ASC;


# Problem 1077
DROP TABLE IF EXISTS Project;
Create table If Not Exists Project (project_id int, employee_id int);
insert into Project (project_id, employee_id) values ('1', '1');
insert into Project (project_id, employee_id) values ('1', '2');
insert into Project (project_id, employee_id) values ('1', '3');
insert into Project (project_id, employee_id) values ('2', '1');
insert into Project (project_id, employee_id) values ('2', '4');

DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (employee_id int, name varchar(10), experience_years int);
insert into Employee (employee_id, name, experience_years) values ('1', 'Khaled', '3');
insert into Employee (employee_id, name, experience_years) values ('2', 'Ali', '2');
insert into Employee (employee_id, name, experience_years) values ('3', 'John', '3');
insert into Employee (employee_id, name, experience_years) values ('4', 'Doe', '2');

WITH jointable AS (
	SELECT p.project_id, e.employee_id, e.experience_years
	FROM Project AS p
	INNER JOIN Employee AS e
	ON p.employee_id=e.employee_id
)
SELECT r.project_id, r.employee_id FROM (
	SELECT project_id, experience_years, employee_id,
		RANK() OVER (PARTITION BY project_id ORDER BY experience_years DESC) AS rnk
	FROM jointable
) AS r
WHERE r.rnk=1;

SELECT r.project_id, r.employee_id FROM (
	SELECT p.project_id, p.employee_id,
		RANK() OVER (PARTITION BY project_id ORDER BY experience_years DESC) AS rnk
	FROM Project AS p
	INNER JOIN Employee AS e
	ON p.employee_id=e.employee_id
) AS r
WHERE r.rnk='1';


# Problem 1715
DROP TABLE IF EXISTS Boxes;
Create table If Not Exists Boxes (box_id int, chest_id VARCHAR(255), apple_count int, orange_count int);
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('2', 'None', '6', '15');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('18', 'None', '4', '15');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('19', 'None', '8', '4');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('12', 'None', '19', '20');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('20', 'None', '12', '9');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('8', 'None', '9', '9');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('3', 'None', '16', '7');

DROP TABLE IF EXISTS Chests;
Create table If Not Exists Chests (chest_id int, apple_count int, orange_count int);
insert into Chests (chest_id, apple_count, orange_count) values ('6', '5', '6');
insert into Chests (chest_id, apple_count, orange_count) values ('14', '20', '10');
insert into Chests (chest_id, apple_count, orange_count) values ('2', '8', '8');
insert into Chests (chest_id, apple_count, orange_count) values ('3', '19', '4');
insert into Chests (chest_id, apple_count, orange_count) values ('16', '19', '19');

SELECT 
	SUM(r.bac)+IFNULL(SUM(r.cac), 0) AS apple_count,
    SUM(r.boc)+IFNULL(SUM(r.coc), 0) AS orange_count
FROM (
	SELECT b.apple_count AS bac, b.orange_count AS boc, c.apple_count AS cac, c.orange_count AS coc FROM Boxes AS b
	LEFT JOIN Chests AS c
	USING (chest_id)
) AS r;


# Problem 1270
DROP TABLE IF EXISTS Employees;
Create table If Not Exists Employees (employee_id int, employee_name varchar(30), manager_id int);
insert into Employees (employee_id, employee_name, manager_id) values ('1', 'Boss', '1');
insert into Employees (employee_id, employee_name, manager_id) values ('3', 'Alice', '3');
insert into Employees (employee_id, employee_name, manager_id) values ('2', 'Bob', '1');
insert into Employees (employee_id, employee_name, manager_id) values ('4', 'Daniel', '2');
insert into Employees (employee_id, employee_name, manager_id) values ('7', 'Luis', '4');
insert into Employees (employee_id, employee_name, manager_id) values ('8', 'John', '3');
insert into Employees (employee_id, employee_name, manager_id) values ('9', 'Angela', '8');
insert into Employees (employee_id, employee_name, manager_id) values ('77', 'Robert', '1');

SELECT e3.employee_id FROM Employees AS e4
INNER JOIN (
	SELECT e1.employee_id, e2.manager_id AS manager_of_manager_id FROM Employees AS e1
	INNER JOIN Employees AS e2
	ON e1.manager_id=e2.employee_id
) AS e3
ON e3.manager_of_manager_id=e4.employee_id
WHERE e4.manager_id=1 AND e3.employee_id != 1;

SELECT e1.employee_id
FROM Employees AS e1, Employees AS e2, Employees AS e3
WHERE e1.manager_id=e2.employee_id AND e2.manager_id=e3.employee_id AND e1.employee_id != 1 AND e3.manager_id=1;


# Problem 1445
DROP TABLE IF EXISTS Sales;
Create table If Not Exists Sales (sale_date date, fruit ENUM('apples', 'oranges'), sold_num int);
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-01', 'apples', '10');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-01', 'oranges', '8');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-02', 'apples', '15');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-02', 'oranges', '15');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-03', 'apples', '20');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-03', 'oranges', '0');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-04', 'apples', '15');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-04', 'oranges', '16');

SELECT r.sale_date,
	SUM(r.arg) AS diff
FROM (
	SELECT *,
		CASE fruit
			WHEN 'apples' THEN sold_num
			WHEN 'oranges' THEN -sold_num
		END AS arg
	FROM Sales
) AS r
GROUP BY r.sale_date
ORDER BY r.sale_date ASC;

# Problem 1355
DROP TABLE IF EXISTS Friendsl;
Create table If Not Exists Friends (id int, name varchar(30), activity varchar(30));
insert into Friends (id, name, activity) values ('1', 'Jonathan D.', 'Eating');
insert into Friends (id, name, activity) values ('2', 'Jade W.', 'Singing');
insert into Friends (id, name, activity) values ('3', 'Victor J.', 'Singing');
insert into Friends (id, name, activity) values ('4', 'Elvis Q.', 'Eating');
insert into Friends (id, name, activity) values ('5', 'Daniel A.', 'Eating');
insert into Friends (id, name, activity) values ('6', 'Bob B.', 'Horse Riding');

DROP TABLE IF EXISTS Activities;
Create table If Not Exists Activities (id int, name varchar(30));
insert into Activities (id, name) values ('1', 'Eating');
insert into Activities (id, name) values ('2', 'Singing');
insert into Activities (id, name) values ('3', 'Horse Riding');

SELECT r.activity FROM (
	SELECT activity,
		RANK() OVER (ORDER BY COUNT(*) ASC) AS asc_rank,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS desc_rank
	FROM Friends
	GROUP BY activity
) AS r
WHERE r.asc_rank != 1 AND r.desc_rank != 1;


# Problem 2020
DROP TABLE IF EXISTS Subscriptions;
Create table If Not Exists Subscriptions (account_id int, start_date date, end_date date);
insert into Subscriptions (account_id, start_date, end_date) values ('9', '2020-02-18', '2021-10-30');
insert into Subscriptions (account_id, start_date, end_date) values ('3', '2021-09-21', '2021-11-13');
insert into Subscriptions (account_id, start_date, end_date) values ('11', '2020-02-28', '2020-08-18');
insert into Subscriptions (account_id, start_date, end_date) values ('13', '2021-04-20', '2021-09-22');
insert into Subscriptions (account_id, start_date, end_date) values ('4', '2020-10-26', '2021-05-08');
insert into Subscriptions (account_id, start_date, end_date) values ('5', '2020-09-11', '2021-01-17');

DROP TABLE IF EXISTS Streams;
Create table If Not Exists Streams (session_id int, account_id int, stream_date date);
insert into Streams (session_id, account_id, stream_date) values ('14', '9', '2020-05-16');
insert into Streams (session_id, account_id, stream_date) values ('16', '3', '2021-10-27');
insert into Streams (session_id, account_id, stream_date) values ('18', '11', '2020-04-29');
insert into Streams (session_id, account_id, stream_date) values ('17', '13', '2021-08-08');
insert into Streams (session_id, account_id, stream_date) values ('19', '4', '2020-12-31');
insert into Streams (session_id, account_id, stream_date) values ('13', '5', '2021-01-05');

SELECT COUNT(*) AS accounts_count FROM Subscriptions AS sub
LEFT OUTER JOIN Streams AS str
USING (account_id)
WHERE (YEAR(start_date) = '2021' OR YEAR(end_date) = '2021') AND (str.session_id IS NULL OR YEAR(str.stream_date) != '2021');


# Problem 2051
DROP TABLE IF EXISTS Members;
Create table If Not Exists Members (member_id int, name varchar(30));
insert into Members (member_id, name) values ('9', 'Alice');
insert into Members (member_id, name) values ('11', 'Bob');
insert into Members (member_id, name) values ('3', 'Winston');
insert into Members (member_id, name) values ('8', 'Hercy');
insert into Members (member_id, name) values ('1', 'Narihan');

DROP TABLE IF EXISTS Visits;
Create table If Not Exists Visits (visit_id int, member_id int, visit_date date);
insert into Visits (visit_id, member_id, visit_date) values ('22', '11', '2021-10-28');
insert into Visits (visit_id, member_id, visit_date) values ('16', '11', '2021-01-12');
insert into Visits (visit_id, member_id, visit_date) values ('18', '9', '2021-12-10');
insert into Visits (visit_id, member_id, visit_date) values ('19', '3', '2021-10-19');
insert into Visits (visit_id, member_id, visit_date) values ('12', '11', '2021-03-01');
insert into Visits (visit_id, member_id, visit_date) values ('17', '8', '2021-05-07');
insert into Visits (visit_id, member_id, visit_date) values ('21', '9', '2021-05-12');

DROP TABLE IF EXISTS Purchases;
Create table If Not Exists Purchases (visit_id int, charged_amount int);
insert into Purchases (visit_id, charged_amount) values ('12', '2000');
insert into Purchases (visit_id, charged_amount) values ('18', '9000');
insert into Purchases (visit_id, charged_amount) values ('17', '7000');


WITH jointable AS(
	SELECT member_id, name, 
		COUNT(CASE WHEN visit_id IS NOT NULL THEN 1 ELSE NULL END) AS visit_count,
        COUNT(CASE WHEN charged_amount IS NOT NULL THEN 1 ELSE NULL END) AS buy_count
    FROM Members AS m
	LEFT OUTER JOIN (
		SELECT * FROM Visits AS v
		LEFT OUTER JOIN Purchases AS p
		USING (visit_id)
	) AS vp
	USING (member_id)
    GROUP BY member_id, name
)

SELECT member_id, name,
	CASE
		WHEN visit_count = 0 THEN 'Bronze'
		WHEN (100*buy_count/visit_count) >= 80 THEN 'Diamond'
        WHEN (100*buy_count/visit_count) >= 50 THEN 'Gold'
        ELSE 'Silver'
    END AS category
FROM jointable
GROUP BY member_id, name;

SELECT member_id, name,
	CASE
		WHEN COUNT(v.visit_id) = 0 THEN 'Bronze'
        WHEN 100*COUNT(p.visit_id)/COUNT(v.visit_id) >= 80 THEN 'Diamond'
        WHEN 100*COUNT(p.visit_id)/COUNT(v.visit_id) >= 50 THEN 'Gold'
        ELSE 'Silver'
    END AS category
FROM Members AS m
LEFT JOIN Visits AS v USING (member_id)
LEFT JOIN Purchases AS p USING (visit_id)
GROUP BY member_id, name

