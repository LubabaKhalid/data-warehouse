import pyodbc
from faker import Faker
import random


conn = pyodbc.connect(
    "Driver={ODBC Driver 17 for SQL Server};"
    "Server=DESKTOP-8BL3MIG\\SQLEXPRESS;"  
    "Database=Lab3;"                      
    "Trusted_Connection=yes;"
)

cursor = conn.cursor()


fake = Faker()

def populate_regions(n):
    for _ in range(n):
        region_id = fake.unique.random_int(min=1, max=1000) 
        region_desc = fake.city_suffix()[:50]  
        cursor.execute(
            "INSERT INTO Regions (RegionID, RegionDescription) VALUES (?, ?)",
            region_id, region_desc
        )


def populate_territories(n):
    cursor.execute("SELECT RegionID FROM Regions")
    region_ids = [row[0] for row in cursor.fetchall()]  
    for _ in range(n):
        territory_id = fake.unique.zipcode()  
        territory_desc = fake.city()[:50]  
        region_id = random.choice(region_ids)  
        cursor.execute(
            "INSERT INTO Territories (TerritoryID, TerritoryDescription, RegionID) VALUES (?, ?, ?)",
            territory_id, territory_desc, region_id
        )


def populate_shippers(n):
    existing_ids = cursor.execute("SELECT ShipperID FROM Shippers").fetchall()
    existing_ids_set = {row[0] for row in existing_ids}  
    for _ in range(n):
        shipper_id = random.randint(1, 100)
        while shipper_id in existing_ids_set:  
            shipper_id = random.randint(1, 100)

        company_name = fake.company()[:40]  
        phone = fake.phone_number()[:24] 

        cursor.execute(
            "INSERT INTO Shippers (ShipperID, CompanyName, Phone) VALUES (?, ?, ?)",
            shipper_id, company_name, phone
        )
        existing_ids_set.add(shipper_id)  


def populate_customers(n):
    for _ in range(n):
        customer_id = fake.unique.random_int(min=1000, max=9999)  
        company_name = fake.company()[:40]  
        contact_name = fake.name()[:30]  
        contact_title = fake.job()[:30]  
        address = fake.address().replace('\n', ', ')[:60]  
        city = fake.city()[:15] 
        region = fake.state_abbr()[:15] 
        postal_code = fake.zipcode()[:10]  
        country = fake.country()[:15]  
        phone = fake.phone_number()[:24]  
        fax = fake.phone_number()[:24]  

        cursor.execute(
            "INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax
        )


populate_regions(10)  
populate_territories(20)  
populate_shippers(10)  
populate_customers(20)  


conn.commit()

conn.close()

print("Data inserted successfully!")
