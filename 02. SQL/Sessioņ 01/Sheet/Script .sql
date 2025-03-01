use GDGC


-------------- Social Media

--create table user
Create table UserInfo 
(
	Id int ,
	name nvarchar(50),
    email nvarchar(50) ,
	BOD date ,
	Gender nvarchar(50) ,
	JoinDate date,

	primary key (id)
)
 --create table post
Create table Post (
    Id int ,
    Content text,
    Date datetime,
    Visibility varchar(50),
    userId int,
	primary key (id),

    FOREIGN KEY (userId) REFERENCES UserInfo(id) ON DELETE CASCADE
);

CREATE TABLE Comment (
    Id INT  ,
    Content TEXT,
    Date DATETIME,
    userId INT,
    PostID INT,
	primary key (Id),
    FOREIGN KEY (userId) REFERENCES Userinfo(id)  ,
    FOREIGN KEY (PostID) REFERENCES Post(id)  
);

CREATE TABLE Interaction (
    id INT PRIMARY KEY,
    Date DATETIME,
    Type VARCHAR(50),
    Post_ID INT,
    FOREIGN KEY (Post_ID) REFERENCES Post(id)  
);

CREATE TABLE User_Interaction (
    InteractionID INT,
    UserID INT,
    PostID INT,
    PRIMARY KEY (InteractionID, UserID, PostID),
    FOREIGN KEY (InteractionID) REFERENCES Interaction(id) ,
    FOREIGN KEY (UserID) REFERENCES UserInfo(ID) ,
    FOREIGN KEY (PostID) REFERENCES Post(id)  
);


-- Insert Users
INSERT INTO Userinfo (id, name, Email, BOD, Gender, JoinDate)
VALUES 
(1, 'abdullah Ali', 'abdullah@gmail.com', '2000-04-20', 'Male', '2025-01-10'),
(2, 'Mona', 'Mona@gmail.com', '1999-07-15', 'Female', '2025-02-05');

-- Insert Posts
INSERT INTO Post  
VALUES 
(1, 'Hi Every one!', '2024-03-01 10:30:00', 'Public', 1),
(2, 'Hello GDGC', '2024-03-02 12:00:00', 'Friends', 2);

-- Insert Comments
INSERT INTO Comment  
VALUES 
(1, 'My Name Is Abdullah', '2024-03-01 11:00:00', 2, 1),
(2, 'Thanks for sharing!', '2024-03-02 12:30:00', 1, 2);

-- Insert Interactions (Likes, Shares, etc.)
INSERT INTO Interaction  
VALUES 
(1, '2024-03-01 11:15:00', 'Like', 1),
(2, '2024-03-02 12:45:00', 'Share', 2);

-- Insert User Interactions
INSERT INTO User_Interaction (InteractionID, UserID, PostID)
VALUES 
(1, 2, 1), 
(2, 1, 2); 
----------------------------------------------------------------------
-- Customer Table
-- Customer Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address TEXT
);

-- Product Table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL,
    Description TEXT
);

-- Supplier Table
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContentInfo TEXT
);

-- Order Table
CREATE TABLE Orders (  -- Avoid using "Order" as it's a reserved keyword
    OrderID INT PRIMARY KEY,
    Status VARCHAR(50) NOT NULL,
    Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Cus_ID INT NOT NULL,
    FOREIGN KEY (Cus_ID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);

-- Order Details Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
);

-- Many-to-Many: Product & Order
CREATE TABLE Product_Order (
    ProductID INT NOT NULL,
    OrderID INT NOT NULL,
    PRIMARY KEY (ProductID, OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);

-- Many-to-Many: Product & Supplier
CREATE TABLE Product_Supplier (
    ProductID INT NOT NULL,
    Supp_ID INT NOT NULL,
    PRIMARY KEY (ProductID, Supp_ID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (Supp_ID) REFERENCES Supplier(SupplierID) ON DELETE CASCADE
);
-----------
-- Insert Customers
INSERT INTO Customer (CustomerID, Name, Email, Phone, Address) VALUES
(1, 'Alice Johnson', 'alice@example.com', '123-456-7890', '123 Main St, NY'),
(2, 'Bob Smith', 'bob@example.com', '987-654-3210', '456 Elm St, CA');

-- Insert Products
INSERT INTO Product (ProductID, Name, Category, Price, Description) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 'High-performance laptop'),
(2, 'Smartphone', 'Electronics', 800.00, 'Latest smartphone');

-- Insert Suppliers
INSERT INTO Supplier (SupplierID, Name, ContentInfo) VALUES
(1, 'TechSupplier Inc.', 'techsupplier@example.com'),
(2, 'GadgetWorld Ltd.', 'gadgetworld@example.com');

-- Insert Orders
INSERT INTO Orders (OrderID, Status, Date, TotalAmount, Cus_ID) VALUES
(1, 'Shipped', getdate(), 2000.00, 1),
(2, 'Pending', getdate(), 800.00, 2);

-- Insert Order Details
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Price, Quantity) VALUES
(1, 1, 1, 1200.00, 1),
(2, 2, 2, 800.00, 1);

-- Insert Product-Order Mapping
INSERT INTO Product_Order (ProductID, OrderID) VALUES
(1, 1),
(2, 2);

-- Insert Product-Supplier Mapping
INSERT INTO Product_Supplier (ProductID, Supp_ID) VALUES
(1, 1), 
(2, 2);  






