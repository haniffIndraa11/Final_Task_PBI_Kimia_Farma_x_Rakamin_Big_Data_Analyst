WITH ProductTransaction AS (
    SELECT 
        p.product_id,
        p.product_name,
        ft.customer_name,
        p.price AS actual_price,
        ft.discount_percentage,
        ft.rating,
        ft.date,
        ft.branch_id,
        p.price * (1 - ft.discount_percentage) AS net_sales,
        CASE    
            WHEN p.price <= 50000 THEN 0.10
            WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
            WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
            WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
            ELSE 0.30
        END AS persentage_gross_laba,
        (p.price * (1 - ft.discount_percentage)) * 
        CASE    
            WHEN p.price <= 50000 THEN 0.10
            WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
            WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
            WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
            ELSE 0.30
        END AS net_profit,
        kc.provinsi,
        kc.kota,
        kc.rating AS rating_provinsi
    FROM 
        test_database.kf_product p
    JOIN 
        test_database.kf_final_transaction ft ON p.product_id = ft.product_id
    JOIN 
        test_database.kf_kantor_cabang kc ON ft.branch_id = kc.branch_id
)

SELECT 
    provinsi,
    COUNT(*) AS total_transaksi,
    SUM(net_sales) AS total_penjualan,
    SUM(net_profit) AS total_keuntungan
FROM 
    ProductTransaction
GROUP BY 
    provinsi
ORDER BY 
    total_transaksi DESC;
    
-- Top 10 Total Transaksi cabang provinsi
