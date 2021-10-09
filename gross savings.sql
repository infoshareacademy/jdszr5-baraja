select "Year" ,  
max(case when ShortName='Albania' then "Gross savings (% of GDP)"  end ) as Albania,
max(case when ShortName='Poland' then "Gross savings (% of GDP)" end ) as Poland,
max(case when ShortName='Ireland' then "Gross savings (% of GDP)" end ) as Ireland,
max(case when ShortName='Estonia' then "Gross savings (% of GDP)" end ) as Estonia,
max(case when ShortName='Luxembourg' then "Gross savings (% of GDP)" end ) as Lux
from main_indicators1_202110081027 i 
group by "Year"

select "Year" ,
max(case when ShortName='Albania' then "Gross savings (current US$)"  end ) as Albania,
max(case when ShortName='Poland' then "Gross savings (current US$)" end ) as Poland,
max(case when ShortName='Ireland' then "Gross savings (current US$)" end ) as Ireland,
max(case when ShortName='Estonia' then "Gross savings (current US$)" end ) as Estonia,
max(case when ShortName='Luxembourg' then "Gross savings (current US$)" end ) as Lux
from main_indicators1_202110081027 i 
group by "Year"