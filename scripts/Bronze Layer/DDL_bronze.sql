/*
====================================================================
DDL Script: Create Bronze Tables
====================================================================

Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables
====================================================================
*/

CREATE or ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME ,@batch_start_time DATETIME,@batch_end_time DATETIME   ---For the Load time ---
  	BEGIN TRY
  		SET @batch_start_time =GETDATE();
  		Print '=======================================';
  		Print 'Loading BRONZE Layer';
  		Print '=======================================';
  
          Print '------------------------------------';
  		Print 'Loading CRM Tables';
  		Print '------------------------------------';
  
  		SET @start_time = GETDATE();                 ----Start time of Table loading---
  		Print '>> Truncating Table: bronze.crm_cust_info';
  		
  		TRUNCATE TABLE bronze.crm_cust_info;
  
  	    Print '>> Inserting Data INTO: bronze.crm_cust_info';
  
  		BULK INSERT bronze.crm_cust_info
  		FROM 'C:\Users\Akash\OneDrive\DATAWAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
  		WITH (
  			FIRSTROW =2,
  			FIELDTERMINATOR =',',
  			TABLOCK
  		);
  		SET @end_time = GETDATE();                           ----End time of Table loading---
  		Print '>> Load Duration: ' + CAST(DATEDIFF (Second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
  		Print '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';
  
  		SET @start_time =GETDATE();
  		Print '>> Truncating Table: bronze.crm_prd_info';
  
  		TRUNCATE TABLE bronze.crm_prd_info;
  		
  		Print '>> Inserting Data INTO: bronze.crm_prd_info';
  
  		BULK INSERT bronze.crm_prd_info
  		FROM 'C:\Users\Akash\OneDrive\DATAWAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
  		WITH (
  			FIRSTROW =2,
  			FIELDTERMINATOR =',',
  			TABLOCK
  		);
  		SET @end_time = GETDATE();
  		Print '>> Load Duration: ' + CAST(DATEDIFF (Second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
  		Print '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';
  
  		SET @start_time =GETDATE();
  		Print '>> Truncating Table: bronze.crm_sales_details';
  
  		TRUNCATE TABLE bronze.crm_sales_details;
  
  		Print '>> Inserting Data INTO: bronze.crm_sales_details';
  
  		BULK INSERT bronze.crm_sales_details
  		FROM 'C:\Users\Akash\OneDrive\DATAWAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
  		WITH (
  			FIRSTROW =2,
  			FIELDTERMINATOR =',',
  			TABLOCK
  		);
  		SET @end_time = GETDATE();
  		Print '>> Load Duration: ' + CAST(DATEDIFF (Second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
  		Print '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';
  
  		PRINT '------------------------------------';
  		PRINT 'Loading CRM Tables';
  		PRINT '------------------------------------';
  
  		SET @start_time = GETDATE();
  		Print '>> Truncating Table: bronze.erp_cust_az12';
  
  		TRUNCATE TABLE bronze.erp_cust_az12;
  
  		Print '>> Inserting Data INTO: bronze.erp_cust_az12';
  
  		BULK INSERT bronze.erp_cust_az12
  		FROM 'C:\Users\Akash\OneDrive\DATAWAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
  		WITH (
  			FIRSTROW =2,
  			FIELDTERMINATOR =',',
  			TABLOCK
  		);
  		SET @end_time = GETDATE();
  		Print '>> Load Duration: ' + CAST(DATEDIFF (Second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
  		Print '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';
  
  		SET @start_time= GETDATE();
  		Print '>> Truncating Table: bronze.erp_loc_a101';
  
  		TRUNCATE TABLE bronze.erp_loc_a101;
  
  		Print '>> Inserting Data INTO: bronze.erp_loc_a101';
  
  		BULK INSERT bronze.erp_loc_a101
  		FROM 'C:\Users\Akash\OneDrive\DATAWAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
  		WITH (
  			FIRSTROW =2,
  			FIELDTERMINATOR =',',
  			TABLOCK
  		);
  		SET @end_time = GETDATE();
  		Print '>> Load Duration: ' + CAST(DATEDIFF (Second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
  		Print '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';
  		Print '>> Truncating Table: bronze.erp_px_cat_g1v2';
  
  		SET @start_time =GETDATE();
  		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
  
  		Print '>> Inserting Data INTO: bronze.erp_px_cat_g1v2';
  
  		BULK INSERT bronze.erp_px_cat_g1v2
  		FROM 'C:\Users\Akash\OneDrive\DATAWAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
  		WITH (
  			FIRSTROW =2,
  			FIELDTERMINATOR =',',
  			TABLOCK
  		);
  		SET @end_time = GETDATE();
  		Print '>> Load Duration: ' + CAST(DATEDIFF (Second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
  		Print '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';
  
  		SET @batch_end_time = GETDATE();
  		Print '=====================================';
  		Print 'Loading Bronze Layer is Completed'
  	  Print 'Bronze Layer Loading Duration: ' + CAST (DATEDIFF(Second,@batch_start_time,@batch_end_time) AS NVARCHAR) +'Seconds';
  		Print '======================================'
  
  	END TRY
  	BEGIN CATCH 
  	Print '========================================'
  	Print 'Error Occured During Loading Bronze Layer'
  	Print 'Eroor Message' + ERROR_MESSAGE ();
  	Print 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
  	Print 'Error MEssage' + CAST(ERROR_STATE() AS NVARCHAR);
  	Print '========================================'
  	END CATCH
	
END;

=====================================================================================================
EXEC bronze.load_bronze;                       
