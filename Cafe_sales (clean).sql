--Data cleaning
select COUNT(Distinct(Transaction_ID)) as total_transactions
from dbo.cafe_sales;

select *
from cafe_sales;


select COUNT(*)
from cafe_sales
where Price_Per_Unit is null
And Total_Spent is null;


delete
from cafe_sales
where Price_Per_Unit is null
And Total_Spent is null;


update cafe_sales
set Payment_Method = coalesce(Payment_Method, 'UNKNOWN')
where Payment_Method is null;


update cafe_sales
set Payment_Method = 'other'
where Payment_Method = 'UNKNOWN';


select distinct(Payment_Method)
from cafe_sales;


select count(*)
from cafe_sales
where Item is null;


update cafe_sales
set Location = coalesce(Location, 'UNKNOWN')
where Location is null;


update cafe_sales
set Location = 'UNKNOWN'
where Location = 'ERROR';


select distinct(Quantity)
from cafe_sales;


update cafe_sales
set Quantity = null
where Quantity = 'ERROR';


update cafe_sales
set Quantity = null
where Quantity = 'UNKNOWN';


with new_total_spent as
(select Transaction_ID,Item, Quantity, Price_Per_Unit, Quantity*Price_Per_Unit as total_spent_new
from cafe_sales
where Price_Per_Unit is not null
AND Quantity is not null
)
update cafe_sales
set Total_Spent = total_spent_new
from cafe_sales
inner join 
	new_total_spent on cafe_sales.Transaction_ID = new_total_spent.Transaction_ID;


select Price_Per_Unit
from cafe_sales
where Price_Per_Unit is null


delete 
from cafe_sales
where Total_Spent is null
And Quantity is null


with new_quantity as
(select Transaction_ID,Item, Quantity, Price_Per_Unit, Total_Spent/Price_Per_Unit as newquantity
from cafe_sales
where Price_Per_Unit is not null
AND Total_Spent is not null
)
update cafe_sales
set Quantity = newquantity
from cafe_sales
inner join 
	new_quantity on cafe_sales.Transaction_ID = new_quantity.Transaction_ID;


delete 
from cafe_sales
where Price_Per_Unit is null
And Quantity is null


with nppq as
(select Transaction_ID,Item, Quantity, Price_Per_Unit, Total_Spent/Quantity as new_ppq
from cafe_sales
where Total_Spent is not null
AND Quantity is not null
)
update cafe_sales
set Price_Per_Unit = new_ppq
from cafe_sales
inner join 
	nppq on cafe_sales.Transaction_ID = nppq.Transaction_ID;


select Distinct(Item)
from cafe_sales


update cafe_sales
set Item = null
where Item = 'UNKNOWN'


update cafe_sales
set Item = null
where Item = 'ERROR'


select ROUND(Price_Per_Unit,2)
from cafe_sales;


update cafe_sales
set Price_Per_Unit = ROUND(Price_Per_Unit,2)


