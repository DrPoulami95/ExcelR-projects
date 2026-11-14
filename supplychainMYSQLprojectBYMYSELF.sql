---------------------------------- TOTAL ORDER ------------------------------------------------
select count(ï»¿Order_ID) as TOTAL_ORDER from supplychain_fact_orders;

------------------------------------------- TOTAL SALES REVENUE -----------------------------------------------
select round(sum(Revenue),2) as TOTAL_SALES_REVENUE from supplychain_fact_orders;

------------------------------------------- STOCK ON HAND ---------------------------------------------------------
select sum(Stock_On_Hand) as STOCK_ON_HAND from supplychain_fact_inventory;

-------------------------------------------- AVERAGE FILL RATE % ------------------------------------------------
select round(AVG(Fill_Rate_Pct),2) as AVERAGE_FILL_RATE_PERCENTAGE from supplychain_fact_orders;

-------------------------------------------- ON TIME DELIVERY % ----------------------------------------------------
select distinct delivery_status from supplychain_fact_orders;
select round(count(case
when Delivery_Status= 'On-Time' then 1 
end)*100/count(*),2) as ON_TIME_DELIVERY_PERCENTAGE from supplychain_fact_orders;

------------------------------------------- REORDER STATUS ----------------------------------------------------------
select round(sum(case
when Stock_On_Hand>Reorder_Level then 1
end)*100/count(ï»¿Product_ID),2) as REORDER_STATUS From supplychain_fact_inventory;

-------------------------------------------- ORDER BY REGION --------------------------------------------------------
select c.Customer_Region, count(o.ï»¿Order_ID) as ORDER_COUNT
from supplychain_dim_customer c
inner join supplychain_fact_orders o
on c.ï»¿Customer_ID=o.Customer_ID
group by c.Customer_Region
order by ORDER_COUNT desc;

-------------------------------------------- TOP 5 CITIES BY SALES --------------------------------------------------------
select c.Customer_City, round(sum(o.Revenue),2) as TOTAL_SALES
from supplychain_dim_customer c
left join supplychain_fact_orders o
on c.ï»¿Customer_ID=o.Customer_ID
group by c.Customer_City
order by TOTAL_SALES desc
limit 5;

----------------------------------------------- ORDERS BY SHIP-MODE ----------------------------------------------------------
select Ship_Mode, count(ï»¿Order_ID) as TOTAL_ORDERS
from supplychain_fact_orders
group by Ship_Mode
order by TOTAL_ORDERS desc;

---------------------------------------------- AVERAGE LEAD TIME BY SHIP-MODE ------------------------------------------------------
SELECT Ship_Mode, round(avg(datediff(actual_delivery_date, order_date)),2) as AVERAGE_LEAD_TIME from
supplychain_fact_orders
group by Ship_Mode
order by AVERAGE_LEAD_TIME asc;

--------------------------------------------------- FORECAST VS ACTUAL DEMAND -------------------------------------------------------------
SELECT monthname(Order_Date), sum(order_quantity) as ORDERED_QUANTITY, sum(shipped_quantity) as SHIPPED_QUANTITY
from supplychain_fact_orders
group by monthname(Order_Date)
order by monthname(Order_Date);

