WITH ratingTable AS (
    SELECT 
        kc.branch_name,
        kc.provinsi,
        kc.rating AS rating_provinsi,
        AVG(ft.rating) AS avg_transaction_rating
    FROM 
        test_database.kf_final_transaction ft
    JOIN 
        test_database.kf_kantor_cabang kc ON ft.branch_id = kc.branch_id
    GROUP BY 
        kc.branch_name, kc.provinsi, kc.rating
)

SELECT 
    branch_name,
    provinsi,
    rating_provinsi,
    avg_transaction_rating
FROM 
    ratingTable
ORDER BY 
    rating_provinsi DESC, 
    avg_transaction_rating ASC
LIMIT 5;

-- query untuk mencari Top 5 cabang dengan rating tertinggi, namun rating transaksi terendah