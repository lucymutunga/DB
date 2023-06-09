--A query to retrieve the list of orders along with the customer name and staff for each order.
SELECT
o.order_id,
CONCAT(c.first_name, ' ',c.last_name) AS customer_name,
CONCAT(s.first_name ,' ',s.last_name) AS staff_name
FROM

sales.orders o
INNER JOIN sales.customers c ON o.customer_id = c.customer_id
INNER JOIN sales.staffs s ON o.staff_id = s.staff_id;

--A view that returns the total quantity and sales amount for each product 


SELECT
    p.product_id,
    p.product_name,
    b.brand_name,
    c.category_name,
    s.quantity,
    pr.list_price,
    s.quantity * pr.list_price AS sales_amount
FROM
    production.products p
    INNER JOIN production.stocks s ON p.product_id = s.product_id
    INNER JOIN production.categories c ON p.category_id = c.category_id
    INNER JOIN production.brands b ON p.brand_id = b.brand_id
    INNER JOIN production.products pr ON s.product_id = pr.product_id;


	CREATE VIEW sales.product_sales_summary AS
SELECT
    p.product_id,
    p.product_name,
    b.brand_name,
    c.category_name,
    s.quantity,
    pr.list_price,
    s.quantity * pr.list_price AS sales_amount
FROM
    production.products p
    INNER JOIN production.stocks s ON p.product_id = s.product_id
    INNER JOIN production.categories c ON p.category_id = c.category_id
    INNER JOIN production.brands b ON p.brand_id = b.brand_id
    INNER JOIN production.products pr ON s.product_id = pr.product_id;

	SELECT * FROM sales.product_sales_summary;

	--store procedure that accepts customer id and returns total no of orders
CREATE PROCEDURE GetTotalOrders
  @CustomerID INT,
   @TotalOrders INT OUTPUT
AS
BEGIN
    SELECT @TotalOrders = COUNT(*) 
    FROM sales.orders
    WHERE customer_id = @CustomerID;
END
DECLARE @TotalOrders INT;

EXEC GetTotalOrders
    @CustomerID = 123,
    @TotalOrders = @TotalOrders OUTPUT;

SELECT @TotalOrders AS TotalOrders;





