CREATE DATABASE GlobalAirQuality;

use GlobalAirQuality

alter table [dbo].[Air_Quality]
alter column Date Date


alter table [dbo].[Brasilia_Air_Quality]
alter column Date Date

alter table [dbo].[Cairo_Air_Quality]
alter column Date Date

alter table [dbo].[Dubai_Air_Quality]
alter column Date Date

alter table [dbo].[London_Air_Quality]
alter column Date Date

alter table [dbo].[New_York_Air_Quality]
alter column Date Date


alter table [dbo].[Sydney_Air_Quality]
alter column Date Date


select * from [dbo].[Air_Quality]

select * from [dbo].[Brasilia_Air_Quality]

select * from [dbo].[Cairo_Air_Quality]

select * from [dbo].[Dubai_Air_Quality]

select * from [dbo].[London_Air_Quality]

select * from [dbo].[New_York_Air_Quality]

select * from [dbo].[Sydney_Air_Quality]


----------------------------------------------------------------------------------------------------------------
--------------------------------------------------Queries-------------------------------------------------------
----------------------------------------------------------------------------------------------------------------


-----Q1) Retrive all data from the Brasilia air quality table.

	select * from [dbo].[Brasilia_Air_Quality]

-----Q2) Get the average PM2.5 levels in Cairo.

	select AVG(PM2_5) as AvgPM_Levels 
	from [dbo].[Cairo_Air_Quality];

-----Q3) Find the maximum NO2 levels in Dubai

	select MAX(NO2) as Max_NO2 from [dbo].[Dubai_Air_Quality]

-----Q4) Count the number of rows in London Air Quality table

	select COUNT(*) as row_count from [dbo].[London_Air_Quality]

-----Q5) Get the minimum CO levels in Newyork

	select MIN(CO) as min_CO from [dbo].[New_York_Air_Quality]

----Q6) Find the avg PM10 levels in sydeny for the last 30 days.

	select AVG(PM10) as avg_PM10 from [dbo].[Sydney_Air_Quality]
	where Date >= DATEADD(day, -30, getdate());

----Q7) Find the city with highest avg PM2.5 levels across all cities.


	select City, AVG(PM2_5) as avg_PM2_5
	from (
		select *from [dbo].[Air_Quality]
		) as sub
	group by City
	order by avg_PM2_5 DESC;

-----Q8) Get the top 5 days with the highest SO2 levels in Brasilia.

	select top 5 Date, SO2 from [dbo].[Brasilia_Air_Quality]
	order by SO2 DESC

	
	select top 5 Cast(Date AS date) as Date, SO2 from [dbo].[Brasilia_Air_Quality]
	order by SO2 DESC

	
	select top 5 Datename(WEEKDAY, Date) as Day, SO2 from [dbo].[Brasilia_Air_Quality]
	order by SO2 DESC

----Q9) Get the number of days with good air quality (AQI < 50) in london.

	select COUNT(*) As good_air_quality_days
	from [dbo].[London_Air_Quality]
	where AQI < 50;
	
----Q10) Get the top 3 cities with the highest avg AQI levels.

	select top 3 City, AVG(AQI) AS avg_aqi 
	from (
		select 'Brasilia' As City, AQI from [dbo].[Brasilia_Air_Quality]
		union all
		select 'Cairo' as City, AQI from [dbo].[Cairo_Air_Quality]
		union all
		select 'Dubai' as City, AQI from [dbo].[Dubai_Air_Quality]
		union all
		select 'London' as City, AQI from [dbo].[London_Air_Quality]
		union all
		select 'Newyork' as City, AQI from [dbo].[New_York_Air_Quality]
		union all
		select 'Sydney' as City, AQI from [dbo].[Sydney_Air_Quality]
	) as subquery
	Group by City
	Order by avg_aqi DESC;

-----Q11) Find the city with most significant improvement in air quality over the past year.

	with avg_AQI_last_year AS (
		select City, AVG(AQI) as avg_AQI_last_year
		from ( 
			select 'Brasilia' As City, AQI, Date from [dbo].[Brasilia_Air_Quality]
			union all
			select 'Cairo' as City, AQI, Date from [dbo].[Cairo_Air_Quality]
			union all
			select 'Dubai' as City, AQI, Date from [dbo].[Dubai_Air_Quality]
			union all
			select 'London' as City, AQI, Date from [dbo].[London_Air_Quality]
			union all
			select 'Newyork' as City, AQI, Date from [dbo].[New_York_Air_Quality]
			union all
			select 'Sydney' as City, AQI, Date from [dbo].[Sydney_Air_Quality]
		) as subquery
		where Date >= DATEFROMPARTS(YEAR(GETDATE()), -1, 1)
			AND Date < DATEFROMPARTS(YEAR(GETDATE()), -1, 1)
		group by City
	),
	avg_AQI_current_year as ( 
		select City, AVG(AQI) as avg_AQI_current_year
		from ( 
			select 'Brasilia' As City, AQI, Date from [dbo].[Brasilia_Air_Quality]
			union all
			select 'Cairo' as City, AQI, Date from [dbo].[Cairo_Air_Quality]
			union all
			select 'Dubai' as City, AQI, Date from [dbo].[Dubai_Air_Quality]
			union all
			select 'London' as City, AQI, Date from [dbo].[London_Air_Quality]
			union all
			select 'Newyork' as City, AQI, Date from [dbo].[New_York_Air_Quality]
			union all
			select 'Sydney' as City, AQI, Date from [dbo].[Sydney_Air_Quality]
		) as subquery 
		where Date >= DATEFROMPARTS(YEAR(GETDATE()), -1, 1)
			AND Date <= GETDATE()
		group by City
	)
	Select Top 1
		a.City,
		(a.avg_AQI_last_year - b.avg_AQI_current_year) as improvement 
	from
		avg_AQI_last_year a 
	join
		avg_AQI_current_year b ON a.City = b.City
	order by
		improvement DESC;

-----Q12) Get the number of days with hazardous air quality (AQI > 300) in each city.

	select City, count(*) as No_of_hazardous_days
	from (
		select 'Brasilia' As City, AQI from [dbo].[Brasilia_Air_Quality]
		union all
		select 'Cairo' as City, AQI from [dbo].[Cairo_Air_Quality]
		union all
		select 'Dubai' as City, AQI from [dbo].[Dubai_Air_Quality]
		union all
		select 'London' as City, AQI from [dbo].[London_Air_Quality]
		union all
		select 'Newyork' as City, AQI from [dbo].[New_York_Air_Quality]
		union all
		select 'Sydney' as City, AQI from [dbo].[Sydney_Air_Quality]
	) as subquery
	where AQI > 300
	group by City;
	