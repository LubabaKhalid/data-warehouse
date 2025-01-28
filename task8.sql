WITH SalesData AS (
    SELECT
        c.CategoryID,
        YEAR(o.OrderDate) AS Year,
        MONTH(o.OrderDate) AS Month,
        SUM(od.UnitPrice * od.Quantity) AS MonthlySales
    FROM 
        Categories c
    JOIN 
        Products p ON c.CategoryID = p.CategoryID
    JOIN 
        OrderDetails od ON p.ProductID = od.ProductID
    JOIN 
        Orders o ON od.OrderID = o.OrderID
    GROUP BY 
        c.CategoryID, 
        YEAR(o.OrderDate), 
        MONTH(o.OrderDate)
)
SELECT
    CategoryID, 
    Year, 
    Month, 
    MonthlySales,
    AVG(MonthlySales) OVER (PARTITION BY CategoryID ORDER BY Year, Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM 
    SalesData;
