describe zomato_data;
select count(*) from zomato_data;
select count(*) as total_rows from zomato_data;
select count(*) as total_rows from calender_table;
describe calender_table;
create table Country_table(country_code int, country varchar(50));
insert into Country_table values(1,'India'),(14,'Australia'),(30,'Brazil'),(37,'Canada'),(94,'Indonesia'),(148,'New Zealand'),(162,'Phillipines'),(166,'Qatar'),(184,'Singapore'),
(189,'South Africa'),(191,'Sri Lanka'),(208,'Turkey'),(214,'UAE'),(215,'United Kingdom'),(216,'United States');
select * from country_table;
select * from zomato_data;

----- Numbers of resturants based on country -----

select c.country, count(z.ï»¿RestaurantID) as number_of_restaurants
from country_table c
inner join zomato_data z
on c.Country_Code = z.countrycode
group by c.country
order by number_of_restaurants desc;

------ Top 10 Cities restuarants count wise --------

select city, count(ï»¿RestaurantID) as Restaurant_count
from zomato_data
group by city
order by Restaurant_count desc
limit 10;

------------- total number of Restaurants --------

select count(ï»¿RestaurantID) as total_number_of_restaurants
from zomato_data;

----------- number of restaurants opening year wise

select distinct year(datekey_Opening), count(ï»¿RestaurantID) as Count_Of_Restaurants_opening
from zomato_data
group by year(Datekey_Opening)
order by year(Datekey_opening) asc;

-------- number of restaurants opening quarterly --------

select distinct Quarter,count(*) AS total_resturants
from calender_table
group by Quarter
order by Quarter asc;

select concat('Q', Quarter(Datekey_Opening)) as Quarter, count(ï»¿RestaurantID) AS total_resturants_opening
from zomato_data
group by Quarter
order by Quarter asc;

-------------- number of restaurants opening monthly ---------------

select distinct monthname(datekey_Opening) as Month, count(ï»¿RestaurantID) as Restaurants_Opening
from zomato_data
group by monthname(datekey_opening)
order by monthname(datekey_opening) asc;

---------- number of restaurants opening yearly, monthly, quarterly -------------

select Distinct year(Datekey_Opening) as year,
monthname(Datekey_Opening) as month,
concat('Q',
quarter(Datekey_Opening)) as quarter,
count(ï»¿RestaurantID) as total_restaurants
from zomato_data
group by year, month, quarter
order by year, month, quarter;

----------------------------- COUNT OF RESTAURANT BASED ON AVERAGE RATING ---------------------------

SELECT Rating, COUNT(ï»¿RestaurantID) AS Restaurant_Count
FROM Zomato_data
GROUP BY Rating with rollup
ORDER BY Rating ASC;

-------------------------------------- restaurant count based on rating bucket ------------------------------------

select case
when Rating<=2 then 'poor'
when Rating<=3 then 'Average'
when Rating<=4 then 'Good'
else 'Excellent'
end as RatingCategory,
count(*) as Restaurant_count
from zomato_data
group by case
when Rating<=2 then 'poor'
when Rating<=3 then 'Average'
when Rating<=4 then 'Good'
else 'Excellent'
end with rollup
order by Restaurant_count desc;



----------------------  Average Price of reasonable size resturants falling in each buckets-----------------------

SELECT 
CASE 
        WHEN Average_Cost_for_two <= 500 THEN '0 - 500'
        WHEN Average_Cost_for_two > 500 AND Average_Cost_for_two <= 1000 THEN '501 - 1000'
        WHEN Average_Cost_for_two > 1000 AND Average_Cost_for_two <= 1500 THEN '1001 - 1500'
        WHEN Average_Cost_for_two > 1500 AND Average_Cost_for_two <= 2000 THEN '1501 - 2000'
        ELSE '2000+' 
    END AS Price_Bucket,
    COUNT(*) AS Restaurant_Count
FROM 
    Zomato_data
GROUP BY CASE 
        WHEN Average_Cost_for_two <= 500 THEN '0 - 500'
        WHEN Average_Cost_for_two > 500 AND Average_Cost_for_two <= 1000 THEN '501 - 1000'
        WHEN Average_Cost_for_two > 1000 AND Average_Cost_for_two <= 1500 THEN '1001 - 1500'
        WHEN Average_Cost_for_two > 1500 AND Average_Cost_for_two <= 2000 THEN '1501 - 2000'
        ELSE '2000+' 
    END
order by restaurant_Count desc;

    
     ---------------------- Percentage of Resturants based on "Has_Table_booking"-------------------------------
   
    SELECT Has_Table_booking,
COUNT(*) AS Restaurant_Count,
CONCAT(ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 2), '%') AS Percentage
FROM Zomato_data 
GROUP BY Has_Table_booking;

select Has_Table_booking, count(*) as Restaurant_count,
round(count(*)*100/(select count(*) from zomato_data),2) as percentage
from zomato_data
group by Has_Table_booking;

--------------------- Percentage of Resturants based on "Has_Online_delivery"-------------------------------

select Has_Online_delivery,
count(*) as Restaurant_Count,
 round(count(*)*100/(select count(*) from zomato_data),2) as percentage
 FROM Zomato_data 
GROUP BY Has_Online_delivery;
    
---------------------------- Charts based on Cusines, City, Ratings----------------------------------------------

SELECT Cuisines,COUNT(*) AS Restaurant_Count,ROUND(AVG(Rating), 2) AS Average_Rating
FROM Zomato_data 
GROUP BY Cuisines 
HAVING COUNT(*) >= 10 
ORDER BY Restaurant_Count DESC 
LIMIT 5;

-------------------------------------------------- Country count -----------------------------------------------------------

select count(distinct Country) as Country_count
from country_table;

select distinct Country
from country_table;

------------------------------------------------------ City Count --------------------------------------------------------------

select count(distinct City) as City_count
from zomato_data;

select distinct City
from zomato_data
order by City;


--------------------------------------- number of restaurants by country and city ------------------------------------------------------------

select c.country, z.city, count(*) as Total_number_of_restaurants
from zomato_data z
inner join country_table c
on z.Countrycode= c.Country_code
group by c.country, z.City
order by c.country, Total_number_of_restaurants desc;


---------------------------------------------------------- cuisine wise restaurants ------------------------------------------------------------

select cuisines, count(*) as restaurant_count
from zomato_data
group by cuisines with rollup
order by restaurant_count desc;

---------------------- total count of cuisines -----------------------------

select count(distinct cuisines) as cuisines
from zomato_data;


---------------------- rating distribution ---------------

select Rating, count(*) as Restaurant_count
from zomato_data
group by Rating with rollup
order by Rating asc;

-------------------------------------------- Average rating -------------------------------------------

select round(avg(Rating),2) as Average_Rating from zomato_data;





























