-- a.	Total Products:
SELECT 
    COUNT(productTitle)
FROM
    ecom;

-- b.	Top 10 items sold:
SELECT 
    SUBSTRING(productTitle, 1, 40) AS shortTitle,
    price,
    sold,
    tagText,
    (price * sold) + tagText AS total_sale
FROM
    ecom
ORDER BY total_sale DESC
LIMIT 10;

-- c.	Products with high price but no sales:
SELECT 
    SUBSTRING(productTitle, 1, 40) AS shortTitle, price, sold
FROM
    ecom
WHERE
    sold = 0
ORDER BY price DESC
LIMIT 10;

-- d.	Revenue contribution (% per product):
SELECT 
  SUBSTRING(productTitle, 1, 40) AS shortTitle, 
  price, 
  sold, 
  (price * sold) AS revenue,
  ROUND((price * sold) / (SELECT SUM(price * sold) FROM ecom) * 100, 2) AS revenue_contribution_percent
  FROM 
  ecom
  ORDER BY 
  revenue_contribution_percent DESC;

-- e.	No of Products with 0 sales:
SELECT 
    COUNT(producttitle)
FROM
    ecom
WHERE
    sold = 0;

-- f.	Price Share of Each Product in the Overall Catalog:
SELECT 
  SUBSTRING(productTitle, 1, 40) AS shortTitle, 
  price,
  ROUND(price / (SELECT SUM(price) FROM ecom) * 100, 2) AS price_percentage
FROM 
  ecom
ORDER BY 
  price_percentage DESC;

-- g.	Sales by price band → <$50, $50–$200, $200–$500, etc:
SELECT 
    CASE
        WHEN price < 50 THEN '< ₹50'
        WHEN price BETWEEN 50 AND 200 THEN '₹50 - ₹200'
        WHEN price BETWEEN 200 AND 500 THEN '₹200 - ₹500'
        WHEN price BETWEEN 500 AND 1000 THEN '₹500 - ₹1000'
        ELSE '> ₹1000'
    END AS price_band,
    SUM(sold) AS total_units_sold
FROM
    ecom
GROUP BY price_band
ORDER BY CASE
    WHEN price_band = '< ₹50' THEN 1
    WHEN price_band = '₹50 - ₹200' THEN 2
    WHEN price_band = '₹200 - ₹500' THEN 3
    WHEN price_band = '₹500 - ₹1000' THEN 4
    ELSE 5
END

-- h.	Top categories by sales count:
SELECT 
    CASE
        WHEN productTitle LIKE '%sofa%' THEN 'Sofa'
        WHEN productTitle LIKE '%Table%' THEN 'Table'
        WHEN productTitle LIKE '%Chair%' THEN 'Chairs'
        ELSE 'Other'
    END AS category,
    COUNT(producttitle) AS total_units_sold
FROM
    ecom
GROUP BY category
ORDER BY category DESC;

-- i.	Top categories by total revenue:
SELECT 
    CASE
        WHEN productTitle LIKE '%sofa%' THEN 'Sofa'
        WHEN productTitle LIKE '%Table%' THEN 'Table'
        WHEN productTitle LIKE '%Chair%' THEN 'Chairs'
        ELSE 'Other'
    END AS category,
    sum(sold) AS total_units_sold
FROM
    ecom
GROUP BY category
ORDER BY total_units_sold DESC;

-- j.	Identify luxury items not selling
SELECT 
    *
FROM
    ecom
WHERE
    sold = 0
ORDER BY price DESC
LIMIT 10;

