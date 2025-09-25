CREATE DATABASE LesCoffee;
USE LesCoffee;

-- CREATE STATEMENTS --
CREATE TABLE Customer_Type (
	customer_type_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_type ENUM('Loyalty', 'Non-Loyalty') NOT NULL
    );

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    customer_type_id INT NOT NULL,
    FOREIGN KEY (customer_type_id) REFERENCES Customer_Type(customer_type_id)
);

CREATE TABLE Loyalty_Member (
	customer_loyalty_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    phone VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    points_accumulated INT NOT NULL,
    birth_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer (customer_id)
    );
    
CREATE TABLE Product (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL UNIQUE,
    product_desc VARCHAR(255) NOT NULL,
    product_price DECIMAL(5, 2),
    product_type ENUM('beverage', 'bakery', 'beans', 'merchandise') NOT NULL
    );
    
CREATE TABLE Purchase_Instance(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    total_price DECIMAL(5, 2) NOT NULL,
    empl_id INT NOT NULL,
    FOREIGN KEY (empl_id) REFERENCES Barista (empl_id)
    );
    
CREATE TABLE Order_Product(
	product_id INT,
    order_id INT,
    PRIMARY KEY (product_id, order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (order_id) REFERENCES Purchase_Instance(order_id)
);
    
CREATE TABLE Payment_Method(
	payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_type ENUM("Credit Card", "Contact-less", "Cash", "Gift Card") NOT NULL,
    amount_charged DECIMAL(5, 2) NOT NULL,
    date_charged DATE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Purchase_Instance(order_id)
    );

CREATE TABLE Barista(
	empl_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL,
    empl_phone VARCHAR(255) NOT NULL UNIQUE
	) AUTO_INCREMENT=1000;
	
	
-- INSERT STATEMENTS --
INSERT INTO Customer_Type (customer_type)
VALUES ('Loyalty'), ('Non-Loyalty');
SELECT * FROM Customer_Type;

INSERT INTO Customer (first_name, customer_type_id)
VALUES 
('Alice', 1),
('Bob', 2),
('Charlie', 1),
('David', 2),
('Eve', 1),
('Frank', 2),
('Grace', 1),
('Hank', 2),
('Ivy', 1),
('Jack', 2);

INSERT INTO Loyalty_Member (customer_id, phone, email, points_accumulated, birth_date) 
VALUES  
(1, '123-456-7890', 'alice@gmail.com', 100, '1990-01-01'),
(3, '234-567-8901', 'charlie@hotmail.com', 200, '1985-08-02'),
(5, '345-678-9012', 'eve@yahoo.com', 300, '1995-03-03'),
(7, '805-789-0123', 'grace@calpoly.edu', 150, '1992-04-04'),
(9, '567-890-1234', 'ivy@gmail.com', 250, '1988-05-05'),
(2, '456-789-0123', 'bob@gmail.com', 50, '1987-06-15'),
(4, '949-890-1234', 'david@hotmail.com', 75, '1979-09-20'),
(6, '678-901-2345', 'frank@gmail.com', 100, '1992-03-10'),
(8, '789-012-3456', 'hank@calpoly.cedu', 125, '1984-11-25'),
(10, '890-123-4567', 'jack@calpoly.edu', 150, '1996-08-30');

INSERT INTO Product (product_name, product_desc, product_price, product_type)
VALUES 
('Espresso', 'Doppio', 2.50, 'beverage'),
('Latte', 'Espresso with milk', 3.00, 'beverage'),
('Cappuccino', 'Latte with extra foam', 3.50, 'beverage'),
('Bagel', 'Sesame seed', 1.50, 'bakery'),
('Muffin', 'Blueberry muffin', 2.00, 'bakery'),
('Cookie', 'Chocolate chip', 1.00, 'bakery'),
('Coffee Beans', 'Arabica beans', 10.00, 'beans'),
('Mug', 'Travel mug', 8.00, 'merchandise'),
('T-shirt', 'Branded T-shirt', 15.00, 'merchandise'),
('Gift Card', 'Prepaid gift card', 25.00, 'merchandise');

INSERT INTO Barista (first_name, last_name, hire_date, empl_phone)
VALUES 
('Emily', 'Johnson', '2022-01-15', '123-456-7890'),
('Alex', 'Martinez', '2021-03-20', '234-567-8901'),
('Olivia', 'Lee', '2023-02-10', '345-678-9012'),
('Ethan', 'Nguyen', '2020-05-05', '456-789-0123'),
('Chloe', 'Brown', '2023-04-25', '567-890-1234'),
('Sebastian', 'Garcia', '2019-06-30', '678-901-2345'),
('Madison', 'Kim', '2020-08-12', '789-012-3456'),
('Lucas', 'Hernandez', '2022-09-18', '890-123-4567'),
('Lily', 'Patel', '2021-11-03', '901-234-5678'),
('Gabriel', 'Taylor', '2024-01-29', '012-345-6789');

INSERT INTO Purchase_Instance (order_date, total_price, empl_id)
VALUES 
('2024-01-01', 12.50, 1000),
('2024-01-02', 15.00, 1001),
('2024-01-03', 10.00, 1002),
('2024-01-04', 20.00, 1003),
('2024-01-05', 18.50, 1004),
('2024-01-06', 22.00, 1005),
('2024-01-07', 25.00, 1006),
('2024-01-08', 30.00, 1007),
('2024-01-09', 35.00, 1008),
('2024-01-10', 40.00, 1009);

INSERT INTO Order_Product (product_id, order_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO Payment_Method (order_id, payment_type, amount_charged, date_charged)
VALUES 
(1, 'Credit Card', 12.50, '2024-01-01'),
(2, 'Contact-less', 15.00, '2024-01-02'),
(3, 'Cash', 10.00, '2024-01-03'),
(4, 'Gift Card', 20.00, '2024-01-04'),
(5, 'Credit Card', 18.50, '2024-01-05'),
(6, 'Contact-less', 22.00, '2024-01-06'),
(7, 'Cash', 25.00, '2024-01-07'),
(8, 'Gift Card', 30.00, '2024-01-08'),
(9, 'Credit Card', 35.00, '2024-01-09'),
(10, 'Contact-less', 40.00, '2024-01-10');

-- Queries --
#1. Total sales by product type
SELECT p.product_type, SUM(pi.total_price) AS total_sales
FROM Purchase_Instance pi JOIN Order_Product op JOIN  Product p 
ON pi.order_id = op.order_id
AND op.product_id = p.product_id
GROUP BY p.product_type;

#2. Average Order Value by Month

SELECT YEAR(pi.order_date) AS year, MONTH(pi.order_date) AS month, AVG(pi.total_price) AS avg_order_value
FROM Purchase_Instance pi
GROUP BY YEAR(pi.order_date), MONTH(pi.order_date);

#3. Top Performing Baristas by Total Sales
SELECT b.first_name, b.last_name, SUM(pi.total_price) AS total_sales
FROM Purchase_Instance pi JOIN Barista b
ON pi.empl_id = b.empl_id
GROUP BY b.first_name, b.last_name
ORDER BY total_sales DESC;

#4. Most Loyalty Customer
SELECT c.first_name, lm.points_accumulated
FROM Customer c JOIN Loyalty_Member lm
ON c.customer_id = lm.customer_id
WHERE lm.points_accumulated = (
    SELECT MAX(points_accumulated)
    FROM Loyalty_Member
);

#5. Customers who have used gift cards
SELECT c.customer_id, c.first_name
FROM Customer c
WHERE c.customer_id IN (
    SELECT pm.order_id
    FROM Payment_Method pm
    WHERE pm.payment_type = 'Gift Card'
);
