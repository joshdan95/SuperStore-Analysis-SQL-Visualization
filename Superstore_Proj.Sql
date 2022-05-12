
-- Superstore Data Profit Analysis

select* from
superstore_data;

--State wise profit
select state, cast(sum(profit)as decimal(10,2)) as state_wise_profit
from superstore_data
group by state
order by 2 desc;

--Average profit by states. 
select t.*, case when avg_profit_perstate >=0 then 'profit'
     when avg_profit_perstate <0 then 'loss'
	 end as 'P_&_L' from
	 (select
      state, cast(avg(Profit)as decimal(10,2)) as avg_profit_perstate
      from superstore_data
      group by State) t
order by 2 desc;


--Average profit by region
select t.*, case when avg_profit_per_region >=0 then 'profit'
     when avg_profit_per_region <0 then 'loss'
	 end as 'P_&_L' from
	 (select
      Region, cast(avg(Profit)as decimal(10,2)) as avg_profit_per_region
      from superstore_data
      group by Region) t
order by 2 desc;


--AVG Profit per Age Range

select age_range, avg(Profit) as avg_profit 
from
(
	select profit,
		case  when cust_age >40 and cust_age <= 50 then '40 to 50'
	         when cust_age >50 and cust_age <= 60 then '50 to 60'
			 when cust_age >50 and cust_age <= 60 then '50 to 60'
			 when cust_age >60 and cust_age <= 70 then '60 to 70'
			 when cust_age >70 and cust_age <= 80 then '70 to 80'
			 when cust_age >80 and cust_age <= 90 then '80 to 90'
			 when cust_age >90 and cust_age <= 100 then '90 to 100'
			 end 'age_range'
	from
	(select [Customer Age] as cust_age, profit
		from superstore_data
		where[Customer Age]is not null
		group by [Customer Age], Profit)x
)y
group by age_range
order by age_range;

--Regional quarterly avg profit
select Region, DATEPART(year,orderdate_conv) as Year, DATEPART(qq,orderdate_conv) as Quarter, avg(Profit) as avg_profit
from superstore_data
group by  Region, DATEPART(year,orderdate_conv),  DATEPART(qq,orderdate_conv)
order by region, DATEPART(qq,orderdate_conv), year(orderdate_conv) asc;

-- Average profit by product sub-category

select avg(profit) as Average_profit, [Product Sub-Category]
from superstore_data
group by [Product Sub-Category];

-- Top 10 products by avg.profit
select avg(profit) as Average_profit, [Product Name]
from superstore_data
group by [Product Name]
order by Average_profit desc;


--Avg.Sales
select cast(avg(sales)as decimal(10,2)) as avg_sales
from superstore_data;

--Avg.Profit
select cast(avg(Profit)as decimal(10,2)) as avg_profit_overall
from superstore_data;

--Avg.Discount
select cast(avg(Discount)as decimal(10,2)) as avg_discount
from superstore_data;

