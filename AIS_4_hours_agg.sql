use AlphaOri
select COUNT(*) from Ais_Data_4Hrs
select top 10 * from Ais_Data_4Hrs

update Ais_Data_4Hrs set Time_DateTime=CONVERT(datetime,[TIME])

select [month],day_of_month,count(distinct mmsi) as agg_value 
from (
	select mmsi,Time_DateTime,CASE WHEN DATEPART(MONTH,Time_DateTime)=4 THEN 'April' ELSE 'May' END as [month],DATEPART(DAY,Time_DateTime) as day_of_month
	from Ais_Data_4Hrs
	)a
group by [month],day_of_month
order by 1,2

truncate table datarow

insert into datarow
select 'month,day_of_month,agg_value'

insert into Datarow
select CONCAT([month],',',CONVERT(varchar,day_of_month),',',CONVERT(varchar,agg_value))
from (
	select [month],day_of_month,count(mmsi) as agg_value 
	from (
		select mmsi,Time_DateTime,CASE WHEN DATEPART(MONTH,Time_DateTime)=4 THEN 'April' ELSE 'May' END as [month],DATEPART(DAY,Time_DateTime) as day_of_month
		from Ais_Data_4Hrs
		)a
	group by [month],day_of_month )b
order by [month],day_of_month

select * from Datarow order by ID
