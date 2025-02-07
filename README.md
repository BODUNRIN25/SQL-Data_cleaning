# Cafe Store Sales Data Cleaning

This README file documents the data cleaning process performed on the cafe store sales dataset. The goal of this cleaning was to prepare the data for analysis and reporting, ensuring accuracy and consistency.

## Dataset Description

The dataset contains sales transactions for a cafe store, spanning 2023-01-01 to 2023-12-31.  It includes information such as:

*   Transaction ID
*   Item
*   Quantity
*   Price_per_unit
*   Total_Spent
*   Payment Method
*   Location
*   Transaction_Date

## Data Cleaning Objectives

The primary objectives of this data cleaning process were to:

*   Handle missing values.
*   Correct inconsistent data entries.
*   Standardize data formats.
*   Remove duplicate records.
*   Ensure data type consistency.

## Cleaning Steps

The following steps were taken to clean the data:

1.  **Missing Value Handling:**
    *   NULL values in the `Payment_Method` column were replaced with 'Others'
    *   NULL values in the `Item` column were replaced with 'Unknown'
    *   Rows with missing values in `Price_Per_Unit` and `Total_Spent` were removed.
    *   Rows with missing values in `Quantity` and `Total_Spent` were removed.
    *   Rows with missing values in `Price_Per_Unit` and `Quantity` were removed.
    *   NULL values in the `price_per_unit` column were replaced with the result of dividing `total_spent` by `Quantity`.
    *   NULL values in the `Quantity` column were replaced with the result of dividing `total_spent` by `Price_Per_Unit`.
    *   NULL values in the `Total_Spent` column were replaced with the result of multiplying `Quantity` by `Price_Per_Unit`.
2.  **Inconsistent Data Correction:**
    *   Error values in the `Location`, `Item`  column were replaced with 'Unknown'
    *   Error values in the `item` column were replaced with 'Unknown'
    *   `Location`, `Item`, `Location` values with 'UNKNOWN' was replaced with 'Unknown'
    *   Error values in the `Quantity` column were replaced with NULL
    *   Rows with UNKNOWN values in the `Quantity` column were replaced with NULL

3.  **Duplicate Record Removal:**
    *   There was no duplicate values found in the dataset

4.  **Data Type Consistency:**
    *   `Quantity` column was converted to integer

## Tools Used

*   SQL Server was used for the Data cleaning

## Output

The cleaned data is saved in a file named `clean_cafe_sales.csv`.
