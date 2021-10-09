--KROK 0
--Wybranie wskaznikow w celu wykazania wplywu na wskaznik PKB per capita.
--Przeglad wskaznikow, zawezony do 1 kraju
--Cel: zebrac IndicatorCode
select
	c."ShortName",
	i."Year",
	i."IndicatorCode",
	i."IndicatorName",
	i."Value" as wartosc
from
	country c
inner join indicators i on
	c."CountryCode" = i."CountryCode"
where
	c."ShortName" = 'Poland'
--c."Region" ilike '%Europe%'
	and lower(i."IndicatorName") LIKE '%manufac%'
	and i."Year" > '1979'
order by 1,	2, 3;

/* WYBRANE WSKANIKI	

WskaŸniki dotycz¹ce przemys³u i zatrudnienia:
	SL.IND.EMPL.ZS		Employment in industry (% of total employment)
	NV.IND.TOTL.CD		Industry, value added (current US$) 
	IS.AIR.GOOD.MT.K1	Air transport, freight (million ton-km)
	IS.RRS.GOOD.MT.K6	Railways, goods transported (million ton-km)
	TM.VAL.MANF.ZS.UN	Manufactures imports (% of merchandise imports)
	TX.VAL.MANF.ZS.UN	Manufactures exports (% of merchandise exports)
	TX.VAL.TECH.MF.ZS	High-technology exports (% of manufactured exports)
 */


--KROK 1
--Podstawione powy¿sze kody + kody dla PKB per capita i bezrobocia.
--Wyci¹g danych o wskaŸnikach dla krajoj regiona 'Europa' od 1980 roku.

create temp table dane21 as
select
	c."ShortName",
	i."Year",
	i."IndicatorCode",
	i."IndicatorName",
	i."Value" as wartosc
from
	country c
inner join indicators i on
	c."CountryCode" = i."CountryCode"
where
	c."Region" ilike '%Europe%'
	and i."IndicatorCode" in ('SL.GDP.PCAP.EM.KD', 'SL.UEM.TOTL.NE.ZS', 'SL.IND.EMPL.ZS', 'NV.IND.TOTL.CD', 'IS.AIR.GOOD.MT.K1', 'IS.RRS.GOOD.MT.K6', 'TM.VAL.MANF.ZS.UN', 'TX.VAL.MANF.ZS.UN', 'TX.VAL.TECH.MF.ZS')
	and i."Year" > '1979'
order by 1,	2, 3;

--KROK 2
--Transpozycja danych do kolumn.
create temp table main_indicators11 as
select
	"ShortName",
	"Year",
	max(case when "IndicatorCode" = 'SL.GDP.PCAP.EM.KD' then "wartosc" end)"PKB per capita",
	max(case when "IndicatorCode" = 'SL.UEM.TOTL.NE.ZS' then "wartosc" end)"Unemployment, total (% of total labor force, national estimate)",
	max(case when "IndicatorCode" = 'SL.IND.EMPL.ZS' then "wartosc" end)"Employment in industry (% of total employment)",
	max(case when "IndicatorCode" = 'NV.IND.TOTL.CD' then "wartosc" end)"Industry, value added (current US$)",
	max(case when "IndicatorCode" = 'IS.AIR.GOOD.MT.K1' then "wartosc" end)"Air transport, freight (million ton-km)",
	max(case when "IndicatorCode" = 'IS.RRS.GOOD.MT.K6' then "wartosc" end)"Railways, goods transported (million ton-km)",
	max(case when "IndicatorCode" = 'TM.VAL.MANF.ZS.UN' then "wartosc" end)"Manufactures imports (% of merchandise imports)",
	max(case when "IndicatorCode" = 'TX.VAL.MANF.ZS.UN' then "wartosc" end)"Manufactures exports (% of merchandise exports)",
	max(case when "IndicatorCode" = 'TX.VAL.TECH.MF.ZS' then "wartosc" end)"High-technology exports (% of manufactured exports)"
from
	dane21 d1
group by 1,	2
order by 1,	2;

--KROK 3
--Wyliczenie wspol. korelacja dla wybranych wspolczynnikow.
create table correlation1 as
select
	"ShortName",
	corr(mi1."Unemployment, total (% of total labor force, national estimate)", mi1."PKB per capita") "Corr unemp|PKB_per_capita",
	corr(mi1."Employment in industry (% of total employment)", mi1."PKB per capita") "Corr emp_industry|PKB_per_capita",
	corr(mi1."Industry, value added (current US$)", mi1."PKB per capita") "Corr industry_val_added|PKB_per_capita",
	corr(mi1."Air transport, freight (million ton-km)", mi1."PKB per capita") "Corr air_trans|PKB_per_capita",
	corr(mi1."Railways, goods transported (million ton-km)", mi1."PKB per capita") "Corr railways_trans|PKB_per_capita",
	corr(mi1."Manufactures imports (% of merchandise imports)", mi1."PKB per capita") "Corr manufac_imp|PKB_per_capita",
	corr(mi1."Manufactures exports (% of merchandise exports)", mi1."PKB per capita") "Corr manufac_exp|PKB_per_capita",
	corr(mi1."High-technology exports (% of manufactured exports)", mi1."PKB per capita") "Corr h-tech_exp|PKB_per_capita"
from main_indicators11 mi1
group by mi1."ShortName"
order by mi1."ShortName";

--KROK 4

