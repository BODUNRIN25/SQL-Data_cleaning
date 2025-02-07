select *
from dirty_cafe_sales;

select Top 0
into cafe_sales2
from dirty_cafe_sales;

select *
from cafe_sales2

insert into cafe_sales2
select *
from dirty_cafe_sales;

select distinct(Item)
from cafe_sales2;

select distinct(Payment_Method)
from cafe_sales2;

select distinct(Location)
from cafe_sales2;

select distinct(Year(Transaction_Date))
from cafe_sales2;




select COUNT(*)
from cafe_sales2
where Price_Per_Unit is null
And Total_Spent is null;


delete
from cafe_sales2
where Quantity is null
And Total_Spent is null;

delete
from cafe_sales2
where Quantity is null
And Price_Per_Unit is null;

select count(*)
from dirty_cafe_sales
where Price_Per_Unit is null
and total_spent is null


update cafe_sales2
set Payment_Method = coalesce(Payment_Method, 'Others')
where Payment_Method is null;


update cafe_sales2
set Payment_Method = 'Others'
where Payment_Method = 'UNKNOWN';


update cafe_sales2
set Payment_Method = 'Others'
where Payment_Method = 'ERROR';




update cafe_sales2
set Item = coalesce(Item, 'Unknown')
where Item is null;


update cafe_sales2
set Item = 'Unknown'
where Item = 'UNKNOWN';


update cafe_sales2
set Item = 'Unknown'
where Item = 'ERROR';


update cafe_sales2
set Location = coalesce(Location, 'Unknown')
where Location is null;


update cafe_sales2
set Location = 'Unknown'
where Location = 'UNKNOWN';


update cafe_sales2
set Location = 'Unknown'
where Location = 'ERROR';

select distinct(Quantity)
from cafe_sales2;

select distinct(Price_Per_Unit)
from cafe_sales2;

select distinct(Total_Spent)
from cafe_sales2;

update cafe_sales2
set Quantity = null
where Quantity = 'ERROR';

update cafe_sales2
set Quantity = null
where Quantity = 'UNKNOWN'

with duplicateRows AS(
	select *, row_number() over(partition by Transaction_ID, Item, Payment_Method, Location, Transaction_Date order by Transaction_Date) As row_num
from cafe_sales2)
select *
from duplicateRows
where row_num > 1;

alter table cafe_sales2
alter column Quantity int;

with new_quantity as
(select Transaction_ID,Item, Quantity, Price_Per_Unit,total_spent, Total_Spent/Price_Per_Unit as newquantity
from cafe_sales2
where Price_Per_Unit is not null
AND Total_Spent is not null
)
update cafe_sales2
set Quantity = newquantity
from cafe_sales2
inner join 
	new_quantity on cafe_sales2.Transaction_ID = new_quantity.Transaction_ID;

with nppq as
(select Transaction_ID,Item, Quantity, Price_Per_Unit, Total_Spent/Quantity as new_ppq
from cafe_sales2
where Total_Spent is not null
AND Quantity is not null
)
update cafe_sales2
set Price_Per_Unit = new_ppq
from cafe_sales2
inner join 
	nppq on cafe_sales2.Transaction_ID = nppq.Transaction_ID;

with new_total_spent as
(select Transaction_ID,Item, Quantity, Price_Per_Unit,total_spent, Quantity * Price_Per_Unit as newtts
from cafe_sales2
where Price_Per_Unit is not null
AND Quantity is not null
)
update cafe_sales2
set Total_Spent = newtts
from cafe_sales2
inner join 
	new_total_spent on cafe_sales2.Transaction_ID = new_total_spent.Transaction_ID;

select COUNT(*)
from cafe_sales2






