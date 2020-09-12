use Others
set nocount on;
Declare @outputpath varchar(100),@count int,@sql varchar(4000),@filename varchar(20),@id int,@filelocation varchar(100)
SET @outputpath='D:\Aggregated_Data\'

Drop table if exists #region
Create table #region
(
id int identity(1,1),region varchar(50)
)

Drop table if exists ##data
Create table ##data
(
id int identity(1,1),
datarow varchar(200)
)

--Region-wise
insert into #region
select distinct region from df_data

set @count=(select count(*) from #region)
SET @id=1

WHILE(@count>0)
BEGIN

	set @filename= (select concat(replace(region,' ','_'),'.csv') from #region where id=@id)
	set @filelocation=@outputpath+@filename;

	Truncate table ##data

	insert into ##data
	select 'Order_Date,line_item_quantity'

	Truncate table AlphaOri..Zambia_aggregate

	insert into AlphaOri..Zambia_aggregate(Order_date,Line_Item_Quantity)
	select [Order date],[Line_Item_Quantity]
	from df_data
	where Region = (select region from #region where id=@id)

	update AlphaOri..Zambia_aggregate set order_dt=CONVERT(date,Order_date)

	update AlphaOri..Zambia_Aggregate set quarter=Convert(varchar,DATEPART(YEAR,order_dt))+'Q'+Convert(varchar,DATEPART(quarter,order_dt)) from AlphaOri..Zambia_Aggregate

	insert into ##data
	select CONCAT(quarter,',',CONVERT(varchar,agg_line_item_quantity))
	from (
		select quarter,sum(Line_Item_Quantity) as agg_line_item_quantity 
		from AlphaOri..Zambia_Aggregate 
		group by quarter 
		)a
	order by quarter asc

	set @sql = 'bcp "select datarow from ##data order by id" queryout "'+@filelocation+'" -S '+@@SERVERNAME+' -T -c -t'	
	print @sql
	exec xp_cmdshell @sql

	SET @count= @count-1;
	SET @id=@id+1;
END

TRUNCATE TABLE #region

--countrywise
insert into #region
select distinct Country from df_data

set @count=(select count(*) from #region)
SET @id=1

WHILE(@count>0)
BEGIN

	set @filename= (select concat(replace(region,' ','_'),'.csv') from #region where id=@id)
	set @filelocation=@outputpath+@filename;

	Truncate table ##data

	insert into ##data
	select 'Order_Date,line_item_quantity'

	Truncate table AlphaOri..Zambia_aggregate

	insert into AlphaOri..Zambia_aggregate(Order_date,Line_Item_Quantity)
	select [Order date],[Line_Item_Quantity]
	from df_data
	where Country = (select region from #region where id=@id)

	update AlphaOri..Zambia_aggregate set order_dt=CONVERT(date,Order_date)

	update AlphaOri..Zambia_Aggregate set quarter=Convert(varchar,DATEPART(YEAR,order_dt))+'Q'+Convert(varchar,DATEPART(quarter,order_dt)) from AlphaOri..Zambia_Aggregate

	insert into ##data
	select CONCAT(quarter,',',CONVERT(varchar,agg_line_item_quantity))
	from (
		select quarter,sum(Line_Item_Quantity) as agg_line_item_quantity 
		from AlphaOri..Zambia_Aggregate 
		group by quarter 
		)a
	order by quarter asc

	set @sql = 'bcp "select datarow from ##data order by id" queryout "'+@filelocation+'" -S '+@@SERVERNAME+' -T -c -t'	
	print @sql
	exec xp_cmdshell @sql

	SET @count= @count-1;
	SET @id=@id+1;
END


/*
select top 10 * from df_data
select * from #region
select [Order date],[Line_Item_Quantity]
	from df_data
	where Region = (select region from #region where id=1)
*/