-- Create Dimension Tables First

CREATE TABLE Restaurant_Dimension (
    Restaurant_ID INT PRIMARY KEY,
    Restaurant_Name VARCHAR(255),
    Cuisine_Type VARCHAR(100),
    Location VARCHAR(255),
    Rating DECIMAL(2, 1)
);

CREATE TABLE Customer_Dimension (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(255),
    Email VARCHAR(255),
    Loyalty_Tier VARCHAR(50),
    Join_Date DATE
);

CREATE TABLE Delivery_Dimension (
    Delivery_ID INT PRIMARY KEY,
    Delivery_Person_Name VARCHAR(255),
    Vehicle_Type VARCHAR(50),
    Delivery_Status VARCHAR(50),
    Delivery_Time TIME
);

CREATE TABLE Menu_Item_Dimension (
    Menu_Item_ID INT PRIMARY KEY,
    Item_Name VARCHAR(255),
    Cuisine_Type VARCHAR(100),
    Price DECIMAL(10, 2)
);

CREATE TABLE Date_Dimension (
    Date_ID INT PRIMARY KEY,
    Date DATE,
    Day VARCHAR(10),
    Month VARCHAR(20),
    Year INT,
    Quarter INT
);

-- Then create the Fact Table

CREATE TABLE Order_Fact (
    Order_ID INT PRIMARY KEY,
    Restaurant_ID INT,
    Customer_ID INT,
    Delivery_ID INT,
    Menu_Item_ID INT,
    Date_ID INT,
    Quantity INT,
    Total_Amount DECIMAL(10, 2),
    Delivery_Fee DECIMAL(10, 2),
    FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant_Dimension(Restaurant_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer_Dimension(Customer_ID),
    FOREIGN KEY (Delivery_ID) REFERENCES Delivery_Dimension(Delivery_ID),
    FOREIGN KEY (Menu_Item_ID) REFERENCES Menu_Item_Dimension(Menu_Item_ID),
    FOREIGN KEY (Date_ID) REFERENCES Date_Dimension(Date_ID)
);
