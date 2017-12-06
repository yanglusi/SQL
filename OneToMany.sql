-- One to Many Relationship

-- Creating the online bookshop database
CREATE DATABASE onlinebookshop;
USE onlinebookshop;

-- Creating the customers and order tables
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- Inserting customer and orders information
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5); 

-- Find George and his orders
SELECT * FROM customers WHERE last_name = 'George';
SELECT * FROM orders WHERE customer_id = 1;
SELECT * FROM orders WHERE customer_id = 
    (
        SELECT id FROM customers
        WHERE last_name = 'George'
    );

-- Implicit Inner Join 
SELECT * FROM customers, orders 
    WHERE customers.id = customer_id;
    
SELECT first_name, last_name, order_date, amount
FROM customers, orders
    WHERE customers.id = orders.customer_id;

-- Explicit Inner Join
SELECT * FROM customers
JOIN orders
    ON customers.id = orders. customer_id;

SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders
    ON customers.id = orders.customer_id;

-- Order By Amount
SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
ORDER BY amount;

-- Order By Order Date
SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
ORDER BY order_date;

-- Order by Total Spent 
SELECT 
    first_name, 
    last_name, 
    order_date, 
    SUM(amount) AS total_spent
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

-- Left Join
SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders. customer_id;

-- Order by Total Spent
SELECT 
    first_name, 
    last_name, 
    IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;

-- Right Join
SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders. customer_id;

-- Add two Orphan Data
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2012/03/29', 70.88, 34),
       ('2011/12/01', 58.85, 45);

SELECT 
    IFNULL(first_name, 'MISSING') AS first,
    IFNULL(last_name, 'USER') AS last,
    order_date, 
    SUM(amount)
FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY first_name, last_name;

-- INNER, LEFT, AND RIGHT JOIN MESS
SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;
    
SELECT * FROM orders
RIGHT JOIN customers
    ON customers.id = orders.customer_id;
    
SELECT * FROM orders
LEFT JOIN customers
    ON customers.id = orders.customer_id;   
    
SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id;
    
SELECT * FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;

-- Student
CREATE DATABASE students;
USE students;

-- Create Student Table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100)
    );

CREATE TABLE papers (
    title VARCHAR(100),
    grade INT,
    student_id INT,
    FOREIGN KEY(student_id) REFERENCES students(id)
);

INSERT INTO students (first_name) VALUES 
('Caleb'), 
('Samantha'), 
('Raj'), 
('Carlos'), 
('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

-- Match the Essay with its Author
-- Case 1: No NULL Students
SELECT
    first_name,
    title,
    grade
FROM students
RIGHT JOIN papers
    ON students.id = papers.student_id
ORDER BY first_name DESC;

-- Case 2: With NULL Students
SELECT
    first_name,
    IFNULL(title, 'MISSING') AS title,
    IFNULL(grade, 0) AS grade
FROM papers
RIGHT JOIN students
    ON students.id = papers.student_id;

-- Find the Average
SELECT 
    first_name,
    IFNULL(AVG(grade), 0) AS average
FROM papers
RIGHT JOIN students
    ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

-- Find the Passing Grade
SELECT 
    first_name,
    IFNULL(AVG(grade), 0) AS average,
    CASE
        WHEN AVG(grade) IS NULL THEN 'FAILING'
        WHEN AVG(grade) >= 75 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM papers
RIGHT JOIN students
    ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;
