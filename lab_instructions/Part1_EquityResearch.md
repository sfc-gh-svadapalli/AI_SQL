# AI SQL Part 1 Equity Research: HOL Setup

This lab introduces a new era for SQL analytics, bridging the gap between analysts and AI engineer capabilities. By leveraging SQL with AI-powered operators in Snowflake, analysts can easily access and analyze multimodal data at scale. The solution combines simple SQL syntax with high-performance processing at a lower cost, delivering trusted insights across the enterprise.


### Part 1: Equity Research Data

The first example focuses on equity research data. This involves using Snowflake Marketplace for common S\&P 500 stock tickers and documents containing press releases from various organizations about their company initiatives. These two data sources will be combined with AI SQL to gain insights from both structured and unstructured data, insights previously only available to AI Engineers but now easily accessible by analysts.

**Outline of Part 1:**

  * Ingest text data related to stock market information
  * Ingest PDF documents and parse them into a table for analysis by Cortex
  * Filter data using AI SQL
  * Aggregate data using AI SQL
  * Summarize data using AI SQL

---
## Step 1: Download Files for the Lab and Upload Them to the Stage

1.  Go to the repository folder for each sections, you can choose to download a zip or download the files individually:
* [Download Documents for Equity Research](/data/AISQL%20Equity%20Research/EquityDOCS/)
* [Download Notebook for Equity Research](/notebooks/AISQL%20Equity%20Research.ipynb)
2.  Create Snowflake Stages. Remember to choose server-side encryption for your stage, or follow the code below.
3.  Unzip the files on your machine into separate folders for each lab.
4.  Upload them to the stage or import them through the Snowsight UI.
5.  Log in to your Snowflake demo account.
6.  Create a database for this HOL.

<!-- end list -->

```sql
use role sysadmin;

--Database for lab
Create or Replace DATABASE AISQL_HOL;

--Schema for each part of the lab
Create or Replace SCHEMA AISQL_HOL.EQUITYRESEARCH;

--Stages for files to be uploaded
Create or Replace STAGE AISQL_HOL.EQUITYRESEARCH.EQUITYDOCS ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');

--create warehouse for lab
create or replace WAREHOUSE IDENTIFIER('WH_AISQL_HOL') COMMENT = '' WAREHOUSE_SIZE = 'xsmall' AUTO_RESUME = true AUTO_SUSPEND = 300 ENABLE_QUERY_ACCELERATION = false WAREHOUSE_TYPE = 'STANDARD' MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 SCALING_POLICY = 'STANDARD';
```

7.  In the database browser, navigate to the `EQUITYDOCS` stage and upload the 7 PDFs from the [Equity Docs](/data/AISQL%20Equity%20Research/EquityDOCS/) from above that you extracted. Ensure you enable directory table to see your files listed.

---

## Step 3: Bring in the Market Listing for the S\&P 500 Tickers

Open the Snowflake Marketplace listing and import the listing for the S\&P 500.  

>This listing is called: 'S & P 500 by domain and aggregated by tickers (Sample)'. 

You can leave all the defaults as they are (Database Name: S__P_500_BY_DOMAIN_AND_AGGREGATED_BY_TICKERS_SAMPLE), as this is how they will be referenced in the notebook.

---

## Step 4: Upload the ipynb file to start Equity Research Lab

Navigate to `Projects` → `Notebooks`, then click `⌄` to `Import ipynb file`. Select the `AISQL Equity Research.ipynb` file from the `EquityResearch` Zip folder. Ensure the notebook location matches the `AISQL_HOL` Database and the `EQUITYRESEARCH` Schema, and choose the `WH_AISQL_HOL` warehouse for both the query warehouse and the notebook warehouse.

---

## Step 5: Complete Lab using Notebook

The code in the lab contains pseudo-code that needs to be completed for the statements to run. Refer to the header box above the code for links to documentation that will assist in writing the necessary lines of code to complete the exercise.

---

## Step 6: Validate Using DORA

***Complete [Part2](/lab_instructions/Part2_RestaurantReview.md) then run the Dora Setup and Grading found in the [/config](/config/) section***





