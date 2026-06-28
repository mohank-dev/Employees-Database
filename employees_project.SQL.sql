create database ecom;
use ecom;
select * from ecom.ecommercee;
##Q1. What is the total sales revenue?
##

select sum(Final_Price)
				from
					ecom.ecommercee;
#Q2. Which product category generates the highest sales?  
select Category, 
			sum(Final_Price) AS total_sales	
							from ecom.ecommercee group by Category 	
															order by total_sales
																		desc limit 1;
#Top 10 best-selling products
select Product_ID, sum(Final_Price)
			as total_sales from ecom.ecommercee
                              group by Product_ID
											order by total_sales desc limit 10;
alter table ecom.ecommercee 
            change column `ï»¿User_ID` User_ID text;
	#Which month has highest sales?		
    select * from ecom.ecommercee;
SELECT extract(month from Purchase_Date) AS order_month,
       SUM(Final_Price) AS monthly_revenue
FROM ecom.ecommercee
GROUP BY order_month
ORDER BY order_month;

#Customer Analytics Questions
#Q5. Which customer segment spends the most?
select User_ID,  
				sum(Final_Price) as total_price
                       from ecom.ecommercee 
                               group by User_ID order by total_price desc 
                                                              limit 1 ;
describe ecom.ecommercee;
#Q6. Top 5 customers by revenue
       select User_ID,  
				round(sum(Final_Price)) as total_price
                       from ecom.ecommercee 
                               group by User_ID order by total_price desc 
                                                              limit 5 ;   
  # REPEAT CUSTOMERS
       select Product_ID, count(user_id) from ecom.ecommercee group by Product_ID
                  having count(user_id) > 1;
                #  
                SELECT *
FROM ecom.ecommerce
WHERE Final_Price > (
    SELECT AVG(Final_Price)
    FROM ecom.ecommerce
);
#Find all products that belong to categories where the average discount is above 20%.

SELECT *
FROM ecom.ecommerce
WHERE Category IN (
    SELECT Category
    FROM ecom.ecommerce
    GROUP BY Category
    HAVING AVG(`Discount `) > 20
);
select * from ecom.ecommercee;
##Total SUB QUERY LEARN NOW

##Find all orders where Final_Price is greater than the average order value.
select * from ecom.ecommercee
					where Final_Price >(
								select avg(Final_Price) 
											from ecom.ecommercee);
                                            
#Find all rows where Final_Price is equal to the maximum order value.
             select * from ecom.ecommercee
								where Final_Price =(
											select max(Final_Price) 
														from ecom.ecommercee);
#Find all products that belong to categories where the average discount is greater than 20%.
select * from ecom.ecommercee;
select * from ecom.ecommercee
		where category  IN (
					select Category from ecom.ecommercee 
									group by Category 
                                    having avg(Discount) > 20);
	#Find all customers whose Final_Price is greater than their own average purchase value.

select * from
		ecom.ecommercee 
				where Final_Price >(
							select avg(FInal_Price)
                            from ecom.ecommercee);

#Find all users who have made more than one purchase.
select * from ecom.ecommercee
					Where User_ID IN (
                        select User_ID from 
									ecom.ecommercee group by User_ID
                                    having count(*)>1);
#Find the month with the highest revenue.
select * from (
     select extract(month from Purchase_Date) as Monthly,
					Sum(Final_Price) as Monthly_Rev
					from ecom.ecommercee 
				group by  extract(month from Purchase_Date) )
           AS Monthly_Sales
           order by Monthly_Rev Desc Limit 1;
