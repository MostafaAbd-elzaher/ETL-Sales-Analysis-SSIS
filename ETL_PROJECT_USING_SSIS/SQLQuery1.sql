CREATE DATABASE Gravity_warehouse

USE Gravity_warehouse

CREATE TABLE DimCustomer
(
customer_sk int primary key identity(1,1),
customer_id int Not null,
first_name varchar(50) NOT NULL ,
last_name varchar(50),
email varchar(50) NOT NULL,
address_id INT NOT NULL,
address_status VARCHAR(200),
status_id INT NOT NULL,
street_number INT ,
street_name VARCHAR(100),
city VARCHAR(50), 
country_id INT ,
country_name VARCHAR(100),
valid_from DATETIME,
valid_to DATETIME
)


CREATE TABLE Dim_Book
(
book_sk int primary key identity(1,1),
book_id int not null,
isbn13 int ,
language_id int,
num_pages int not null,
publication_date date,
publisher_id int not null,
publisher_name varchar(200),
language_code varchar(10),
language_name varchar(20),
auther_id int ,
auther_name varchar(100) not null,
valid_from datetime,
valid_to datetime

)


CREATE TABLE DateDim
(
    DateKey INT PRIMARY KEY,         -- Unique key in format YYYYMMDD
    FullDate DATE NOT NULL,          -- Full date value
    Day INT NOT NULL,                -- Day number (1-31)
    DayName NVARCHAR(20) NOT NULL,   -- Day name (e.g., Monday, Tuesday)
    Week INT NOT NULL,               -- Week number of the year
    Month INT NOT NULL,              -- Month number (1-12)
    MonthName NVARCHAR(20) NOT NULL, -- Month name (e.g., January)
    Quarter INT NOT NULL,            -- Quarter of the year (1-4)
    Year INT NOT NULL,               -- Year (e.g., 2025)
    IsWeekend BIT NOT NULL           -- 1 if weekend, 0 otherwise
);

--insert date from 1900 to 2030 


DECLARE @StartDate DATE = '1900-01-01';
DECLARE @EndDate DATE   = '2030-12-31';

;WITH DateSequence AS
(
    SELECT @StartDate AS TheDate
    UNION ALL
    SELECT DATEADD(DAY, 1, TheDate)
    FROM DateSequence
    WHERE TheDate < @EndDate
)
INSERT INTO DateDim (DateKey, FullDate, Day, DayName, Week, Month, MonthName, Quarter, Year, IsWeekend)
SELECT 
    CONVERT(INT, FORMAT(TheDate, 'yyyyMMdd')) AS DateKey,   -- YYYYMMDD format
    TheDate AS FullDate,                                    -- Full date
    DAY(TheDate) AS Day,                                    -- Day number
    DATENAME(WEEKDAY, TheDate) AS DayName,                  -- Day name
    DATEPART(WEEK, TheDate) AS Week,                        -- Week number
    MONTH(TheDate) AS Month,                                -- Month number
    DATENAME(MONTH, TheDate) AS MonthName,                  -- Month name
    DATEPART(QUARTER, TheDate) AS Quarter,                  -- Quarter number
    YEAR(TheDate) AS Year,                                  -- Year
    CASE WHEN DATENAME(WEEKDAY, TheDate) IN ('Friday','Saturday') 
         THEN 1 ELSE 0 END AS IsWeekend                     -- Weekend flag
FROM DateSequence
OPTION (MAXRECURSION 0);



ALTER TABLE DateDim
ADD Date_sk  int primary key identity(1,1)

ALTER TABLE DateDim
DROP CONSTRAINT  PK__DateDim__40DF45E339247F0D
-------------------------------------------------------------------
SELECT name
FROM sys.key_constraints
WHERE type = 'PK' AND parent_object_id = OBJECT_ID('DateDim');
-------------------------------------------------------------------

CREATE TABLE Fact_table
(
customer_sk INT NOT NULL,
book_sk INT NOT NULL,
Date_sk INT NOT NULL,
book_price DECIMAL(6,2),
shipping_cost DECIMAL(6,2),
CONSTRAINT FK_CUSTOMER FOREIGN KEY (customer_sk) REFERENCES DimCustomer(customer_sk),
CONSTRAINT FK_BOOK FOREIGN KEY (book_sk) REFERENCES Dim_Book(book_sk),
CONSTRAINT FK_Date FOREIGN KEY (Date_sk) REFERENCES DateDim(Date_sk),

)



USE gravity_books
SELECT B.book_id,B.title,B.isbn13,B.language_id,B.num_pages,B.publisher_id,B.publication_date,B.title,BL.language_name,BL.language_code,PU.publisher_name,B_A.author_id,AU.author_name
FROM book B INNER JOIN book_language BL
ON B.language_id=BL.language_id 
INNER JOIN publisher PU 
ON PU.publisher_id=B.publisher_id
INNER JOIN book_author B_A
ON B_A.book_id=B.book_id
INNER JOIN author AU
ON AU.author_id=B_A.author_id

use Gravity_warehouse

sp_help dim_book

SP_HELP BOOK

use Gravity_warehouse
ALTER TABLE DIM_BOOK
ALTER COLUMN isbn13 varchar(20)

use Gravity_warehouse
ALTER TABLE DIM_BOOK
ALTER COLUMN publisher_name varchar(400) not null



USE gravity_books
SELECT C.customer_id,C.email,C.first_name,C.last_name,CA.address_id,
CA.status_id,ad.address_status,[add].street_name,[add].street_number,
[add].country_id,[add].city,co.country_name
FROM customer C 
INNER JOIN customer_address CA
ON CA.customer_id=C.customer_id
INNER JOIN address_status ad
on ad.status_id=ca.status_id
inner join [address] [add]
on [add].address_id=ca.address_id
inner join country co
on co.country_id=[add].country_id



use Gravity_warehouse
ALTER TABLE DimCustomer
--ALTER COLUMN first_name varchar(200)
ALTER COLUMN last_name varchar(200)


USE gravity_books

select customer_id , price , OL.book_id  , SM.cost ,order_date 
from cust_order CO
inner join order_line OL
on CO.order_id = OL.order_id
inner join book B
on OL.book_id = B.book_id
inner join shipping_method SM
on CO.shipping_method_id = SM.method_id

use Gravity_warehouse
alter table fact_table
add order_date date




use Gravity_warehouse

SELECT * FROM Dim_Book
SELECT * FROM DimCustomer
SELECT * FROM DateDim
SELECT * FROM Fact_table