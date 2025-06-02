USE CustomerOrderDB;

-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    DeliveryDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Delivery_Status table
CREATE TABLE Delivery_Status (
    StatusID INT PRIMARY KEY,
    OrderID INT,
    CurrentStatus VARCHAR(100),
    LastUpdated DATETIME,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

--CRUD Operations---
-- INSERT sample Indian customers
INSERT INTO Customers (CustomerID, Name, Email, Phone)
VALUES 
(101, 'Amit Sharma', 'amit.sharma@example.com', '9876543210'),
(102, 'Priya Singh', 'priya.singh@example.com', '9123456780');

-- INSERT sample orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, DeliveryDate, Status)
VALUES 
(1, 101, '2024-05-01', '2024-05-05', 'Delivered'),
(2, 102, '2024-05-03', '2024-05-10', 'Pending');

-- READ all orders
SELECT * FROM Orders;

-- UPDATE order status to 'Delayed'
UPDATE Orders SET Status = 'Delayed' WHERE OrderID = 2;

-- DELETE an order
DELETE FROM Orders WHERE OrderID = 1;


--Stored procedure(Delayed Delivery)
CREATE PROCEDURE GetDelayedDeliveriesByCustomer
    @CustomerID INT
AS
BEGIN
    SELECT OrderID, OrderDate, DeliveryDate, Status
    FROM Orders
    WHERE CustomerID = @CustomerID AND DeliveryDate < GETDATE() AND Status != 'Delivered';
END;
