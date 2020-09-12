USE AlphaOri;

Drop table if exists [AIS_Data]

--Table structure creation
CREATE TABLE [AIS_Data]
(
--ID bigint identity(1,1)
[MMSI] bigint
,[Time] varchar(300)
,Longitude decimal(10,8)
,Latitude decimal(10,8)
,COG decimal(10,8)
,SOG decimal(10,8)
,HEADING int
,ROT int
,NAVSTAT int
,IMO bigint
,[Name] nvarchar(1000)
,CALLSIGN nvarchar(100)
,[TYPE] int
,A int
,B int
,C int
,D int
,DRAUGHT decimal(10,8)
,DEST nvarchar(1000)
,ETA varchar(100)
)

--<vessel MMSI="413133000"  TIME="2020-04-30 23:47:00 GMT"  LONGITUDE="116.16151"  LATITUDE="22.45667"  COG="65.8"  SOG="14.5"  HEADING="65"  ROT="13"  NAVSTAT="0"  IMO="9304813"  
--NAME="XIN CHANG SHU"  CALLSIGN="BPBG"  TYPE="71"  A="250"  B="30"  C="20"  D="20"  DRAUGHT="11.6"  DEST="CN  SHA"  ETA="05-03 06:00" />

Create table [Datarow]
(
ID bigint identity(1,1)
,datarow nvarchar(4000)
)

--Data insertion
INSERT INTO [Datarow] (datarow)
SELECT
   MY_XML.vessel.query('vessel').value('.', 'nvarchar(4000)')
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'D:\Capstone\xml_files\data.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('VESSELS/vessel') AS MY_XML (vessel);


/*
INSERT INTO CUSTOMERS_TABLE (DOCUMENT, NAME, ADDRESS, PROFESSION)
SELECT
   MY_XML.Customer.query('Document').value('.', 'VARCHAR(20)'),
   MY_XML.Customer.query('Name').value('.', 'VARCHAR(50)'),
   MY_XML.Customer.query('Address').value('.', 'VARCHAR(50)'),
   MY_XML.Customer.query('Profession').value('.', 'VARCHAR(50)')
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'C:\temp\MSSQLTIPS_XML.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('Customers/Customer') AS MY_XML (Customer);
*/

SELECT 
   MY_XML.vessel.query('vessel').value('.', 'varchar')
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'D:\Sample.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('VESSELS/vessel') AS MY_XML (vessel);

SELECT
   MY_XML.Customer.query('Document').value('.', 'VARCHAR(20)'),
   MY_XML.Customer.query('Name').value('.', 'VARCHAR(50)'),
   MY_XML.Customer.query('Address').value('.', 'VARCHAR(50)'),
   MY_XML.Customer.query('Profession').value('.', 'VARCHAR(50)')
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'D:\Sample.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('Customers/Customer') AS MY_XML (Customer);

--test

Drop table if exists #A
SELECT	CAST(MY_XML AS xml) as datarow
into #A
FROM	OPENROWSET(  BULK 'D:\Sample.xml', SINGLE_BLOB) AS T(MY_XML)

select len(datarow) from #A

--C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL
exec master..xp_cmdshell 'bcp AlphaOri..Datarow in D:\Sample.xml -S .\DESKTOP-HT8316L\Abhisek -Usa -Pdba@1234'
exec master..xp_cmdshell 'bcp "AlphaOri..Datarow" in "D:\Sample.xml" -Usa -Pdba@123 '
exec master..xp_cmdshell 'bcp "AlphaOri..Datarow" in "D:\Sample.xml" -T '

select * from AlphaOri..[Datarow]

<VESSELS ERROR="false" USERNAME="AH_2351_3006CAD6" FORMAT="HUMAN" RECORDS="30271"><vessel MMSI="413133000" TIME="2020-04-30 23:47:00 GMT" LONGITUDE="116.16151" LATITUDE="22.45667" COG="65.8" SOG="14.5" HEADING="65" ROT="13" NAVSTAT="0" IMO="9304813" NAME="XIN CHANG SHU" CALLSIGN="BPBG" TYPE="71" A="250" B="30" C="20" D="20" DRAUGHT="11.6" DEST="CN  SHA" ETA="05-03 06:00" /><vessel MMSI="477521100" TIME="2020-05-01 00:11:28 GMT" LONGITUDE="29.39331" LATITUDE="60.02636" COG="92" SOG="5.9" HEADING="96" ROT="0" NAVSTAT="0" IMO="9868443" NAME="SIDER MONTEDIPROCIDA" CALLSIGN="VRTE2" TYPE="70" A="154" B="26" C="9" D="21" DRAUGHT="6.2" DEST="ST.PETERSBURG" ETA="04-25 17:00" /><vessel MMSI="205542590" TIME="2020-05-01 00:10:13 GMT" LONGITUDE="4.82565" LATITUDE="52.39497" COG="4.6" SOG="0" HEADING="511" ROT="128" NAVSTAT="5" IMO="0" NAME="MALIA" CALLSIGN="OT5425" TYPE="80" A="95" B="15" C="7" D="7" DRAUGHT="3.7" DEST="AMSTERDAM BOSPORUSHA" ETA="04-29 01:03" /><vessel MMSI="257044000" TIME="2020-05-01 00:10:33 GMT" LONGITUDE="5.29803" LATITUDE="59.33918" COG="17" SOG="0" HEADING="17" ROT="0" NAVSTAT="5" IMO="9661170" NAME="NORMAND JARL" CALLSIGN="LACE8" TYPE="70" A="18" B="89" C="11" D="11" DRAUGHT="6.1" DEST="HUSOY NO" ETA="04-18 07:00" /><vessel MMSI="538002820" TIME="2020-05-01 00:09:29 GMT" LONGITUDE="37.78572" LATITUDE="44.72928" COG="313.1" SOG="0" HEADING="319" ROT="0" NAVSTAT="5" IMO="9474785" NAME="GENCO LORRAINE" CALLSIGN="V7HU2" TYPE="70" A="160" B="29" C="19" D="13" DRAUGHT="6.2" DEST="RU NVS" ETA="04-28 10:00" /><vessel MMSI="477105800" TIME="2020-05-01 00:07:15 GMT" LONGITUDE="135.3972" LATITUDE="34.64608" COG="148" SOG="0" HEADING="40" ROT="0" NAVSTAT="5" IMO="9330757" NAME="JOSCO STAR" CALLSIGN="VRBS3" TYPE="70" A="113" B="30" C="16" D="7" DRAUGHT="7.7" DEST="JP OSA H" ETA="05-01 07:00" /><vessel MMSI="366977480" TIME="2020-05-01 00:11:28 GMT" LONGITUDE="-91.20368" LATITUDE="30.42867" COG="275.5" SOG="0.1" HEADING="511" ROT="128" NAVSTAT="0" IMO="0" NAME="FLICKER" CALLSIGN="WDB9507" TYPE="52" A="6" B="10" C="1" D="4" DRAUGHT="2.4" DEST="BR HARBOR" ETA="00-00 00:00" /><vessel MMSI="304496000" TIME="2020-05-01 00:10:36 GMT" LONGITUDE="18.46685" LATITUDE="-33.87413" COG="119.9" SOG="0" HEADING="341" ROT="128" NAVSTAT="1" IMO="9126998" NAME="BOUNDARY" CALLSIGN="V2HZ" TYPE="79" A="131" B="26" C="12" D="12" DRAUGHT="7" DEST="ZACPT" ETA="04-09 11:00" /><vessel MMSI="244700480" TIME="2020-05-01 00:10:51 GMT" LONGITUDE="4.69406" LATITUDE="51.82355" COG="0" SOG="0" HEADING="511" ROT="128" NAVSTAT="4" IMO="0" NAME="DUO" CALLSIGN="PD2571" TYPE="99" A="29" B="5" C="2" D="3" DRAUGHT="0" DEST="PAP" ETA="00-00 24:60" /></VESSELS>



-- To allow advanced options to be changed.  
EXECUTE sp_configure 'show advanced options', 1;  
GO  
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO  
-- To enable the feature.  
EXECUTE sp_configure 'xp_cmdshell', 1;  
GO  
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO