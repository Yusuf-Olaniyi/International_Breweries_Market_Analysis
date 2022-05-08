create table International_brewries(
SALES_ID INT NOT NULL,
SALES_REP VARCHAR(50),
EMAILS VARCHAR(50),
BRANDS VARCHAR(50),
PLANT_COST INT,
UNIT_PRICE INT,
QUANTITY INT,
COST INT,
PROFIT INT,
COUNTRIES VARCHAR(50),
REGION VARCHAR(50),
MONTH VARCHAR(50),
YEARS INT
);

SELECT * 
FROM International_brewries;

copy International_brewries (SALES_ID,SALES_REP,EMAILS,BRANDS,PLANT_COST,UNIT_PRICE,QUANTITY,COST,PROFIT,COUNTRIES,REGION,MONTH,YEARS) 
FROM 'C:\Users\Yusuf Olaniyi\Downloads\International_Breweries.csv' delimiter ',' csv header;

-- PROFIT ANALYSIS
--1. Within the space of the last three years, what was the profit worth of the breweries,inclusive of the anglophone and the francophone territories?
select sum(profit) as total_profit
from international_brewries;

--2. Compare the total profit between these two territories in order for the territory manager,Mr. Stone made a strategic decision that will aid profit maximization in 2020
-- To get the list of countries.
select distinct countries
from international_brewries;

select sum(profit) as francophone_profit,(select sum(profit) as anglophone_profit from international_brewries where countries in ('Nigeria','Ghana'))
from international_brewries
where countries in ('Benin','Senegal','Togo');

--3. Country that generated the highest profit in 2019
select countries, sum(profit) as profit_of_country
from international_brewries
where years = 2019
group by countries
order by sum(profit) desc
limit 1;

--4. Help him find the year with the highest profit.
select years, sum(profit) as profit_per_year
from international_brewries
group by years
order by sum(profit) desc
limit 1;


--5. Which month in the three years was the least profit generated?
select month, sum(profit) as profit_per_month
from international_brewries
group by month
order by sum(profit)
limit 1;

--6. What was the minimum profit in the month of December 2018?
select profit
from international_brewries
where month = 'December' and years = 2018
order by profit
limit 1;

--7. Compare the profit in percentage for each of the month in 2019

select month,sum(profit),sum(profit) * 100 / (select sum(profit) from international_brewries where years = 2019) as percentage_profit
from international_brewries
where years = 2019
group by 1
order by 2,3 --I observed the values are approximated to nearest whole number how can I make it return some decimals imstead so it can all sum to 100% 


--8. Which particular brand generated the highest profit in Senegal?
select brands,sum(profit) as profit
from international_brewries
where countries = 'Senegal'
group by brands
order by sum(profit) desc
limit 1;

-- BRAND ANALYSIS
--1. Within the last two years, the brand manager wants to know the top three brand consumed in the francophone countries
select brands, sum(quantity) as francophone_consumption_rate
from international_brewries
where countries in ('Benin','Senegal','Togo') and years between 2018 and 2019
group by brands
order by sum(quantity) desc
limit 3;

--2. Find out the top two choice of consumer brands in Ghana
select brands, sum(quantity) as Ghana_consumption_rate
from international_brewries
where countries = 'Ghana'
group by brands
order by sum(quantity) desc
limit 2;

--3. Find out the details of beers consumed in the past three years in the most oil reached country in West Africa.
select brands,sum(quantity) as consumption_rate,sum(profit) as profit_made
from international_brewries
where countries = 'Nigeria'--Nigeria is the only west African country in the countries in th database that has oil.
group by 1
order by 2,3;

--4. Favorites malt brand in Anglophone region between 2018 and 2019
select brands,region,countries,sum(quantity) as consumption_rate
from international_brewries
where brands like '%malt' and years in (2018,2019) and countries in ('Nigeria','Ghana')
group by 1,2,3;


--5. Which brands sold the highest in 2019 in Nigeria?
select brands,sum(quantity) as quantity_sold
from international_brewries
where years = 2019 and countries = 'Nigeria'
group by brands
order by sum(quantity) desc
limit 1;

--6. Favorites brand in South_South region in Nigeria
select brands,sum(quantity) as favorite_brand
from international_brewries
where region = 'southsouth' and countries = 'Nigeria'
group by brands
order by sum(quantity) desc
limit 1;

--7. Bear consumption in Nigeria
select sum(quantity) as beer_consumed
from international_brewries
where countries = 'Nigeria';

--8. Level of consumption of Budweiser in the regions in Nigeria
select region, sum(quantity) as Budweiser_consumed
from international_brewries
where countries = 'Nigeria' and brands = 'budweiser'
group by region;

--9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
select region, sum(quantity) as Budweiser_consumed 
from international_brewries
where countries = 'Nigeria' and brands = 'budweiser' and years = 2019
group by region;

 
-- COUNTRIES ANALYSIS
--1. Country with the highest consumption of beer.
select countries,sum(quantity) as beer_per_country
from international_brewries
group by countries
order by 2 desc
limit 1;

--2. Highest sales personnel of Budweiser in Senegal
select sales_rep,max(quantity) as quantity_sold
from international_brewries
where countries = 'Senegal' and brands = 'budweiser'
group by sales_rep
order by 2 desc
limit 1;

--3. Country with the highest profit of the fourth quarter in 2019
select countries,sum(profit)
from international_brewries
where years = 2019 and month in ('October','November','December')
group by countries
order by 2 desc
limit 1;






