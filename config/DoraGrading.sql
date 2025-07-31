-- =============================================================================
-- VALIDATION QUERIES FOR AISQL HOL DATABASE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Validate RAW_DOCS_TEXT Table
-- -----------------------------------------------------------------------------
USE DATABASE AISQL_HOL;
USE SCHEMA EQUITYRESEARCH;

SELECT 
    util_db.public.se_grader(
        step,
        (actual = expected),
        actual,
        expected,
        description
    ) AS graded_results
FROM (
    SELECT 
        'SEDW10' AS step,
        (
            SELECT COUNT(RELATIVE_PATH)
            FROM RAW_DOCS_TEXT
        ) AS actual,
        7 AS expected,
        'Docs Loaded and parsed correctly for AISQL Equity Lab' AS description
);

-- -----------------------------------------------------------------------------
-- Validate MATCHED_CANDIDATES Table (AI_FILTER)
-- -----------------------------------------------------------------------------
USE DATABASE AISQL_HOL;
USE SCHEMA EQUITYRESEARCH;

SELECT 
    util_db.public.se_grader(
        step,
        (actual = expected),
        actual,
        expected,
        description
    ) AS graded_results
FROM (
    SELECT 
        'SEDW11' AS step,
        (
            SELECT 
                CASEWHEN COUNT(FILE_NAME) > 2 THEN 1
                    ELSE 0
                END
            FROM MATCHED_CANDIDATES
        ) AS actual,
        1 AS expected,
        'AIFILTER successfully applied to AISQL Equity Lab' AS description
);

-- -----------------------------------------------------------------------------
-- Validate AIAGG_RESULTS Table (AI_AGG)
-- -----------------------------------------------------------------------------
USE DATABASE AISQL_HOL;
USE SCHEMA EQUITYRESEARCH;

SELECT 
    util_db.public.se_grader(
        step,
        (actual = expected),
        actual,
        expected,
        description
    ) AS graded_results
FROM (
    SELECT 
        'SEDW12' AS step,
        (
            SELECT COUNT(mapped_ticker)
            FROM AIAGG_Results
        ) AS actual,
        1 AS expected,
        'AIAGG successfully applied to AISQL Equity Lab' AS description
);

-- -----------------------------------------------------------------------------
-- Validate AIClassify on Restaurant
-- -----------------------------------------------------------------------------
USE DATABASE AISQL_HOL;
USE SCHEMA RESTAURANT;

SELECT 
    util_db.public.se_grader(
        step,
        (actual = expected),
        actual,
        expected,
        description
    ) AS graded_results
FROM (
    SELECT 
        'SEDW13' AS step,
        (
            SELECT COUNT(*)
            FROM AICLASSIFY_REVIEW
        ) AS actual,
-- -----------------------------------------------------------------------------
-- Validate Summarizeagg_experience
-- -----------------------------------------------------------------------------
use database AISQL_HOL;
use schema RESTAURANT;

SELECT
    util_db.public.se_grader(
        step,
        (actual = expected),
        actual,
        expected,
        description
    ) AS graded_results
FROM
    (
        SELECT
            'SEDW14' AS step,
            (
                SELECT
                    COUNT(*)
                FROM
                    SUMMARIZEAGG_EXPERIENCE
            ) AS actual,
            9 AS expected,
            'SUMMARIZEAGG successfully applied to AISQL Restaurant' AS description
    );
-- -----------------------------------------------------------------------------
-- Validate AIAGG_Stregths
-- -----------------------------------------------------------------------------
use database AISQL_HOL;
use schema RESTAURANT;

SELECT
    util_db.public.se_grader(
        step,
        (actual = expected),
        actual,
        expected,
        description
    ) AS graded_results
FROM
    (
        SELECT
            'SEDW15' AS step,
            (
                SELECT
                    COUNT(*)
                FROM
                    AIAGG_STRENGTHS
            ) AS actual,
            3 AS expected,
            'AIAGG_STRENGTHS successfully applied to AISQL Restaurant' AS description
    );
