WITH EmployeeSales AS (
    SELECT
        e.EmployeeID,
        SUM(od.UnitPrice * od.Quantity) AS SalesAmount
    FROM 
        Orders o
    JOIN 
        OrderDetails od ON o.OrderID = od.OrderID
    JOIN 
        Employees e ON o.EmployeeID = e.EmployeeID
    WHERE 
        YEAR(o.OrderDate) = 1997
    GROUP BY 
        e.EmployeeID
)
SELECT
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    SUM(od.UnitPrice * od.Quantity) AS PersonalSales,
    (SELECT SUM(SalesAmount) 
     FROM EmployeeSales es 
     WHERE es.EmployeeID = e.EmployeeID 
     OR es.EmployeeID IN (SELECT EmployeeID FROM Employees WHERE ReportsTo = e.EmployeeID)
    ) AS TotalSalesWithSubordinates
FROM 
    Employees e
JOIN 
    Orders o ON e.EmployeeID = o.EmployeeID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
WHERE 
    YEAR(o.OrderDate) = 1997
GROUP BY 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName;
