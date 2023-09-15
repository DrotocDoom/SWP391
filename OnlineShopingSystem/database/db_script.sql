USE master;

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'OnlineShopingSystem')
    DROP DATABASE OnlineShopingSystem;

CREATE DATABASE OnlineShopingSystem;

USE OnlineShopingSystem;

-- Create the account table
CREATE TABLE account
(
    [account_id] BIGINT IDENTITY(1, 1) PRIMARY KEY,
    [user_name] VARCHAR(50) NOT NULL,
    [password] VARCHAR(50) NOT NULL
);

-- Create the user table
CREATE TABLE [user]
(
    [user_id] BIGINT IDENTITY(1, 1) PRIMARY KEY,
    [name] VARCHAR(50) NOT NULL,
    [address] VARCHAR(MAX) NOT NULL,
    [dob] VARCHAR(50) NOT NULL,
    [phone] VARCHAR(10) NOT NULL,
    [gmail] VARCHAR(50) NOT NULL,
    [account_id] BIGINT,
    [role_id] INT,
    CONSTRAINT FK_User_Account FOREIGN KEY ([account_id]) REFERENCES account ([account_id]),
    CONSTRAINT FK_User_Role FOREIGN KEY ([role_id]) REFERENCES role ([role_id])
);

-- Create the role table
CREATE TABLE role
(
    [role_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [role_name] VARCHAR(50) NOT NULL
);

-- Create the category table
CREATE TABLE category
(
    [category_id] BIGINT IDENTITY(1, 1) PRIMARY KEY,
    [category_name] VARCHAR(50) NOT NULL,
    [is_active] BIT NOT NULL
);

-- Create the discount table
CREATE TABLE discount
(
    [discount_id] BIGINT IDENTITY(1, 1) PRIMARY KEY,
    [discount_value] DECIMAL(10, 2) NOT NULL,
    [exist_date] DATE NOT NULL,
    [expired_date] DATE NOT NULL,
    [is_active] BIT NOT NULL,
    [min_price] DECIMAL(10, 2) NOT NULL,
    [max_price] DECIMAL(10, 2) NOT NULL
);

-- Create the supplier table
CREATE TABLE supplier
(
    [supplier_id] BIGINT IDENTITY(1, 1) PRIMARY KEY,
    [company_name] VARCHAR(50) NOT NULL,
    [company_address] VARCHAR(MAX) NOT NULL,
    [phone] VARCHAR(10) NOT NULL
);

-- Create the product table
CREATE TABLE product
(
    [product_id] BIGINT IDENTITY(1, 1) PRIMARY KEY,
    [supplier_id] BIGINT,
    [name] VARCHAR(50) NOT NULL,
    [expiry] DATE NOT NULL,
    [mani_date] DATE NOT NULL,
    [discount_id] BIGINT,
    [price] DECIMAL(10, 2) NOT NULL,
    [quantity] INT NOT NULL,
    [is_active] BIT NOT NULL,
    [category_id] BIGINT,
    CONSTRAINT FK_Product_Supplier FOREIGN KEY ([supplier_id]) REFERENCES supplier ([supplier_id]),
    CONSTRAINT FK_Product_Discount FOREIGN KEY ([discount_id]) REFERENCES discount ([discount_id]),
    CONSTRAINT FK_Product_Category FOREIGN KEY ([category_id]) REFERENCES category ([category_id])
);

-- Create the manager_order table
CREATE TABLE manager_order
(
    [manager_order_id] BIGINT IDENTITY(1, 1) PRIMARY KEY,
    [manager_id] INT,
    [order_date] DATETIME,
    [require_date] DATETIME,
    [ship_date] DATETIME,
    [ship_address] VARCHAR(MAX) NOT NULL,
    [status] VARCHAR(20) NOT NULL CHECK ([status] IN ('Pending', 'Confirm', 'Cancelled')),
    [total_price] DECIMAL(10, 2) NOT NULL
);

-- Create the manager_order_detail table
CREATE TABLE manager_order_detail
(   
    [order_item_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [product_id] BIGINT,
    [manager_order_id] BIGINT,
    [price] DECIMAL(10, 2) NOT NULL,
    [quantity] INT NOT NULL,
    CONSTRAINT FK_ManagerOrderDetail_Product FOREIGN KEY ([product_id]) REFERENCES product ([product_id]),
    CONSTRAINT FK_ManagerOrderDetail_ManagerOrder FOREIGN KEY ([manager_order_id]) REFERENCES manager_order ([manager_order_id])
);

-- Create the customer_order table
CREATE TABLE customer_order
(
    [customer_order_id] BIGINT IDENTITY(1, 1) PRIMARY KEY,
    [seller_id] BIGINT,
    [customer_id] INT,
    [order_date] DATETIME,
    [require_date] DATETIME,
    [ship_date] DATETIME,
    [status] VARCHAR(20) NOT NULL CHECK ([status] IN ('Pending', 'Confirm', 'Cancelled')),
    [ship_address] VARCHAR(MAX) NOT NULL,
    [total_price] DECIMAL(10, 2) NOT NULL
);

-- Create the customer_order_detail table
CREATE TABLE customer_order_detail
(   
    [order_item_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [product_id] BIGINT,
    [customer_order_id] BIGINT,
    [price] DECIMAL(10, 2) NOT NULL,
    [quantity] INT NOT NULL,
    CONSTRAINT FK_CustomerOrderDetail_Product FOREIGN KEY ([product_id]) REFERENCES product ([product_id]),
    CONSTRAINT FK_CustomerOrderDetail_CustomerOrder FOREIGN KEY ([customer_order_id]) REFERENCES customer_order ([customer_order_id])
);
