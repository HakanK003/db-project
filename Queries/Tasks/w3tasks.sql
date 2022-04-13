/**
  Display all tables individually
     SELECT * FROM CUSTOMERS ; -- and so on
 */
-- 1. FIND OUT THE CUSTOMER COUNT FOR EACH COUNTRY
-- 2. FIND OUT ANY EMPLOYEES WITH BA DEGREES (BY CHECKING NOTES CONTAINING BA )
-- 3. FIND OUT CUSTOMER NAME AND OrderID  Using the Orders and Customers table
-- 4. FIND OUT CUSTOMER NAME AND OrderID  Using the Orders and Customers table
-- CONTINUE TO FIND OUT THE EMPLOYEE NAME  USING EmployeeID
SELECT o.OrderID , c.CustomerName, e.FIRSTNAME
FROM ORDERS o
         INNER JOIN CUSTOMERS c ON o.CustomerID = c.CustomerID
         INNER JOIN AGENTS e ON o.EmployeeID = e.EmployeeID;
-- 5. Find out OrderDetailID and ProductName using the OrderDetails table and Products table
-- they are related by ProductID
SELECT ORDERDETAILID, PRODUCTNAME
from ORDERDETAILS join PRODUCTS P on P.PRODUCTID = ORDERDETAILS.PRODUCTID
;

-- OPTIONAL TASKS
--O1. FIND OUT HOW MANY ORDERS EACH CUSTOMER MADE, INCLUDING THOSE CUSTOMERS WHO MADE NO ORDER
SELECT C.CUSTOMERNAME, count(OD.QUANTITY) as HowManyOrders
from CUSTOMERS C full outer join ORDERS O  on C.CUSTOMERID = O.CUSTOMERID full outer join ORDERDETAILS OD on O.ORDERID = OD.ORDERID
group by C.CUSTOMERNAME order by count(QUANTITY);

--O2. FIND OUT COUNT OF PRODUCTS FOR EACH ORDER FROM OrderDetails table

SELECT ORDERID, count(QUANTITY) as CountOfProducts
from ORDERDETAILS
group by ORDERID;

--O3. FIND OUT EMPLOYEE FirstName and Count of ORDER they processed
-- including those employees did not process any order (Adam)

select CUSTOMERNAME, count(QUANTITY)
from ORDERDETAILS join CUSTOMERS join ORDERS O on CUSTOMERS.CUSTOMERID = O.CUSTOMERID on ORDERDETAILS.ORDERID = O.ORDERID
group by CUSTOMERNAME order by count(QUANTITY);

--O4. Find out How much each ORDER COST - SUM OF ALL PRODUCT PRICE IN ORDER DETAILS FOR EACH ORDER

select ORDERID, sum(PRICE)
from ORDERDETAILS full outer join PRODUCTS on ORDERDETAILS.PRODUCTID = PRODUCTS.PRODUCTID
group by ORDERID;

/**
  -- FIND OUT HOW MUCH EACH ORDER COST
-- EACH ORDER CONSISTS OF MULTIPLE LINE ITEMS CAN BE FOUND IN ORDER DETAILS TABLE
-- ONE PRODUCT PRICE IN ORDER DETAIL IS calculated using  QUANNTITY*PRICE(from PRODUCTS table)
-- ONCE you find out how much each line items costs , now you can sum them up using SUM
-- The question asked for each order , so group by ORDERID
 */
SELECT oe.OrderID , SUM(oe.Quantity * p.Price) AS ORDER_COST
FROM OrderDetails oe
INNER JOIN Products p ON p.ProductID = oe.ProductID
GROUP BY oe.OrderID;

---- PART 1

-- CUSTOMERS TABLE
-- 1.	Display CUSTOMERNAME AND ADDRESS IF CONTACTNAME is Pedro Afonso

select CUSTOMERNAME , ADDRESS
from CUSTOMERS
where CONTACTNAME = 'Pedro Afonso';

-- 2.	Display CUSTOMERS FullAddress(alias) in below format by concatenating
-- 3.	ADDRESS , CITY , POSTALCODE, COUNTRY

select ADDRESS ||', '|| CUSTOMERS.CITY ||', '|| POSTALCODE ||', '|| COUNTRY as FullAddress
from CUSTOMERS;

-- 4.	Display CUSTOMERS THAT DOES NOT HAVE POSTALCODE

select CONTACTNAME, POSTALCODE from CUSTOMERS where POSTALCODE is null ;

-- 5.	Display all CUSTOMERS with POSTALCODE contains space or -

select CONTACTNAME, POSTALCODE from CUSTOMERS where POSTALCODE like '% %' or POSTALCODE like '%-%';

-- 6.	Display CUSTOMERS with ID between 10-25

select CONTACTNAME, CUSTOMERID from CUSTOMERS where CUSTOMERID between 10 and 25;

-- 7.	Display CUSTOMERS if address ends with Rd. Blvd. or Road

select CONTACTNAME, ADDRESS from CUSTOMERS where ADDRESS like '%Rd.' or ADDRESS like '%Blvd.' or ADDRESS like '%Road';

-- a.	GET THE COUNT OF ABOVE RESULT WITH COUNT(*)
-- 8.	Display All Customers in UK , US if POSTALCODE is not WX3 6FW, 97403

select CONTACTNAME, COUNTRY, POSTALCODE
from CUSTOMERS
where COUNTRY in ('USA', 'UK') and not POSTALCODE in ('WX3 6FW','97403');


select count(*) from (
                         select CONTACTNAME, COUNTRY, POSTALCODE
                         from CUSTOMERS
                         where COUNTRY in ('USA', 'UK') and not POSTALCODE in ('WX3 6FW','97403')

                         );

-- 9.	Display CUSTOMERS Count in CITY Of LONDON

select CONTACTNAME, COUNTRY, CITY
from CUSTOMERS
where CITY = 'London';

select count(*) from (

                     select CONTACTNAME, COUNTRY, CITY
                     from CUSTOMERS
                     where CITY = 'London'

                         );


-- 10.	Display CUSTOMERS Count for EACH CITY

select CITY, count(CUSTOMERNAME) from CUSTOMERS group by CITY;

-- 11.	Display CUSTOMERS Count for EACH COUNTRY
-- 12.	Display CUSTOMERS Count for EACH COUNTRY

select COUNTRY, count(CUSTOMERNAME) from CUSTOMERS group by COUNTRY;

-- 13.	Filter the result only display if Count is more than 5

select COUNTRY, count(CUSTOMERNAME)
from CUSTOMERS
group by COUNTRY
having count(CUSTOMERNAME) > 5;

--
-- CATEGORIES TABLE
-- 14.	Display All Categories contains 'es' in Description excluding coffees

select CATEGORYNAME, DESCRIPTION
from CATEGORIES
where DESCRIPTION like '%es%' and not DESCRIPTION like '%coffees%';

-- 15.	Display CATEGORYNAME with ID of 1, 5 , 7

select CATEGORYNAME, CATEGORYID
from CATEGORIES
where CATEGORYID in (1,5,7);

-- 16.	Display CATEGORYNAME and LENGTH of DESCRIPTION

select CATEGORYNAME, length(DESCRIPTION) from CATEGORIES;

-- 17.	 Display MAX(LENGTH(DESCRIPTION))

select CATEGORYNAME, DESCRIPTION, length(DESCRIPTION)
from CATEGORIES
where length(DESCRIPTION) = (
    select max( length(DESCRIPTION) ) from CATEGORIES
    );

---- PART 2

-- EMPLOYEES TABLE (NOT FROM HR)

-- 18. Display All Employees with BA Degree (contains BA in NOTES)

select * from AGENTS where NOTES like '%BA%';

-- 19. Display youngest Employee Birthday

select * from AGENTS
where BIRTHDATE = (
    Select max(BIRTHDATE) from AGENTS
                               );

-- ORDERS TABLE

-- 20. Display All orders processed by Employee with EmployeeID 5,3

select * from ORDERS where EMPLOYEEID in (3, 5);

-- 21. Display All orders made by Customer with CustomerID between 70-80

select * from ORDERS where CUSTOMERID between 70 and 80;

-- 22. Display All orders shipped by Shipper with ShipperID 3

select * from ORDERS where SHIPPERID = 3;

-- 23. Display Count of Distinct CustomerId to show how many unique customers made these orders

select distinct CUSTOMERID, count(ORDERID) from ORDERS group by CUSTOMERID;

-- 24. OPTIONAL : Display Orders made before 1996-07-10
-- USE WHERE ORDER_DATE < TO_DATE('1996-07-10','YYY-MM--DD')

select * from ORDERS
USE WHERE ORDERDATE < TO_DATE('1996-07-10','YYYY-MM-DD');

-- ORDERDETAILS TABLE
-- 25. Display All orderdetails for ORDER with ORDERID 10255
-- 26. Display COUNT OF orderdetails for ORDER with ORDERID 10255
-- 27. Display COUNT of orderdetails for EACH ORDER
-- 29. Display QUANTITY for orderdetails with id 21
-- 30. Display SUM OF ALL QUANTITY for ORDER with ORDERID 10255
-- 31. Display SUM OF ALL QUANTITY for EACH ORDER (Group by ORRDERID)
-- 32. Display All OrderDetails if PRODUCTID is 76
-- 33. Display the COUNT of OrderDetails if PRODUCTID is 76
---34. Display the SUM of QUANTITY if PRODUCTID is 76
---35. Display the SUM of QUANTITY for EACH PRODUCTID

---- PART 3
--- PRODUCTS TABLE
-- 35. Display all PRODUCTS if SupplierID is 7
-- 36. Display all PRRODUCTS if Name starts with Uncle or Grandma
-- 37. Display all PRRODUCTS if CategoryID 2, 4, 6
-- 38. Display the Count of PRRODUCTS in category 8
-- 39. Display Max price
-- 40. Display Max price in each Category
-- 41. Display Max price for all products that SupplierID is more than 10

--- SUPPLIERS TABLE
-- 42. Display all SUPPLIERS Name for ID 2, 5, 17, 20
-- 43. Display all SUPPLIERS in USA, Germany, France , excluding one in CITY Berlin
-- 44. Display all SUPPLIERS count in each COUNTRY
-- 45. Filter above result to show only if the count is more than 4
-- 46. Display the count of SUPPLIERS if phone number does not starts with (

-- SHIPPERS TABLE
-- 47. Find the name and phone number of SHIPPER with ID 2
