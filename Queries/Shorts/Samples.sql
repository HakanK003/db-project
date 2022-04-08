
-- TODO --> Select Statement

--    1- selecting entire columns from a table
--        select * from TableName;


--    2- selecting a single column from a table
--        select ColumnName from TableName;


--    3- selecting multiple columns from a table
--        select ColumnName1, ColumnName2 from TableName;


--    4- Selecting columns from multiple tables
--        select TableName1.ColumnName1, TableName2.ColumnName2 from TableName1, TableName2;


-- TODO --> distinct keyword

--    1- Removes duplicated elements from console (not from table)
--        select distinct ColumnName from TableName;


-- TODO --> where clause / in, between statement

--    1- Selects column(s) from table(s) where conditions match
--        Operators:
--        > , < , >= , <= , = , != , or , and

select * from EMPLOYEES where SALARY < 5000;

select * from EMPLOYEES where SALARY < 5000 and MANAGER_ID = 114;

--        between statement --> used to specify the range of the condition value between Lowest and Highest

select * from EMPLOYEES where SALARY between  3000 and 5000;

--        in statement      --> used for specifying the range of the condition

select  * from EMPLOYEES where DEPARTMENT_ID in (30, 60, 110);

-- TODO --> Order by statement

--    1- after select statement put --> order by ColumnName ASC/DESC
--     default is ASC order                   ASC--> Ascending    DESC--> Descending

select * from COUNTRIES order by REGION_ID;

select * from COUNTRIES order by REGION_ID asc; -- this is redundant

select * from COUNTRIES where REGION_ID < 3 order by REGION_ID asc; -- used for case like this (still redundant???)

select * from COUNTRIES order by REGION_ID desc;


-- TODO --> Like statement

--    1- Used for partial search
--        WildCards
--          starts with : Chars%
--          ends with   : %Chars
--          contains    : %Chars%
--        select ColumnName from TableName where Value Like WildCard

select * from COUNTRIES where COUNTRY_NAME like 'Au%';

select * from COUNTRIES where COUNTRY_NAME like '%a';

select * from COUNTRIES where COUNTRY_NAME like 'A%' and COUNTRY_NAME like '%a';

select * from COUNTRIES where COUNTRY_NAME like '%ab%';


--    2- Count function

select count(COUNTRY_NAME) over () from COUNTRIES where COUNTRY_NAME like 'Au%';

select count(COUNTRY_NAME) from COUNTRIES where COUNTRY_NAME like '%a';


-- TODO --> Text Functions / String Manipulations

--    1- concatenation operator: ||
--    2- Concat(Value1, Value2):
--    3- Upper(Value):
--    4- Lower(Value):
--    5- INITCAP(Value):  first letter uppercase others lowercase
--    6- Length(Value):
--    7- replace(ColumnName, oldValue, newValue):
--    8- substr(ColumnName, Beg index, end index):
--    9- Trim(Value):
--    Only for display, doesn't modify table

--    1- concatenation operator: ||

select EMAIL || '@gamil.com' from EMPLOYEES;

select FIRST_NAME || ' ' || LAST_NAME from EMPLOYEES;

--    2- Concat(Value1, Value2):

select  concat(EMAIL, '@gamil.com') from EMPLOYEES;

select concat( concat(FIRST_NAME, ' '), LAST_NAME) from EMPLOYEES;

--    3- Upper(Value):

select upper(FIRST_NAME) from EMPLOYEES;

--    4- Lower(Value):

select  lower(FIRST_NAME) from EMPLOYEES;

select lower(upper(FIRST_NAME)) from EMPLOYEES;

--    5- INITCAP(Value):

select initcap(email) from EMPLOYEES;

--    6- Length(Value):

select length(FIRST_NAME) from EMPLOYEES;

select FIRST_NAME, length(FIRST_NAME) from EMPLOYEES;

--    7- replace(ColumnName, oldValue, newValue):

select  replace(FIRST_NAME, 'e', 'E,') from EMPLOYEES;

--    8- substr(ColumnName, Beg index, end index):

select FIRST_NAME , substr( FIRST_NAME , 0, 3) from EMPLOYEES;

select  substr(FIRST_NAME, 0, 1) || substr( LAST_NAME, 0, 1) from EMPLOYEES;

--    9- Trim(Value):

select FIRST_NAME from EMPLOYEES;
select concat('       ', FIRST_NAME) from EMPLOYEES;

select trim( concat('       ', FIRST_NAME) )from EMPLOYEES;


-- TODO --> Aggregate Functions, Count() | Round IS NOT AGGREGATE FUNCTION
--
--    1- min(): selects the min value from the column
--        select min(ColumnName) from TableName;
--    2- max(): selects the max value from the column
--        select max(ColumnName) from TableName;
--    3- avg(): selects average value from the column
--        select avg(ColumnName) from TableName;
--    4- sum(): returns the sum of all values
--        select sum(ColumnName) from TableName;
----------------------------------------------------------------
--    5- count():
--        select count(ColumnName) from TableName where Conditions;
--    6- round(): for decimal numbers
--        select round(avg(ColumnName)) from TableName;


select min(LOCATION_ID) from DEPARTMENTS;  --1400

select * from DEPARTMENTS where LOCATION_ID = ( select min(LOCATION_ID) from DEPARTMENTS ); -- to be able to use function as a condition put it into parenthesis


select max(LOCATION_ID) from DEPARTMENTS;

select *  from DEPARTMENTS where LOCATION_ID = ( select max(LOCATION_ID) from DEPARTMENTS );


select max(SALARY) from EMPLOYEES;

select * from EMPLOYEES where SALARY = ( select max(SALARY) from EMPLOYEES );

select * from EMPLOYEES where SALARY = ( select min(SALARY) from EMPLOYEES );


select avg(SALARY) from EMPLOYEES;

select round( avg( SALARY ) ) from EMPLOYEES;
select round( avg( SALARY ), 3 ) from EMPLOYEES;
select round( avg( SALARY ), 6 ) from EMPLOYEES;


select sum(SALARY) from EMPLOYEES;


select  count(*) from EMPLOYEES where MANAGER_ID = 100;
select  count(*) from EMPLOYEES where SALARY < 10000; -- number of employees that are making less than 10000


-- TODO --> Group By & Having

--    1- group by --> divides the rows into groups
--    2- having   --> give a condition after group by

select JOB_ID from EMPLOYEES group by JOB_ID;

select JOB_ID, count(*) from EMPLOYEES group by JOB_ID;

select JOB_ID, max(SALARY) from EMPLOYEES group by JOB_ID;

select JOB_ID, min(SALARY) from EMPLOYEES group by JOB_ID;

select JOB_ID, avg(SALARY) from EMPLOYEES group by JOB_ID;

select JOB_ID, sum(SALARY) from EMPLOYEES group by JOB_ID;


select JOB_ID, count(*) from EMPLOYEES group by JOB_ID having max(SALARY) > 2000;

select JOB_ID, count(*) from EMPLOYEES group by JOB_ID having min(SALARY) > 5000;

--select JOB_ID, count(*) from EMPLOYEES group by JOB_ID having avg(SALARY) > 6000;   --  *** COMPILER ERROR ***


-- TODO --> Aliases: Table & Column

--    Aliases --> Used to give temporary name to tables and columns
--        column aliases --> We use "As" keyword to give temporary name to the column
--            select ColumnName as "as" from TableName;
--        table aliases -->Given with a space
--            select ColumnName from TableName Name;

-- Column aliases
select FIRST_NAME as "Given Name" from EMPLOYEES;

select FIRST_NAME || ' ' || LAST_NAME as "Full Name" from EMPLOYEES;

select concat(EMAIL, '@gmail.com') as "Email Address" from EMPLOYEES;

-- Table aliases
select * from EMPLOYEES, JOB_HISTORY;
select EMPLOYEES.employee_id, JOB_HISTORY.job_id from EMPLOYEES, JOB_HISTORY;
select e.employee_id, j.job_id from EMPLOYEES e, JOB_HISTORY j;


-- TODO --> Views: Create, Replace, Drop

--    View is just a saved  statement, if we change values from original table values in the view will be changed
--      Create a view:
--           create view ViewName as Statement;
--      Replace a view:
--           create or replace view ViewName as Statement;
--      Dropping a view:
--           drop view ViewName;

select * from EMPLOYEES;

select FIRST_NAME || ' ' || LAST_NAME as FullName from EMPLOYEES;

create view EmployeeInfo as select FIRST_NAME || ' ' || LAST_NAME as FullName from EMPLOYEES;

select  * from EmployeeInfo;

select FIRST_NAME || ' ' || LAST_NAME as FullName,
lower(EMAIL||'@gmail.com') as Email
from EMPLOYEES;

create or replace view EmployeeInfo as
select FIRST_NAME || ' ' || LAST_NAME as FullName,
lower(EMAIL||'@gmail.com') as Email
from EMPLOYEES;

select * from EmployeeInfo;

drop view EmployeeInfo;


-- TODO --> Tables: Create, Insert, Update, Delete

-- Create a table -->  CREATE TABLE TableName (ColumnName TYPE constraint);
-- Constraint is not mandatory
--          1- NOT NULL --> the value of the column cannot be null
--          2- UNIQUE --> the value of the column must be unique across the whole table
--          3- PRIMARY KEY --> this constraint is a combination of NOT NULL and UNIQUE
--          4- REFERENCES --> OtherTable (PKColumn) - used to give foreign key to the column. We give the foreign key to the column by making Other table'primary key column as the reference column

--   INSERT
--       INSERT INTO TableName(column1, column2, ...)
--       values(value1, value2) (value1, value2, ...), ... ;

--   UPDATE
--       UPDATE TableName SET column1 = value1, column2 = value2, ... where conditions;

--   DELETE
--       DELETE from TableName where condition;


-- TODO --> Tables: Alter, Commit

--  Commit: To save changes to database, do it once at the end of the changes (basically save button)
--         commit;  or  commit work;

--  Alter: Modify tables
--         add column:
--                  Alter Table TableName add ColumnName DataType;
--         rename column:
--                  Alter Table TableName rename column ColumnName to NewColumnName;
--         drop column:
--                  Alter Table TableName drop column ColumnName;
--         rename table:
--                  Alter Table TableName rename to NewTableName;


create table address(

address_id INTEGER primary key,
address varchar(50) not null,    -- cannot be more than 50 chars
phone INTEGER

);

select * from address;  -- empty table

insert into address (address_id, address, phone) values (10, 'Lee High Way', 123456);
insert into address (address_id, address, phone) values (12, 'Lee High Way', 123456);
insert into address (address_id, address, phone) values (14, 'Bee High Way', 987654);

select * from address;


create table customer(

    customer_id INTEGER primary key,
    firstName varchar(30) null,
    address_id INTEGER REFERENCES address(address_id)

);

select * from customer;

insert into customer (customer_id, firstName, address_id) values (1, 'Muhtar', 10); -- address_id should be match
insert into customer (customer_id, firstName, address_id) values (2, 'John', 12); -- address_id should be match
insert into customer (customer_id, firstName, address_id) values (3, 'Mary', 14); -- address_id should be match


update customer set customer_id = 6 where customer_id=2;


delete from customer where customer_id =6 and address_id =12;


select * from customer;

commit ;

--add column (alter)
alter table customer add LastName varchar(20);

--rename column (alter)
alter table customer rename column LastName to City;


update customer set CITY = 'Miami' where firstName = 'Muhtar';
update customer set CITY = 'Palo Alto' where firstName = 'John';
update customer set CITY = 'Colorado' where firstName = 'Mary';


--drop column (alter)
alter table customer drop column CITY;

--rename table (alter)
alter table customer rename  to Shoppers;

commit work ;

select * from SHOPPERS;


-- TODO --> Tables: Drop & Truncate

-- Drop: To delete table
--      DROP table TableName;
-- Truncate: Removes all data from table but table remains
--      TRUNCATE table TableName;

select * from shoppers;
drop table SHOPPERS;

select * from address;
truncate table address;

commit ;


-- TODO --> Use of Foreign Key & Primary Key in table structures


create table ClassMates(
    Student_ID integer primary key,   -- must be unique, can't be null
    "First Name" varchar(30),   -- "" cause we have two words as column name
    "Last Name" varchar(30)
);

select * from ClassMates;

create table Coworkers(
    Employee_ID integer primary key,
    "First Name" varchar(30),
    "Last Name" varchar(30),
    Personal_Id integer references ClassMates(Student_ID)  -- foreign key, data needs to match with referenced primary key, can be duplicated, can't be null
);

select * from Coworkers;

insert into Coworkers values (1, 'John', 'Eric', null);  -- we can't insert values from here to other table only null

insert into ClassMates values (1, 'Harry', 'Daniel');

select * from ClassMates;

insert into Coworkers values (2, 'Jimmy', 'Rose', 1);

insert into Coworkers values (3, 'Jerry', 'Rose', 2);  -- we can't insert something that doesn't exist


update ClassMates set Student_ID =3 where Student_ID=1; -- we can't change because it is a reference to other tables (we have to delete all reference)
alter table ClassMates drop column Student_ID;-- we can't change because it is a reference to other tables (we have to delete all reference)
truncate table ClassMates;-- we can't change because it is a reference to other tables (we have to delete all reference)
drop table ClassMates;-- we can't change because it is a reference to other tables (we have to delete all reference)












