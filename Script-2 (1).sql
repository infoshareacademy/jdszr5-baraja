create table PKB as
select c."CountryCode", c."ShortName", i."Year", i."IndicatorCode" PKB, i."Value" as wartosc, 
lag(i."Value") over (partition by c."CountryCode") as rok_pop
from country c 
inner join indicators i on c."CountryCode" = i."CountryCode" 
where c."Region" ilike '%Europe%' and i."IndicatorCode" = 'SL.GDP.PCAP.EM.KD'
group by c."CountryCode", c."ShortName", i."Year", i."IndicatorCode", i."Value"   


select min("Year"), max("Year"), 2014 - 1980 
from pkb p 

create temp table maxi as
select "ShortName",  
max(case when "Year" = '1980' then wartosc end) as "1980",
max(case when "Year" = '1981' then wartosc end) as "1981",
max(case when "Year" = '1982' then wartosc end) as "1982",
max(case when "Year" = '1983' then wartosc end) as "1983",
max(case when "Year" = '1984' then wartosc end) as "1984",
max(case when "Year" = '1985' then wartosc end) as "1985",
max(case when "Year" = '1986' then wartosc end) as "1986",
max(case when "Year" = '1987' then wartosc end) as "1987",
max(case when "Year" = '1988' then wartosc end) as "1988",
max(case when "Year" = '1989' then wartosc end) as "1989",
max(case when "Year" = '1990' then wartosc end) as "1990",
max(case when "Year" = '1991' then wartosc end) as "1991",
max(case when "Year" = '1992' then wartosc end) as "1992",
max(case when "Year" = '1993' then wartosc end) as "1993",
max(case when "Year" = '1994' then wartosc end) as "1994",
max(case when "Year" = '1995' then wartosc end) as "1995",
max(case when "Year" = '1996' then wartosc end) as "1996",
max(case when "Year" = '1997' then wartosc end) as "1997",
max(case when "Year" = '1998' then wartosc end) as "1998",
max(case when "Year" = '1999' then wartosc end) as "1999",
max(case when "Year" = '2000' then wartosc end) as "2000",
max(case when "Year" = '2001' then wartosc end) as "2001",
max(case when "Year" = '2002' then wartosc end) as "2002",
max(case when "Year" = '2003' then wartosc end) as "2003",
max(case when "Year" = '2004' then wartosc end) as "2004",
max(case when "Year" = '2005' then wartosc end) as "2005",
max(case when "Year" = '2006' then wartosc end) as "2006",
max(case when "Year" = '2007' then wartosc end) as "2007",
max(case when "Year" = '2008' then wartosc end) as "2008",
max(case when "Year" = '2009' then wartosc end) as "2009",
max(case when "Year" = '2010' then wartosc end) as "2010",
max(case when "Year" = '2011' then wartosc end) as "2011",
max(case when "Year" = '2012' then wartosc end) as "2012",
max(case when "Year" = '2013' then wartosc end) as "2013",
max(case when "Year" = '2014' then wartosc end) as "2014"
from pkb p
group by "ShortName"
order by "ShortName"
)

create temp table raz1 as 
select "ShortName", min("Year") minimum, max("Year")maximum 
from pkb p
group by "ShortName" 

select r."ShortName", r."minimum"
from raz1 r
inner join pkb p on r."ShortName" = p."ShortName"


select "ShortName", min("Year") over (partition by "ShortName" order by "Year"), *
from pkb p

create temp table dane2 as 
select c."ShortName", i."Year", i."IndicatorCode", i."IndicatorName", i."Value" as wartosc
from country c 
inner join indicators i on c."CountryCode" = i."CountryCode" 
where c."Region" ilike '%Europe%' and i."IndicatorCode" in ('SL.GDP.PCAP.EM.KD', 'NY.GNS.ICTR.CD', 'NY.GNS.ICTR.ZS', 'NY.GDP.DEFL.KD.ZG', 'FR.INR.LEND', 'AG.LND.TOTL.K2', 'SP.POP.TOTL', 'SP.POP.TOTL.FE.ZS', 'FR.INR.RINR', 'AG.SRF.TOTL.K2', 'IP.TMK.TOTL', 'SL.UEM.TOTL.NE.ZS', 'AG.LND.TOTL.K2', 'FR.INR.DPST')
and i."Year" > '1979'
order by 1, 2 ,3

create table main_indicators1 as
select
	"ShortName",
	"Year",
	max(case when "IndicatorCode" = 'SL.GDP.PCAP.EM.KD' then "wartosc" end)"PKB per capita",
	max(case when "IndicatorCode" = 'NY.GNS.ICTR.CD' then "wartosc" end)"Gross savings (current US$)",
	max(case when "IndicatorCode" = 'NY.GNS.ICTR.ZS' then "wartosc" end)"Gross savings (% of GDP)",
	max(case when "IndicatorCode" = 'NY.GDP.DEFL.KD.ZG' then "wartosc" end)"Inflation, GDP deflator (annual %)",
	max(case when "IndicatorCode" = 'FR.INR.LEND' then "wartosc" end)"Lending interest rate (%)",
	max(case when "IndicatorCode" = 'AG.LND.TOTL.K2' then "wartosc" end)"Land area (sq. km)",
	max(case when "IndicatorCode" = 'SP.POP.TOTL' then "wartosc" end)"Population, total",
	max(case when "IndicatorCode" = 'SP.POP.TOTL.FE.ZS' then "wartosc" end)"Population, female (% of total)",
	max(case when "IndicatorCode" = 'FR.INR.RINR' then "wartosc" end)"Real interest rate (%)",
	max(case when "IndicatorCode" = 'AG.SRF.TOTL.K2' then "wartosc" end)"Surface area (sq. km)",
	max(case when "IndicatorCode" = 'IP.TMK.TOTL' then "wartosc" end)"Trademark applications, total",
	max(case when "IndicatorCode" = 'SL.UEM.TOTL.NE.ZS' then "wartosc" end)"Unemployment, total (% of total labor force) (national estimate)",
	max(case when "IndicatorCode" = 'FR.INR.DPST' then "wartosc" end)"Deposit interest rate (%)"
from dane2 d
group by 1, 2
order by 1, 2

create table correlation as 
select
	"ShortName",
	corr(mi."PKB per capita", mi."Gross savings (current US$)")"Corr gross savings",
	corr(mi."PKB per capita", mi."Gross savings (% of GDP)")"Corr Gross savings (% of GDP)",
	corr(mi."PKB per capita", mi."Inflation, GDP deflator (annual %)")"Corr Inflation, GDP deflator (annual %)",
	corr(mi."PKB per capita", mi."Lending interest rate (%)")"Corr Lending interest rate (%)",
	corr(mi."PKB per capita", mi."Land area (sq. km)")"Corr Land area (sq. km)",
	corr(mi."PKB per capita", mi."Population, total")"Corr Population, total",
	corr(mi."PKB per capita", mi."Population, female (% of total)")"Corr Population, female (% of total)",
	corr(mi."PKB per capita", mi."Real interest rate (%)")"Corr Real interest rate (%)",
	corr(mi."PKB per capita", mi."Surface area (sq. km)")"Corr Surface area (sq. km)",
	corr(mi."PKB per capita", mi."Trademark applications, total")"Corr Trademark applications, total",
	corr(mi."PKB per capita", mi."Unemployment, total (% of total labor force) (national estimate")"Corr Unemployment, total (% of total labor force) (national estimate",
	corr(mi."PKB per capita", mi."Deposit interest rate (%)")"Corr Deposit interest rate (%)"
from
	main_indicators1 mi
group by mi."ShortName"
order by mi."ShortName" 

select 
avg(c."Corr gross savings")"Gross_Savings",
avg(c."Corr Gross savings (% of GDP)")"Gross_Savings_GDP",
avg(c."Corr Inflation, GDP deflator (annual %)")"Inflation",
avg(c."Corr Lending interest rate (%)")"Lending_Intrest",
avg(c."Corr Land area (sq. km)")"Land_Area",
avg(c."Corr Population, total")"Population",
avg(c."Corr Population, female (% of total)")"Population_Female",
avg(c."Corr Real interest rate (%)")"Real_Interest_Rate",
avg(c."Corr Surface area (sq. km)")"Surface_Area",
avg(c."Corr Trademark applications, total")"Trademark_applications",
avg(c."Corr Unemployment, total (% of total labor force) (national est")"Unemployment",
avg(c."Corr Deposit interest rate (%)")"Deposit_Interest_Rate"
from correlation c 


select p."ShortName", min(p."Year") minimum, max(p."Year")maximum, i."Value", i."IndicatorCode", i."Year" 
from pkb p
left join indicators i on p."ShortName" = i."CountryName"
where i."IndicatorCode" = 'SL.GDP.PCAP.EM.KD' and i."Year" in ('1980','2014')
group by p."ShortName", i."Value", i."IndicatorCode" , i."Year" 
order by p."ShortName" , i."Year" 


select "ShortName"
, "1980"
from maxi
where "1980" is not null 
order by "1980" desc 
limit 10  

select "ShortName"
, "2014"
from maxi
where "2014" is not null 
order by "2014" desc 
limit 10  


select "ShortName"
, "1980"
from maxi
where "1980" is not null 
order by "1980"
limit 10 

select "ShortName", 
"2014"
from maxi
where "2014" is not null 
order by "2014"
limit 10


select *
from correlation c 
join (select "ShortName"
, "1980"
from maxi
where "1980" is not null 
order by "1980"
limit 10) z on c."ShortName" = z."ShortName"

