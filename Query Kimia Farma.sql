SELECT ft.transaction_id, ft.date, ft.branch_id,kc.branch_name, kc.kota, kc.provinsi, kc.rating AS rating_cabang, 
ft.customer_name, ft.product_id, p.product_name,p.price AS actual_price, ft.discount_percentage, 
CASE WHEN p.price <= 50000 THEN 0.1
     WHEN p.price BETWEEN 50000 AND 100000 THEN 0.15
     WHEN p.price BETWEEN 100000 AND 300000 THEN 0.2
     WHEN p.price BETWEEN 300000 AND 500000 THEN 0.25
     WHEN p.price <= 500000 THEN 0.3
END AS persentase_gross_laba,
(p.price * (1-ft.discount_percentage)) AS nett_sales, 
(p.price * (CASE 
               WHEN p.price <= 50000 THEN 0.1
               WHEN p.price BETWEEN 50000 AND 100000 THEN 0.15
               WHEN p.price BETWEEN 100000 AND 300000 THEN 0.2
               WHEN p.price BETWEEN 300000 AND 500000 THEN 0.25
               ELSE 0.3
          END)) AS nett_profit,
ft.rating AS rating_transaksi
FROM kimia_farma.kf_final_transaction AS ft
JOIN kimia_farma.kf_kantor_cabang AS kc ON ft.branch_id = kc.branch_id
JOIN kimia_farma.kf_product As p ON ft.product_id = p.product_id
