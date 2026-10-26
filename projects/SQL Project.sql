create database onlinebookstore;

create table books(
Book_ID serial primary key ,
Title varchar(100) ,
Author varchar(100) ,
Genre varchar(50) ,
Published_Year int,
Price numeric(10,2),
Stock int
)

create table customers(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(15),
City varchar(50),
Country varchar(150)
)

create table orders(
Order_ID serial primary key,
Customer_ID  int references customers(customer_id),
Book_ID int references books(book_id),
Order_Date date,
Quantity int,
Total_Amount numeric(10,2)
)

select * from books;
select * from customers;
select * from orders;

--retrieve all books in the "Fiction" genre
select * from books
where genre ='Fiction';

-- Find books published after the year 1950
select * from books
where published_year > 1950;

-- List all customers from the Canada
select * from customers
where country='Canada';

-- Show orders placed in November 2023
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

-- Retrieve the total stock of books available
select sum(stock) as total_stock_available
from books;

-- Find the details of the most expensive book
select * from books 
order by price desc limit 1;

-- Show all customers who ordered more than 1 quantity of a book
select *from orders
where quantity > 1; 

--Retrieve all orders where the total amount exceeds $20
select * from orders
where total_amount > 20;

-- List all genres available in the Books table
select distinct(genre) from books;

-- Find the book with the lowest stock
select * from books
where stock = (select min(stock) from books)
limit 1;

-- Calculate the total revenue generated from all orders
select sum(total_amount) as revenue from orders;

-- Retrieve the total number of books sold for each genre
select b.genre , sum(o.quantity) as total_books_sold 
from books b
inner join orders o
on b.book_id=o.book_id
group by b.genre;

-- Find the average price of books in the "Fantasy" genre
select avg(price) as Avg_price_fantasy from books
where genre='Fantasy';

-- List customers who have placed at least 2 orders
select o.customer_id , c.name ,count(order_id) as order_count
from orders o
join customers c
on c.customer_id=o.customer_id
group by o.customer_id , c.name
having count(order_id) >=2;

-- Find the most frequently ordered book
select o.book_id , b.title ,count(order_id) as order_count
from orders o
join books b
on b.book_id=o.book_id
group by o.book_id , b.title
order by order_count desc limit 1;

-- Show the top 3 most expensive books of 'Fantasy' Genre 
select * from books
where genre='Fantasy'
order by price desc limit 3;

--Retrieve the total quantity of books sold by each author
select b.author, sum(o.quantity) as Book_sold
from books b
join orders o
on b.book_id=o.book_id
group by b.author;

--List the cities where customers who spent over $30 are located
select distinct c.city , o.total_amount 
from customers c
join orders o
on c.customer_id=o.customer_id
where o.total_amount> 30;

-- Find the customer who spent the most on orders
select c.customer_id, c.name,sum(o.total_amount) as total_spent
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id , c.name
order by total_spent desc limit 1;

-- Calculate the stock remaining after fulfilling all orders
select b.book_id, b.title,b.stock, coalesce(sum(quantity),0)  as order_quantity,
   b.stock - coalesce(sum(quantity),0) as remaining_stock
from books b
left join orders o
on b.book_id=o.book_id
group by b.book_id order by b.book_id asc;


