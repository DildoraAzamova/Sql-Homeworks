

----(1)----

select *, SUM(total_amount) over (partition by customer_id order by order_date) 
from sales_data;


----(2)----

select  *, count(*) over (partition by product_category order by (select null))
from sales_data;

----(3)----

SELECT *,
   
    MAX(total_amount) OVER (PARTITION BY product_category) AS total_amount
FROM 
     sales_data;

----(4)----

SELECT *,
   
    MIn(unit_price) OVER (PARTITION BY product_category )
FROM 
     sales_data;

----(5)----

select *, AVG(total_amount) over (order by order_date rows between 1 preceding and 1 following)
from sales_data;

----(6)----

select region, sum(total_amount) 
from sales_data
group by region;

----(7)----

SELECT *, Rank() over (order by purchase_amount desc)
from (select customer_id, Sum(total_amount) As purchase_amount
	from sales_data
	group by customer_id
) as v;

----(8)----

select *, total_amount - LEAD(total_amount) over (partition by customer_id order by order_date)
from sales_data;

----(9)----

SELECT 
    *
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rn
    FROM 
        sales_data
) t
WHERE rn <= 3;

----(10)----

select *, sum(total_amount) over (partition by region order by order_date)
from sales_data;

----(11)----

select *, Sum(revenue) over (partition by product_category order by order_date)
from (
    select *, quantity_sold * unit_price As revenue
	from sales_data
) as v;

----(12)----

select *, Sum(id) over (order by (select null))
from numbers;

----(13)----

CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

select *, sum(value) over (order by (select null) rows between 1 preceding and current row) 
from OneColumn;

----(14)----

WITH CTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (ORDER BY Id, Vals) AS RN,
           DENSE_RANK() OVER (ORDER BY Id) AS DR
    FROM Row_Nums
)
SELECT 
    Id,
    Vals,
    (RN + DR - 1) AS RowNumber
FROM CTE
ORDER BY Id, Vals;

----(15)----

SELECT 
    customer_id
FROM 
    sales_data
GROUP BY 
    customer_id
HAVING 
    COUNT(DISTINCT product_category) > 1;

----(16)----

select region, total_amount, AvgRegion
from(
	select *, avg(total_amount) over (partition by region) AvgRegion
	from sales_data
) reg
where total_amount > AvgRegion;

----(17)----

select *, DENSE_RANK() over (partition by region order by total_amount)
from sales_data;

----(18)----

select *, sum(total_amount) over (partition by customer_id order by order_date)
from sales_data;

----(19)----

WITH MonthlySales AS (
    SELECT 
        Month(order_date) AS month,
        SUM(total_amount) AS total_sales
    FROM sales_data
    GROUP BY month(order_date)
)
SELECT 
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales,
    CASE 
        WHEN LAG(total_sales) OVER (ORDER BY month) IS NULL THEN NULL
        ELSE (total_sales - LAG(total_sales) OVER (ORDER BY month)) / LAG(total_sales) OVER (ORDER BY month) * 100
    END AS growth_rate
FROM MonthlySales;

----(20)----

WITH CustomerTotal AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM sales_data
    GROUP BY customer_id
),
LastOrder AS (
    SELECT 
        customer_id,
        total_amount AS last_order_amount
    FROM sales_data
    WHERE (customer_id, order_date) IN (
        SELECT customer_id, MAX(order_date)
        FROM sales_data
        GROUP BY customer_id)
    )

SELECT 
    c.customer_id,
    c.total_spent,
    l.last_order_amount
FROM CustomerTotal c
JOIN LastOrder l ON c.customer_id = l.customer_id
WHERE c.total_spent > l.last_order_amount;

----(21)----

select *
from sales_data
where unit_price > (
Select avg(unit_price)
from sales_data
);

----(22)----

SELECT 
   *, 
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp) 
        ELSE NULL 
    END AS Tot
FROM MyData;

----(23)----

SELECT 
    ID, 
    SUM(Cost) AS Cost, 
    SUM(Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;



----(24)----

SELECT 
    Level,
    TyZe,
    Result,
    CASE 
        WHEN Result = 'Z' THEN 
            SUM(TyZe) OVER ( ORDER BY (select null))  -- Sum TyZe for 'Z' values partitioned by Result
        ELSE 
            0  -- Set to 0 for 'X' values
    END AS Results
FROM 
    testSuXVI
ORDER BY 
    Level;

select * from testSuXVI


----(25)----

WITH RowNums AS (
    SELECT 
        Id,
        Vals,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL)) AS RowNum
    FROM 
        num
)
SELECT 
    Id,
    Vals,
    CASE 
        WHEN RowNum = 1 THEN 2  -- Set first row to 2
        ELSE (RowNum * 2) - 1  -- For subsequent rows, use odd numbers (2n-1)
    END AS Changed
FROM 
    RowNums
ORDER BY 
    Id, Changed;