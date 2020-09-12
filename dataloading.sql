SELECT	unicode(CAST(MY_XML AS xml))
FROM	OPENROWSET(  BULK 'D:\Sample.xml', SINGLE_BLOB) AS T(MY_XML)

SELECT 
   MY_XML.VESSELS.query('VESSELS').value('.', 'nvarchar(4000)')
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'D:\Sample.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('VESSELS') AS MY_XML (VESSELS);

SELECT	CONVERT(varchar,MY_XML)
FROM	OPENROWSET(  BULK 'D:\Sample.xml', SINGLE_BLOB) AS T(MY_XML)

Drop table if exists ##temp
Create table ##temp (id int identity(1,1),Datarow nvarchar(4000))
Declare @sql nvarchar(4000)
--set @sql = 'bcp ##temp in "D:\Sample.xml" -S '+@@SERVERNAME+' -T'
--set @sql = 'bcp "select * from ##temp" queryout "D:\output.txt" -S '+@@SERVERNAME+' -T -c -t'
set @sql = 'bcp "##temp" in "D:\Capstone\combine_09-04-2020.csv" -S '+@@SERVERNAME+' -T -n -t'
print @sql
exec master..xp_cmdshell @sql

select * from ##temp 
select * from ##temp where datarow not like '%GMT%'
select len(datarow) from ##temp where id=1

