------books table
CREATE TABLE books(
Book_id SERIAL PRIMARY KEY,
Title VARCHAR(200) NOT NULL,
Author VARCHAR(200),
Genre VARCHAR(200),
Published_year INT,
Price NUMERIC(4,2),
Stock INT
);
SELECT* FROM books;
------orders table
CREATE TABLE orders(
Order_id SERIAL PRIMARY KEY,
Customer_id INT REFERENCES Customers(Customer_ID),
Book_id INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC (6,2)
);
SELECT* FROM orders;
------customers table
CREATE TABLE customers(
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(200),
Email TEXT,
Phone INT,
CITY VARCHAR(200),
Country  VARCHAR(200)
);
SELECT* FROM customers;
--------------------------------NOW IMPORT DATA TO ALL FILES FROM CSV FILE BY TOOLj
----------LETS RUN QUERIES
--1.Retrives all books in the "Fiction" genre
SELECT title,author,genre
FROM books
WHERE genre='Fiction';

--2.Find books published after the year 1950
SELECT title,author,published_year
FROM books
WHERE published_year>1950;

--3.List all customers from canada
SELECT customer_id,name
FROM customers
WHERE country='canada';

--4.Show order plashed in November 2023
SELECT order_id,customer_id,order_date 
FROM orders
WHERE order_date BETWEEN '2023-11-01'AND '2023-11-30';

--5.Retrive the total stock of books available
SELECT SUM(stock) AS stock_available
FROM books;

--6.Find the details of the most expensive book
 SELECT*FROM books
 ORDER BY price DESC
 LIMIT 1;
 
--7.Show all customers who ordered more than 1 quantity of book
SELECT* FROM orders
WHERE quantity>1;

--8.Retrive all orders where the total amount exceeds $20
SELECT order_id,customer_id
FROM orders
WHERE total_amount>20;

--9.List all genres available in the Books table
SELECT DISTINCT genre
FROM books;

--10.Find the book with the lowest stock
SELECT title
FROM books
ORDER BY stock ASC
LIMIT 1;

--11.Calculate the total revenue generated from the orders
SELECT SUM(total_amount) AS total_revenue
FROM orders;

----------------------------------------------------MORE QUERIES------------------------------------
--1.Retrive the total number of books sold for each genre
SELECT b.genre,SUM(o.Quantity) AS total_books_sold
FROM orders o
JOIN 
Books b
ON o.book_id=b.book_id
GROUP BY b.genre;

--2.Find the average price of books in the "Fantasy" genre
SELECT title, AVG(price) AS avg_price
FROM books
WHERE genre='Fantasy'
GROUP BY title;

--3.List customers who have placed at least 2 orders
SELECT c.name, o.quantity
FROM orders o
JOIN
customers c
ON c.customer_id=o.customer_id
WHERE quantity>2;

--4.Find the most frequently ordered book
SELECT b.title,o.order_date
FROM orders o
JOIN 
books b
ON b.book_id=o.book_id
ORDER BY order_date DESC
LIMIT 1;


--5.Show the top 3 most expensive books of'Fantasy' Genre
SELECT title,author,price
FROM BOOKS
WHERE genre='Fantasy'
ORDER BY price DESC
LIMIT 3;

--6.Retrive the total quantity of books sold by each author
SELECT b.author,SUM(o.quantity) AS books_sold
FROM orders o
JOIN 
books b
ON b.book_id=o.book_id
GROUP BY b.author;

--7.List the cities where customers who spent over $30 are localated
SELECT c.city, o.total_amount
FROM orders o
JOIN 
customers c
ON c.customer_id=o.customer_id
WHERE total_amount>30;

--8.Find the customer who spent the most on orders
SELECT c.customer_id,c.name,o.total_amount
FROM customers c
JOIN 
orders o
ON o.customer_id=c.customer_id
ORDER BY total_amount DESC
LIMIT 1;

--9.Calculate the stock remaining after fulfilling all orders
SELECT b.stock,b.title,o.quantity,(b.stock-o.quantity) AS stock_remaining
FROM books b
JOIN 
orders o
ON o.book_id=b.book_id
GROUP BY b.stock,b.title,o.quantity;

------------------------------------------PROJECT ON ONLINE BOOK STORE-----------------------------------------------------------------


























