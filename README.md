# Grafity Books ETL Project (SSIS)

## Project Overview
This project demonstrates an **ETL (Extract – Transform – Load)** process built using **SQL Server Integration Services (SSIS)**.  
The main goal was to transform an operational database (*Grafity Books*) into a structured **Data Warehouse** that supports analytical queries and reporting.

---

## Tools & Technologies
- Microsoft SQL Server
- SQL Server Integration Services (SSIS)
- SQL Scripts (T-SQL)

---

## Project Structure
- **SSIS Solution**: Contains `.dtsx` packages for the ETL process.  
- **Source Database**: The original *Grafity Books* database (OLTP).  
- **Data Warehouse Database**: Contains Dimension & Fact tables (Star Schema).  
- **SQL Scripts**: Create/Insert scripts for databases and tables.

---

## ETL Process
1. **Extract**  
   - Pulled data from the *Grafity Books* source database.  

2. **Transform**  
   - Cleaned and transformed data.  
   - Implemented lookups to map business keys to surrogate keys in dimension tables.  

3. **Load**  
   - Loaded the data into a **Star Schema**:  
     - `Customer Dimension`  
     - `Book Dimension`  
     - `Date Dimension`  
     - `Fact Table`  

---

## Use Cases
With this Data Warehouse, analysts can easily answer questions such as:  
- Which books are the top sellers? 📚  
- Who are the most active customers? 👥  
- How are sales trending over time (monthly, quarterly, yearly)? 📈  

---

## How to Run
1. Restore/Create the **Source Database** (Grafity Books) using the provided SQL script.  
2. Open the **SSIS Solution** in Visual Studio (SQL Server Data Tools).  
3. Run the ETL packages to populate the **Data Warehouse**.  
4. Query the Data Warehouse to analyze sales, customers, and books.

---

## 📽️ Demo Video
A short video explaining the project and showing the ETL workflow is available [here](https://www.linkedin.com/posts/mostafa-abdelzaher_dataengineering-etl-ssis-activity-7367959442304172032-N7Ug?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEVHA8wB_mXG5dC5J3ayO2HtqI-pwqAsrXE).

---

## 💻 Author
**Mostafa Abdelzaher**  
- LinkedIn: https://www.linkedin.com/in/mostafa-abdelzaher/ 
- GitHub: https://github.com/MostafaAbd-elzaher
