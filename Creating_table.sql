create table sale (
Invoice_id varchar(50) not null primary key, 
Branch varchar(50) not null,
City varchar(50) not null,
Customer_type	varchar(50) not null,
Gender	varchar(50) not null,
Product_line varchar(50) not null,
Unit_price	decimal(10,2) not null,
Quantity int not null,	
VAT float(6,4) not null,
Total decimal(12,4) not null,	
Date datetime not null,
Time time not null,	
Payment_method varchar(50) not null,
cogs decimal(10,2)	not null,
gross_margin_percentage	float(11,9),
gross_income decimal(12,4)	not null,
Rating float(2,1) not null

);

select * from sale;