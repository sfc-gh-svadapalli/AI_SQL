### Part 2: Restaurant Reviews and Menu Items

The second part of the lab will examine restaurant reviews and pictures of menu items. This data will be aggregated to draw conclusions about reviews available on Doordash. AI will also be used to join restaurant images with text data for multimodal analysis in a single place.

**Outline of Part 2:**

  * Ingest text data related to DoorDash reviews
  * Ingest Images and generate descriptions using Cortex to analyze the images
  * Filter data using AI SQL
  * Aggregate data using AI SQL
  * Summarize data using AI SQL

  ---
  ## Step 1: Download Files for the Lab and Upload Them to the Stage

1.  Go to the repository folder for each sections, you can choose to download a zip or download the files individually:
* [Download Food Images](/data/AISQL%20Resturant%20Review/Food%20Images)
* [Download Doordash Dataset](/data/AISQL%20Resturant%20Review/Datasets/)
* [Download Notebook](/notebooks/AISQL%20Resturant%20Review.json)
* [Download Helper Image Viewer in Notebook](/data/AISQL%20Resturant%20Review/Extras/)
2.  Create Snowflake Stages. Remember to choose server-side encryption for your stage, or follow the code below.
3.  Unzip the files on your machine into separate folders for each lab.
4.  Upload them to the stage or import them through the Snowsight UI.
5.  Log in to your Snowflake demo account.
6.  Create a database for this HOL.
---
```sql
use role sysadmin;

--Database for lab
--assumes you created the database from part 1
Use DATABASE AISQL_HOL;

--Schema for each part of the lab
Create or Replace SCHEMA AISQL_HOL.RESTAURANT;

--Stages for files to be uploaded
Create or Replace STAGE AISQL_HOL.RESTAURANT.FOODIMAGES ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');

--create warehouse for lab
create or replace WAREHOUSE IDENTIFIER('"WH_AISQL_HOL"') COMMENT = '' WAREHOUSE_SIZE = 'xsmall' AUTO_RESUME = true AUTO_SUSPEND = 300 ENABLE_QUERY_ACCELERATION = false WAREHOUSE_TYPE = 'STANDARD' MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 SCALING_POLICY = 'STANDARD';
```
7.  Upload the images from the the `FOODIMAGES` folder. Place these 14 images in the `AISQL_HOL.RESTAURANT.FOODIMAGE` stage you created earlier.

8.  Create the `DOORDASH_100` table from the `DOORDASH_100.CSV` file found in the `Restaurant` zip package. Create this table in the `AISQL_HOL.RESTAURANT` schema using "create table from file" in Snowsight. Leave all defaults to ensure correct table creation.

---
## Step 2: Upload the ipynb file to start Restaurant Lab

Navigate to `Projects` → `Notebooks`, then click `⌄` to `Import ipynb file`. Select the `AISQL Restaurant Review.ipynb` file from the `Restaurant` Zip folder. Ensure the notebook location matches the `AISQL_HOL` Database and the `RESTAURANT` Schema, and choose the `WH_AISQL_HOL` warehouse for both the query warehouse and the notebook warehouse. **Make sure to complete this step before running the Notebook\!**

---

## Step 3: Upload the additional snowbook extras python sheet to the notebook

For this lab, you will need to load an additional file for the notebook. Do this by clicking the `+` sign on the left side and then choosing the `snowbooks_extras.py` file from the zip file you extracted earlier. Confirm that the file is present.

---

## Step 4: Complete the Lab using the Notebook

The code in the lab contains pseudo-code that needs to be completed for the statements to run. Refer to the header box above the code for links to documentation that will assist in writing the necessary lines of code to complete the exercise.

---

## Step 5: Validate Using DORA

***Run the Dora Setup and Grading found in the [/config](/config/) section***
