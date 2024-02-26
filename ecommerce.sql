drop database if exists ecommerce;
create database ecommerce;
use ecommerce;

/* 1) You are required to create tables forsupplier,customer,category,product,supplier_pricing,order,rating to store the data forthe
E-commerce with the schema definition given below.*/

/* 2) You are required to develop SQL based programs (Queries)to facilitate the Admin team ofthe E-Commerce company to retrieve the data in
summarized format-The Data Retrievalneeds are described below.*/

drop table if exists supplier,customer,category,product,supplier_pricing,torder,rating;

create Table supplier(SUPP_ID INT Primary Key,SUPP_NAME varchar(50) NOT NULL,SUPP_CITY varchar(50)
NOT NULL,SUPP_PHONE varchar(50) NOT NULL);

create table customer(CUS_ID INT Primary Key,CUS_NAME VARCHAR(20) NOT NULL, CUS_PHONE VARCHAR(10)
NOT NULL, CUS_CITY VARCHAR(30) NOT NULL, CUS_GENDER CHAR);

create table category(CAT_ID INT Primary Key,CAT_NAME VARCHAR(20) NOT NULL);

create Table product(PRO_ID INT Primary Key,PRO_NAME VARCHAR(20) NOT NULL DEFAULT "Dummy",
PRO_DESC VARCHAR(60),CAT_ID INT, Foreign Key (CAT_ID) References category(CAT_ID));

create Table supplier_pricing(PRICING_ID INT Primary Key,PRO_ID INT, Foreign Key (PRO_ID) 
References product(PRO_ID),SUPP_ID INT, Foreign Key (SUPP_ID) References supplier(SUPP_ID),
SUPP_PRICE INT DEFAULT 0);

create Table torder(ORD_ID INT Primary Key,ORD_AMOUNT INT NOT NULL, ORD_DATE DATE NOT NULL,CUS_ID INT,
Foreign Key (CUS_ID) References customer(CUS_ID),PRICING_ID INT, Foreign Key (PRICING_ID) References
supplier_pricing(PRICING_ID));

create Table rating(RAT_ID INT Primary Key,ORD_ID INT, Foreign Key (ORD_ID) References torder(ORD_ID),
RAT_RATSTARS INT NOT NULL);

/*3. Data Insertion*/
insert into Supplier(SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE) values
(1,'Rajesh Retails','Delhi',1234567890),(2,'Appario Ltd.','Mumbai',2589631470),
(3,'Knome products','Banglore',9785462315),(4,'Bansal Retails','Kochi',8975463285),
(5,'Mittal Ltd.','Lucknow',7898456532);

insert into Customer(CUS_ID,CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER) values
(1,'AAKASH',9999999999,'DELHI','M'),(2,'AMAN',9785463215,'NOIDA','M'),
(3,'NEHA',9999999999,'MUMBAI','F'),(4,'MEGHA',9994562399,'KOLKATA','F'),
(5,'PULKIT',7895999999,'LUCKNOW','M');

insert into Category(CAT_ID,CAT_NAME) values
(1,'BOOKS'),(2,'GAMES'),(3,'GROCERIES'),(4,'ELECTRONICS'),(5,'CLOTHES');

insert into Product(PRO_ID,PRO_NAME,PRO_DESC,CAT_ID) values
(1,'GTA V','Windows 7 and above with i5 processor and 8GB RAM',2),
(2,'TSHIRT','SIZE-L with Black, Blue and White variations',5),
(3,'ROG LAPTOP','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4),
(4,'OATS','Highly Nutritious from Nestle',3),
(5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1),
(6,'MILK','1L Toned MIlk',3),
(7,'Boat Earphones','1.5Meter long Dolby Atmos',4),
(8,'Jeans','Stretchable Denim Jeans with various sizes and color',5),
(9,'Project IGI','compatible with windows 7 and above',2),
(10,'Hoodie','Black GUCCI for 13 yrs and above',5),
(11,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1),
(12,'Train Your Brain','By Shireen Stephen',1);

insert into Supplier_pricing(PRICING_ID,PRO_ID,SUPP_ID,SUPP_PRICE) values
(1,1,2,1500),(2,3,5,30000),(3,5,1,3000),(4,2,3,2500),(5,4,1,1000),(6,12,2,780),(7,12,4,789),
(8,3,1,31000),(9,1,5,1450),(10,4,2,999),(11,7,3,549),(12,7,4,529),(13,6,2,105),(14,6,1,99),
(15,2,5,2999),(16,5,2,2999);

insert into tOrder(ORD_ID,ORD_AMOUNT,ORD_DATE,CUS_ID,PRICING_ID) values
(101,1500,'2021-10-06',2,1),(102,1000,'2021-10-12',3,5),(103,30000,'2021-09-16',5,2),
(104,1500,'2021-10-05',1,1),(105,3000,'2021-08-16',4,3),(106,1450,'2021-08-18',1,9),
(107,789,'2021-09-01',3,7),(108,780,'2021-09-07',5,6),(109,3000,'2021-09-10',5,3),
(110,2500,'2021-09-10',2,4),(111,1000,'2021-09-15',4,5),(112,789,'2021-09-16',4,7),
(113,31000,'2021-09-16',1,8),(114,1000,'2021-09-16',3,5),(115,3000,'2021-09-16',5,3),
(116,99,'2021-09-17',2,14);

insert into Rating(RAT_ID,ORD_ID,RAT_RATSTARS) values
(1,101,4),(2,102,3),(3,103,1),(4,104,2),(5,105,4),(6,106,3),(7,107,4),(8,108,4),(9,109,3),(10,110,5),
(11,111,3),(12,112,4),(13,113,2),(14,114,1),(15,115,1),(16,116,0);

/*4) Display the total number of customers based on gender who have placed individual orders of worth 
at least Rs.3000.*/
Select count(c.Cus_Id) as Total_No_Of_Customers,c.CUS_GENDER from customer c INNER JOIN (
select Cus_Id from torder where ORD_AMOUNT>=3000) as ord on c.CUS_ID=ord.CUS_ID group by CUS_GENDER;

/*5) Display all the orders along with product name ordered by a customer having Customer_Id=2*/
select PRO_NAME from torder t INNER JOIN
(select PRO_NAME,PRICING_ID from supplier_pricing sup INNER JOIN
(select PRO_ID,PRO_NAME from product) as pname on sup.PRO_ID=pname.PRO_ID)
as ord on t.PRICING_ID=ord.PRICING_ID where CUS_ID=2;

/*6) Display the Supplier details who can supply more than one product.*/
select SUPP_ID, SUPP_NAME, SUPP_CITY, SUPP_PHONE  from product P INNER JOIN
(select sp.SUPP_ID, SUPP_NAME, SUPP_CITY, SUPP_PHONE,sp.PRO_ID from supplier_pricing SP INNER JOIN
(select* from supplier) as S on S.SUPP_ID=SP.SUPP_ID) as PRO on PRO.PRO_ID=P.PRO_ID 
group by (SUPP_ID) having count(p.PRO_ID)>1;

/* 7) Find the least expensive product from each category and print the table with category id, name, 
product name and price of the product. */
select C.CAT_ID,CAT_NAME,min(PRO_NAME) as PRO_NAME,min(PRICE) from category C INNER JOIN
(select CAT_ID,PRO_NAME,PRICE from Product P INNER JOIN
(select SUPP_PRICE as price,PRO_ID from supplier_pricing)as SP on SP.PRO_ID=P.PRO_ID) as CAT
ON C.CAT_ID=CAT.CAT_ID group by CAT_ID order by CAT_ID ;

select CAT_ID, CAT_NAME,min(PRO_NAME) as PRO_NAME, min(SUPP_PRICE) from supplier_pricing SP INNER JOIN
(select p.CAT_ID, PRO_NAME,CAT_NAME,PRO_ID from Product P INNER JOIN
(select* from category) as C on C.CAT_ID=P.CAT_ID) 
as CAT on SP.PRO_ID=CAT.PRO_ID group by CAT_ID order by CAT_NAME;

/*8) Display the Id and Name of the Product ordered after “2021-10-05”.*/
select PRO_ID,PRO_NAME from torder O INNER JOIN
(select PRICING_ID,SP.PRO_ID,PRO_NAME from supplier_pricing SP INNER JOIN
(select PRO_ID,PRO_NAME from product) as P on P.PRO_ID=SP.PRO_ID)
as SP ON SP.PRICING_ID=O.PRICING_ID where ORD_DATE>'2021-10-5'

/*9) Display customer name and gender whose names start or end with character'A'.*/

select CUS_NAME, CUS_GENDER from customer where CUS_NAME like 'A%' or CUS_NAME like'%A'; 

/*10)Create a stored procedure to display supplier id,name,Rating(Average rating of all the products sold
by every customer)and Type_of_Service.For Type_of_Service,If rating =5,print “Excellent Service”,
If rating >4 print “Good Service”, If rating >2 print “Average Service” else print
“Poor Service”. Note that there should be one rating per supplier.*/
delimiter $$
use ecommerce $$
create PROCEDURE SUPP_SERVICE1()
begin
select 
	supp_id as SUPPLIER_ID,    supp_name as SUPPLIER_NAME,     AverageRating,
    CASE
		WHEN AverageRating = 5 THEN 'Excellent Service'
		WHEN AverageRating > 4 THEN 'Good Service'
        WHEN AverageRating > 2 THEN 'Average Service'
        ELSE 'Poor Service'
    END as Type_of_Service
from 
	(		select s.supp_id,s.supp_name,avg(r.rat_ratstars) as AverageRating			
		from rating r
			inner join torder o 
			inner join supplier_pricing sp
			inner join supplier s on (
            r.ord_id = o.ord_id and o.pricing_id = sp.pricing_id and sp.supp_id = s.supp_id)
			group by supp_id order by supp_id		
) as R_O_SP_S ;
END $$
call SUPP_SERVICE1();