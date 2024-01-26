use classicmodels ;
########################################## dashboard-1 ##################################################
#total revenue-9604190.61
 select sum(priceEach * quantityOrdered) as revenue from orderdetails;
#total order quantity-2996
select count(quantityOrdered) from orderdetails;
#total profit-3825880.25
SELECT
  SUM(priceEach * quantityOrdered) - SUM(buyPrice * quantityOrdered) AS difference
FROM orderDetails
JOIN products USING (productCode);
#total product quantity-555k
select sum(quantityInStock) from products;
#total orders
select count(distinct orderNumber) as total_orders from orderdetails;
#sum of sales by year and quarter
SELECT
  SUM(priceEach * quantityOrdered) AS sales,
  YEAR(orderDate) AS orderYear,
  QUARTER(orderDate) AS orderQuarter
  
FROM
  orderdetails
JOIN
  orders USING(orderNumber)
GROUP BY
  orderYear, orderQuarter order by sales desc ;
#orderQuantity v/s city 
SELECT
  COUNT(quantityOrdered) AS orderQuantity,
  offices.city
FROM
  orderdetails
JOIN
  orders ON orders.orderNumber = orderdetails.orderNumber
JOIN
  customers ON orders.customerNumber = customers.customerNumber
JOIN
  employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN
  offices ON offices.officeCode = employees.officeCode
GROUP BY
  offices.city
ORDER BY
  orderQuantity DESc;
#sales v/s productline
SELECT
  SUM(priceEach * quantityOrdered) AS price,
  productLine
FROM
  orderdetails
JOIN
  products USING(productCode)
GROUP BY
  productLine;
#profit v/s productline  
 SELECT
  productLine,
  (SELECT
  SUM(priceEach * quantityOrdered) - SUM(buyPrice * quantityOrdered) )AS profit
FROM
  orderDetails
JOIN
  products USING (productCode)
GROUP BY
  productLine;
#amount v/s country
  SELECT
  c.country,
  SUM(p.amount) AS total_amount
FROM
  customers c
JOIN
  payments p ON c.customerNumber = p.customerNumber
GROUP BY
  c.country order by total_amount desc;


############################################### PAGE-2 ##################################################


# total credit limit 
select sum(creditLimit) from customers;
#total employees
select count(distinct employeeNumber) from employees;
#total branches 
select count(distinct officeCode) from offices;
#total customers
select count(distinct  customerNumber) from customers;
#total product vendors
select count(distinct productVendor) from  products;
#customer count v/s country  
SELECT count(customerNumber) cust_count,country from customers group by country order by cust_count desc;
# orders v/s branches
SELECT
  COUNT(orderdetails.quantityOrdered) AS order_count,
  employees.officeCode FROM orderdetails 
 JOIN orders USING (orderNumber)
 JOIN customers USING (customerNumber)
 JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
 JOIN offices USING (officeCode)
 GROUP BY employees.officeCode;
#Top 5creditlimit v/s customers 
select customerName,sum(creditLimit) credlim from customers 
group by customerNumber order by credlim desc limit 5;

#profit v/s product vendor 
	SELECT 
	  productVendor,
	  (SUM(priceEach * quantityOrdered) - SUM(buyPrice * quantityOrdered)) AS profit FROM orderDetails
	JOIN products USING (productCode)
	GROUP BY productVendor;
# office v/s location 
	select officeCode,city from offices;
 
 #orders v/s employee name 
  SELECT
  COUNT(orderdetails.quantityOrdered) AS order_count,
  employees.firstName FROM orderdetails 
	JOIN orders USING (orderNumber)
	JOIN customers USING (customerNumber)
	JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
	GROUP BY employees.firstName;



############################################### PAGE-3 ##################################################
#total distinct products -110
select count( distinct productCode) from  products;
#total payment 8.8M
select sum(amount) from payments;
#order quantity- 105K 
select sum(quantityOrdered) from orderdetails;
#payments count
select count(distinct checkNumber) payments from payments;

#Top 5 High Ordered products
select productName,count(quantityOrdered) quantity from  products join  orderdetails using (productCode) 
group by  productName order by quantity desc limit 5;
#bottom 5 low ordered products 
select productName,count(quantityOrdered) quantity from  products join  orderdetails using (productCode) 
group by  productName order by quantity asc limit 5;

#employees v/s department
select count(employeeNumber),jobTitle from employees group by jobTitle;

#top 5 product name by revenue
SELECT
    productName,sum(priceEach * quantityOrdered) as revenue from orderdetails
JOIN products USING (productCode)
GROUP BY productName order by revenue desc limit 5;

#bottom 5 product name by revenue 
SELECT
    productName,sum(priceEach * quantityOrdered) as revenue from orderdetails
JOIN products USING (productCode)
GROUP BY productName order by revenue limit 5;





