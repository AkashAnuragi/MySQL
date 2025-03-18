Select p.product_name, SUM(o.unit) AS unit From Products p 
Join  Orders o
On p.product_id = o.product_id 
Where DATE_FORMAT(o.order_date,'%Y-%m') = '2020-02'
Group by p.product_id,p.Product_name
Having SUM(o.unit)>=100; 
