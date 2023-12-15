-- Future engineering -- 

-- time_of_date
Select time,
 (case 
    when `time` between "00:00:00" and "12:00:00" then "Morning"
    when `time` between "12:01:00" and "16:00:00" then "Afternoon"
    else "Evening"
  end
 )as Time_of_date
from sale;

alter table sale 
add column time_of_day varchar(20);

update sale 
set time_of_day = (case 
    when `time` between "00:00:00" and "12:00:00" then "Morning"
    when `time` between "12:01:00" and "16:00:00" then "Afternoon"
    else "Evening"
  end
);

select * from sale;

-- day_name
select date,
dayname(date)
from sale;

alter table sale
add column day_name varchar(10);

update sale 
set day_name = dayname(date);

-- month_name
select date,
monthname(date)
from sale;

alter table sale
add column month_sale varchar(10);

update sale
set month_sale=monthname(date);

select * from sale;

-- Exploratory Data Analysis (EDA) -- 
 
 -- Product -- 
 
 -- How many unique cities does the data have?
 select distinct city from sale;
 
-- In which city is each brach ?
select distinct city ,branch
from sale;

-- How many unique product lines does the data have ?
select distinct product_line 
from sale;

-- What is the most common payment method -- 
select payment_method,count(Payment_method) as count 
from sale
group by Payment_method
order by count desc;

-- What is the most selling product lines ?
select product_line,count(Product_line) as count
from sale
group by Product_line
order by count desc;

-- what is the total revenue by month?
select month_sale,sum(total) as total_revenue
from sale
group by month_sale
order by total_revenue;

-- What month has the largest COGS?
select month_sale, sum(cogs) as sales
from sale
group by month_sale
order by sales desc;

-- Which product line has the largest revenue?
select product_line , sum(total) as total
from sale
group by Product_line
order by total desc;

-- Which city have the largest revenue
select city, sum(total) as revenue
from sale 
group by city 
order by revenue desc;

-- Which product line has the highest VAT?
select product_line, sum(vat) as total_VAT
from  sale
group by Product_line
order by Total_VAT desc;


-- Fetch each product line and add a column to those product line showing "good","bad",Good if it is greater that average sales ?
SELECT
  product_Line,
  Total,
  CASE
    WHEN `total` > AVG(total) OVER (PARTITION BY product_Line) THEN 'good'
    ELSE 'bad'
  END AS sales_evaluation
FROM
  sale;


-- Which branch sold more products  than average product sold?
select distinct branch, round(avg(quantity),1) as avg_product_sold
from sale
group by branch
having round(avg(quantity),1) > (select round(avg(quantity),1) from sale);

select round(avg(quantity),1) from sale;

-- What is the common product line by gender ?
select gender, product_line ,count(Product_line) as cnt
from sale 
group by gender,product_line
order by cnt desc;

-- What is the average rating of each product line?
select product_line , round(avg(rating),2) as avg_rating
from sale
group by Product_line
order by avg_rating desc;

-- Sales -- 

-- Number of sales made in each time of the day per week ?
select time_of_day ,count(total) as total_sales
from sale
where day_name in ("monday")
group by time_of_day
order by total_sales desc;

-- Which of customer type brings the most revenue -- 
select  customer_type , round(sum(total),2) as total_revenue
from sale
group by Customer_type
order by total_revenue desc;

-- Which city has the largest tax percentage /VAT?
select city , round(sum(vat),2) as most_VAT
from sale
group by city 
order by most_VAT desc;

-- Which customer type pays the most in VAT ?
select customer_type,round(sum(VAT),2) as total_vat
from sale
group by Customer_type
order by total_vat desc;

-- Customers-- 

-- How many unique customers type does the data have --
select customer_type , count(Customer_type) as members
from sale 
group by Customer_type;

-- How many unique payment type does the data have ?
select payment_method ,count(Payment_method) as total_payment_method
from sale
group by Payment_method;

-- What is the most common customer type ?
select customer_type, count(customer_type) as uniqe
from sale
group by Customer_type 
order by uniqe desc;

-- What is the gender of the most of the customers ?
select gender, count(Gender) as most_gender 
from sale
group by gender
order by most_gender desc;

-- What is the gender distribution  per branch ? 
select branch , gender ,count(gender) as total_gen
from sale
group by Branch,gender 
order by branch,total_gen desc;

-- Which time of the day do customers give most ratings ?
select time_of_day , round(avg(rating),2) as avg_rating
from sale
group by time_of_day
order by avg_rating desc;

-- Which time of the day do customers give most ratings per branch ?
select branch,time_of_day , round(avg(rating),2) as avg_rating
from sale
group by branch, time_of_day
order by branch,avg_rating desc;

-- Which day of the week has the best avg rating ?
select day_name, round(avg(rating),2) as avg_rating
from sale
group by day_name
order by avg_rating desc;

-- Which day of the week has the best avg rating ?
select branch,day_name, round(avg(rating),2) as avg_rating
from sale
group by branch,day_name
order by Branch, avg_rating desc;