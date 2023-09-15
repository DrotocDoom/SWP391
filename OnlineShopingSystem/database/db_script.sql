USE master;

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'OnlineShopingSystem')
DROP DATABASE OnlineShopingSystem;

CREATE DATABASE OnlineShopingSystem;


CREATE TABLE account
(
    [account_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [user_name] VARCHAR(50) NOT NULL,
    [password] VARCHAR(50) NOT NULL
);

CREATE TABLE [user]
(
    [user_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [name] VARCHAR(50) NOT NULL,
    [address] VARCHAR(50) NOT NULL,
    [dob]  VARCHAR(50) NOT NULL,
    [phone] VARCHAR(10) NOT NULL,
    [gmail] VARCHAR(50) NOT NULL,
    [account_id] BIGINT,
    [role_id] INT,
);

CREATE TABLE role
(
    role_id INT IDENTITY(1,1) PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);


CREATE TABLE category
(
    [category_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [category_name] VARCHAR(50) NOT NULL,
    [is_active] BIT NOT NULL
);


CREATE TABLE discount
(
    [discount_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [discount_value] DECIMAL(10, 2) NOT NULL,
    [exist_date] DATE NOT NULL,
    [expired_date] DATE NOT NULL,
    [is_active] BIT NOT NULL,
    [min_price] DECIMAL(10, 2) NOT NULL,
    [max_price] DECIMAL(10, 2) NOT NULL
);

CREATE TABLE supplier
(
    [supplier_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [company_name] VARCHAR(50) NOT NULL,
    [company_address] VARCHAR(max) NOT NULL,
    [phone] VARCHAR(10) NOT NULL
);


CREATE TABLE product
(
    [product_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [supplier_id] BIGINT,
    [name] VARCHAR(50) NOT NULL,
    [expiry] DATE NOT NULL,
    [mani_date] DATE NOT NULL,
    [discount_id] BIGINT,
    [price] DECIMAL(10, 2) NOT NULL,
    [quantity] INT NOT NULL,
    [is_active] BIT NOT NULL,
    [category_id] BIGINT,
);


CREATE TABLE manager_order
(
    [manager_order_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [manager_id] INT,
    [order_date] DATE,
    [require_date] DATE,
    [ship_date] DATE,
    [ship_address] VARCHAR(max) NOT NULL,
    [status] VARCHAR(20) NOT NULL CHECK ([status] IN ('Pending', 'Confirm', 'Cancelled')),
    [total_price] DECIMAL(10, 2) NOT NULL
)

CREATE TABLE manager_order_detail
(   
    [order_item_id] INT,
    [product_id] BIGINT,
    [manager_order_id] BIGINT,
    [price] DECIMAL(10, 2) NOT NULL,
    [quantity] INT NOT NULL,
)


CREATE TABLE customer_order
(
    [customer_order_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [seller_id] BIGINT,
    [customer_id] INT,
    [order_date] DATE,
    [require_date] DATE,
    [ship_date] DATE,
    [status] VARCHAR(20) NOT NULL CHECK ([status] IN ('Pending', 'Confirm', 'Cancelled')),
    [ship_address] VARCHAR(max) NOT NULL,
    [total_price] DECIMAL(10, 2) NOT NULL
)

CREATE TABLE customer_order_detail
(   
    [order_item_id] INT,
    [product_id] BIGINT,
    [customer_order_id] BIGINT,
    [price] DECIMAL(10, 2) NOT NULL,
    [quantity] INT NOT NULL,
)
