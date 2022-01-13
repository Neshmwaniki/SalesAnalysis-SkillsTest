-- type by count (most productive)
--getting numbers
-- Breakdown of sellers

select type, COUNT (distinct id) as number_of_sellers
from Sellers$
group by type
order by number_of_sellers desc;

---joins

select *
from Sellers$
left join Cooker_Sales$ 
on Sellers$.id = Cooker_Sales$.seller_id
right join Fuel_Sales$
on Cooker_Sales$.customer_id = Fuel_Sales$.customer_id;


--create table KOKODataTable
--	as (select id,type,customer_id, customer_type,sale_date,sale_territory, seller_id,tx_date,litres_sold
--	from Sellers$
--	left join Cooker_Sales$ 
--	on Sellers$.id = Cooker_Sales$.seller_id
--	right join Fuel_Sales$
--	on Cooker_Sales$.customer_id = Fuel_Sales$.customer_id);



--cooker sales by seller type

select type, count(distinct customer_id) as CookersSold
from Sellers$
left join Cooker_Sales$ 
on Sellers$.id = Cooker_Sales$.seller_id
group by type;

--fuel sales

select customer_id, SUM(litres_sold) as TotalLitersSold
from Fuel_Sales$
group by customer_id;


--fuel sales by customer type

select customer_type, SUM(litres_sold) as TotalLitersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
group by customer_type;

--fuel sales and Cookers Sold by customer type

select customer_type, SUM(litres_sold) as TotalLitersSold, COUNT(distinct Cooker_Sales$.customer_id) as CookersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
group by customer_type;

----------------------------------------------------------------------------------------------------------------------------------------------------
--fuel sales by seller type
--- most productive == refferer

select type, SUM(litres_sold) as TotalLitersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type
order by TotalLitersSold desc;

-------------
--select SUM(litres_sold) as TotalLitersSold, type
--from Fuel_Sales$
--full join Cooker_Sales$
--on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
--full join Sellers$
--on Cooker_Sales$.seller_id = Sellers$.id
--group by type
--order by TotalLitersSold desc;

---- Question 1 (Sales Productivity)

use KokoData;

----- CookersSold by Type

select type,  COUNT(distinct Cooker_Sales$.customer_id) as CookersSold
from Cooker_Sales$
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type
order by CookersSold desc;


----- Fuel Sold by Type

select type, SUM(litres_sold) as TotalLitersSold
from Cooker_Sales$
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
left join Fuel_Sales$
on Cooker_Sales$.customer_id = Fuel_Sales$.customer_id
group by type
order by TotalLitersSold desc;




-------------------
select type, SUM(litres_sold) as TotalLitersSold, COUNT(distinct Cooker_Sales$.customer_id) as CookersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type
order by TotalLitersSold desc,CookersSold;



---- Question 2 (Most Productive)

--- most productive == referrer

--- ---- Question 3 most productive = most efficient?

----- CookersSold by Type
select type,  COUNT(distinct Cooker_Sales$.customer_id) as CookersSold
from Cooker_Sales$
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type
order by CookersSold desc;

-- yes. Given that Refferers are making more cooker sales and more fuel sales.

--- ---- Question 4 ---Opportunites for sales: 
-------------------
select type, SUM(litres_sold) as TotalLitersSold, COUNT(distinct Cooker_Sales$.customer_id) as CookersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type
order by TotalLitersSold desc,CookersSold;

----- Opportunities are that Agents making more fuel sales with less cooker sales compared to CSR hence increased Agents

--- sales by customer type and Territory
select customer_type, sale_territory,SUM(litres_sold) as TotalLitersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by customer_type, sale_territory
order by TotalLitersSold desc;


--- sales (Cookers and Litres) by customer type and Territory for Agents
select type, sale_territory,COUNT(distinct Cooker_Sales$.customer_id) as CookersSold, SUM(litres_sold) as TotalLitersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
where type = 'Agent'
group by type, sale_territory
order by TotalLitersSold desc, CookersSold asc;

--- Litre per cooker by territory
select type , sale_territory,sum(litres_sold)/count(distinct Cooker_Sales$.customer_id) as average_literspercooker
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type,sale_territory
order by average_literspercooker desc;

--- Litre per cooker by customer_type
select type , customer_type,sum(litres_sold)/count(distinct Cooker_Sales$.customer_id) as average_literspercooker
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type,customer_type
order by average_literspercooker desc;

--- Litre per cooker by customer_type and territory
select type , customer_type,sale_territory, sum(litres_sold)/count(distinct Cooker_Sales$.customer_id) as average_literspercooker
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type,customer_type, sale_territory
order by average_literspercooker desc;

----- focus on restaurants in North as well as HH and restaurants in south



----- increased promos & marketing of the KOKO brand for + awareness
----- subsidize subsequent refills (loyalty)



--- ---- Question 5 --- Additional Data Opportunites for sales:

--- additional data useful is on: price of cooker/fuel

--- Assumption linear relationship btwn fuel consumption relative to number of cookers
--- same cost of cooker/fuel across locations
--- same price points across customer types
--- fair commission across seller types





---- --- ---- Question 6 average fuel consumption/cooker per month for each channel

select type, sum(litres_sold)/count(distinct Cooker_Sales$.customer_id) as average_literspercooker, MONTH (tx_date) as mwezi
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type, MONTH (tx_date)
order by average_literspercooker desc;

--- Agents spend more with March and Feb being the highest spending months at 75l and 72l respectively


---- ---- --- ---- Question 7 Most Satisfied customers 

select type, sum(litres_sold)/count(distinct Cooker_Sales$.customer_id) as average_literspercooker
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type
order by average_literspercooker desc;

--- Agents produce most satisfied customers going by their month fuel consumption rates


--- ---- ---- --- ---- Question 8 differ because of: 

------ availability/closeness to customer hence more contact/personal/relatable with Agent *easy access
------ channel distr across territories 
------ more trust/return policy with agent
------ diversity of retail outlets wrt other items of sale (that support fuel consumption
------ service delivery; sales/marketing skills


--- ---- ---- --- ---- Question 9 Opportunities to increase fuel consumption
--- Average Litre per cooker and cookerssold by customer type

select type, sum(litres_sold)/count(distinct Cooker_Sales$.customer_id) as average_literspercooker, COUNT(distinct Cooker_Sales$.customer_id) as CookersSold,customer_type
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type,customer_type
order by average_literspercooker desc;


--- Average Litre per cooker and cookerssold by territory

select type, sum(litres_sold)/count(distinct Cooker_Sales$.customer_id) as average_literspercooker, COUNT(distinct Cooker_Sales$.customer_id) as CookersSold,sale_territory
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type,sale_territory
order by average_literspercooker desc;

-------- focus on Agents (HH) and Refferals (restaurants) as channels in the north and south

----- Subsidise prices i.e. discounts, scoring for bonus points/awards
----- Offer fuel for credit (on recommendation basis)
----- support retail otluets marketing e.g through billboards
----  prod improvement & diferentiation



--- --- ---- ---- --- - Question 10 Additional data that may be useful
----- What's the rate of commission across channels?
----- Is the commission similar across territories? (maybe some territories deserve different incentive approach)
----- Avg (Size) and maybe Composition of HH/restaurants across territories
----- pop size/ density of regions being targeted

--- Assumption
----- similar fuel consumption across time (i.e. no cases of high demand/low supply)
























--- sales by customer type and Territory
select customer_type, sale_territory,SUM(litres_sold) as TotalLitersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by customer_type, sale_territory
order by TotalLitersSold desc;


--- sales (Cookers and Litres) by customer type and Territory for Agents
select type, sale_territory,COUNT(distinct Cooker_Sales$.customer_id) as CookersSold, SUM(litres_sold) as TotalLitersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
where type = 'Agent'
group by type, sale_territory
order by TotalLitersSold desc, CookersSold asc;


select type,sale_territory, SUM(litres_sold) as TotalLitersSold, COUNT(distinct Cooker_Sales$.customer_id) as CookersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type,sale_territory
order by TotalLitersSold desc,CookersSold asc ;



--- standard size of HH
--- not much difference between gender of 



--- sales by type and Territory
select type, sale_territory,SUM(litres_sold) as TotalLitersSold
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type, sale_territory
order by TotalLitersSold desc;



--- average monthly fuel consumption per cooker for each channel
---- fuel consumption, Cookers Sold per month

select type, COUNT(distinct Cooker_Sales$.customer_id) as CookersSold, SUM(litres_sold) as TotalLitersSold, MONTH (tx_date) as mwezi
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type, MONTH (tx_date)
order by TotalLitersSold desc, CookersSold asc;


---- average fuel consumption per month

--select type, COUNT(distinct Cooker_Sales$.customer_id) as CookersSold, AVG(litres_sold) as TotalLitersSold, MONTH (tx_date) as mwezi
--from Fuel_Sales$
--left join Cooker_Sales$
--on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
--left join Sellers$
--on Cooker_Sales$.seller_id = Sellers$.id
--group by type, MONTH (tx_date)
--order by TotalLitersSold desc, CookersSold asc;


---- fuel consumption per month

select type, sum(litres_sold) as TotalLitersSold, MONTH (tx_date) as mwezi
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type, MONTH (tx_date)
order by TotalLitersSold desc;



---- average fuel consumption/cooker per month for each channel across territories
 
select type,sale_territory, sum(litres_sold)/count(distinct Cooker_Sales$.customer_id) as average_literspercooker, MONTH (tx_date) as mwezi
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type, sale_territory, MONTH (tx_date)
order by average_literspercooker desc;

---- average fuel consumption/cooker per month for each channel across cust type
 
select type,customer_type, sum(litres_sold)/count(distinct Cooker_Sales$.customer_id) as average_literspercooker, MONTH (tx_date) as mwezi
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type, customer_type, MONTH (tx_date)
order by average_literspercooker desc;



select type, sum(litres_sold) as total_literspercooker,count(distinct Cooker_Sales$.customer_id) as cookersSold, MONTH (tx_date) as mwezi
from Fuel_Sales$
left join Cooker_Sales$
on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
left join Sellers$
on Cooker_Sales$.seller_id = Sellers$.id
group by type, MONTH (tx_date)
order by total_literspercooker desc;












--select type, sum(litres_sold) as TotalLitersSold/COUNT(Cooker_Sales$.customer_id) as CookersSold, MONTH (tx_date) as mwezi
--from Fuel_Sales$
--left join Cooker_Sales$
--on Fuel_Sales$.customer_id = Cooker_Sales$.customer_id
--left join Sellers$
--on Cooker_Sales$.seller_id = Sellers$.id
--group by type,CookersSold, MONTH (tx_date)
--order by TotalLitersSold desc;

