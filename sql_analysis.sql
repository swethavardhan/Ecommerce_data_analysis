create database ecommerce_data;
show tables;

#Total Revenue
select sum(total_price) as total_revenue from fact;
#Average Order value
select sum(total_price)/count(payment_key) as avo from fact;
#total transactions
select count(payment_key) from fact;

#total revenue by store
select 
s.store_key,
s.division,
s.district,
s.upazila,
sum(f.total_price) as total_revenue
from fact f
join store s on f.store_key = s.store_key
group by s.store_key, s.division, s.district, s.upazila
order by total_revenue desc;

#top 10 best selling items based on quantity sold
select i.item_key, i.item_name, i.desc, sum(f.quantity) as total_quantity
from fact f
join item i on f.item_key = i.item_key
group by i.item_key, i.item_name, i.desc
order by total_quantity desc;

#top 10 customers based on spending
 select c.coustomer_key, c.name, sum(f.total_price) as spent
 from fact f
 join customer c on f.coustomer_key = c.coustomer_key
 group by c.coustomer_key, c.name
 order by spent desc;
 
#total sales per month
select t.month, t.year, sum(f.total_price) as total_sales
from fact f
join time t on f.time_key = t.time_key
group by t.month, t.year
order by t.year, t.month;

#payment method analysis
select p.trans_type, count(f.payment_key) as transaction_count, sum(f.total_price) as total_revenue
from fact f
join transaction p on f.payment_key = p.payment_key
group by p.trans_type
order by total_revenue desc;

#revenue per manufacturer_country
select i.man_country as manufacturer_country, sum(f.total_price) as total_revenue
from fact f
join item i on f.item_key = i.item_key
group by i.man_country
order by total_revenue desc;

#quarterly sales performance
select t.year, t.quarter, sum(f.total_price) as total_sales
from fact f
join time t on f.time_key = t.time_key
group by t.year, t.quarter
order by t.year, t.quarter;

#top 10 items based on revenue
select i.item_name, sum(f.total_price) as total_revenue
from fact f
join item i on f.item_key = i.item_key
group by i.item_name
order by total_revenue desc
limit 10;

#store performance by revenue and quantity
select s.store_key, s.division, sum(f.total_price) as total_revenue, sum(f.quantity) as total_quantity
from fact f
join store s on f.store_key = s.store_key
group by s.store_key, s.division
order by total_revenue desc;

#sales performance by time of day
select t.hour, sum(f.total_price) as total_sales
from fact f
join time t on f.time_key = t.time_key
group by t.hour
order by t.hour;

#revenue by region
select s.division, sum(f.total_price) as total_revenue
from fact f
join store s on f.store_key = s.store_key
group by s.division
order by total_revenue desc;

#supplier perormance
select i.supplier, sum(f.total_price) as total_revenue
from fact f
join item i on f.item_key = i.item_key
group by i.supplier
order by total_revenue desc;







