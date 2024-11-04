with ProductTransaction as (
select 
p.product_id,
p.product_name,
ft.customer_name,
p.price as actual_price,
ft.discount_percentage,
ft.rating,
ft.date,
ft.branch_id,
ft.transaction_id,
p.price * (1 - ft.discount_percentage) as net_sales,
case	
when p.price <=50000 then 0.10
WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
else 0.30
end as persentage_gross_laba,
p.price * (1 - ft.discount_percentage) * 
case	
when p.price <=50000 then 0.10
WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
else 0.30
end as net_profit,
kc.provinsi,
kc.kota,
kc.rating as rating_provinsi
from test_database.kf_product p
join test_database.kf_final_transaction ft on p.product_id = ft.product_id
join test_database.kf_kantor_cabang kc on ft.branch_id = kc.branch_id
)

select 
branch_id, transaction_id, product_id, product_name, customer_name, date, actual_price, 
discount_percentage, persentage_gross_laba, net_sales, rating, net_profit, provinsi, kota, rating_provinsi
from ProductTransaction

-- main sql untuk mencari persentasi gross laba, net profit, dan join table, net_sales dan pendapatan kimia farma dari tahun ke tahun


