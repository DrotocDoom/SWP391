DROP DATABASE IF EXISTS OnlineShopingSystem;

CREATE DATABASE OnlineShopingSystem;


CREATE TABLE account
(
    [account_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [user_name] VARCHAR(50) NOT NULL,
    [password] VARCHAR(50) NOT NULL
);



CREATE TABLE user
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
    [category_name] VARCHAR(50) NOT NULL
);

CREATE TABLE product
(
    [product_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [provider_id] BIGINT IDENTITY(1,1) PRIMARY KEY,
    [name] VARCHAR(50) NOT NULL,
    [expiry] DATE NOT NULL,
    [mani_date] DATE NOT NULL,
    [discount] DECIMAL(10, 2),
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
    [ship_address] VARCHAR(50) NOT NULL,
    [contract_id] INT

)

CREATE TABLE manager_order_detail
(   
    [order_item_id] INT,
    [product_id] BIGINT,
    [manager_order_id] BIGINT,
    [price] DECIMAL(10, 2) NOT NULL,
    [quantity] INT NOT NULL,
)
