
-- Adding sales reports
-- task 1 create a view
USE littlelemondb;
SELECT * FROM ordersview;

-- task 2
SELECT customers.CustomerID, customers.CustomerName, orders.OrderID, orders.TotalCost, menus.MenuName, menuitems.CourseName, menuitems.StarterName
FROM customers 
INNER JOIN orders ON customers.CustomerID = orders.CustomerID
INNER JOIN menus ON orders.MenuID = menus.MenuID
INNER JOIN menuitems ON menus.MenuItemsID = menuitems.MenuItemsID
ORDER BY orders.TotalCost ASC;

-- task 3
SELECT MenuName
FROM menus
WHERE MenuID IN (
    SELECT MenuID
    FROM orders
    GROUP BY MenuID
    HAVING COUNT(*) > 2
);



-- task 1 Week 2 create stored procedure

DELIMITER //  

CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT Max(Quantity) AS MaxQuantityinOrder FROM orders;
END // 

DELIMITER ;

CALL GetMaxQuantity();

-- task 2 week 2 create prepared statement
PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM orders WHERE BookingID = ?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- task 3 week 2 create stored procedure that deletes an order

DELIMITER //  

CREATE PROCEDURE CancelOrder(IN orderid INT)
BEGIN
	DELETE FROM orders WHERE OrderID = orderid;
END // 

DELIMITER ;

CALL CancelOrder();


