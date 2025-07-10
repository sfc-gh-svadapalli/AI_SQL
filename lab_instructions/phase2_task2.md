# Phase <PHASE NUMBER>: <TASK TITLE>

This guide walks lab participants through setting up their **<Primary Platform>** environment and first-time access to **<Secondary Service or IDE>** for the **<Lab Name>**.  
Replace every item in **<angle brackets>** to customize the template for your own hands-on lab (HOL).

🔽 Jump to:
- [🛠️ <Primary Platform> Setup](#platform-setup)
- [🛠️ <Secondary Service> Setup](#secondary-setup)
- [📂 Foundational Knowledge](#foundational-knowledge)
- [➡️ Next Steps](#next-steps)
- [⚠️ Troubleshooting](#troubleshooting)

---

<a name="platform-setup"></a>
## Step 1 • <Primary Platform> Setup
In this HOL, you’ll configure a secure <Primary Platform> workspace for <high-level workflow goal>.

> **Principle of Least Privilege**  
> Create **dedicated roles and service users** instead of re-using personal admin roles. This avoids accidental permission leaks and network-policy conflicts.

### 1.1 Environment Bootstrap
1. Sign in to **<Primary Platform>**.
2. Open **<Admin Console / Project Manager / etc.>**.
3. Choose or create a **<Project / Resource Group / Account>** called `<lab_project>`.
4. Set your active role to **<Owner Role>** (or equivalent elevated role).
5. Copy-paste the commands below into a new **<Console / SQL Worksheet / CLI>** session, then run them.

```sql
-- Example SQL bootstrap (adapt as needed)
-- Elevate privileges
USE ROLE <owner_role>;

-- Create dedicated role, user, and workspace objects
CREATE OR REPLACE ROLE <lab_role>;

CREATE OR REPLACE USER <service_user>
  TYPE = SERVICE
  DEFAULT_ROLE = <lab_role>
  COMMENT = 'Service user for <Lab Name>';

GRANT ROLE <lab_role> TO USER <service_user>;
GRANT ROLE <lab_role> TO USER <your_personal_user>;

-- Provision core resources
CREATE <DATABASE | PROJECT> IF NOT EXISTS <lab_db_or_project>;
CREATE <COMPUTE_RESOURCE> IF NOT EXISTS <lab_compute>
  WITH SIZE = '<size>'
  AUTO_SUSPEND = 300;

-- Apply least-privilege grants (adjust for your platform)
GRANT USAGE ON <COMPUTE_RESOURCE> <lab_compute> TO ROLE <lab_role>;
GRANT ALL ON <DATABASE | PROJECT> <lab_db_or_project> TO ROLE <lab_role>;
```

📌 **Tip:** Using platform-default sysadmin roles for day-to-day development can cause permission errors when features expect scoped privileges.

### 1.1.1 Set Default Role (recommended)
```sql
ALTER USER <service_user> SET DEFAULT_ROLE = <lab_role>;
```

### 1.1.2 Upload / Register Credentials
If your platform requires key-pair or token auth:
1. Open your terminal (Mac/Linux) or Git Bash (Windows).
2. Run the following commands to generate a private and public key:
```bash
openssl genrsa -out rsa_private_key.pem 2048
openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem
```
3. Open rsa_public_key.pem file in a text editor. Copy your public key.
4. In Snowsight, run the following SQL (replace placeholder):
```sql
ALTER USER mlops_user SET RSA_PUBLIC_KEY='
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAA...
-----END PUBLIC KEY-----';
```
5. Confirm the key was set:
```sql
DESC USER mlops_user;
```

### 1.1.3 Upload Lab Data & Artifacts
1. Ensure your context is set to <lab_role> and <lab_db_or_project>.
2. Navigate to <Storage / Stage / Bucket> called <setup_area>.
3. Upload required files, e.g.:
  - <dataset.csv>
  - <supporting_notebook.ipynb>
4. Run an import script (sample below) to stage data:
```sql
CREATE OR REPLACE FILE FORMAT <lab_format>
    TYPE = CSV
    SKIP_HEADER = 1
    FIELD_DELIMITER = ','
    TRIM_SPACE = TRUE;

COPY INTO <target_table>
FROM @<setup_area>/<dataset.csv>
FILE_FORMAT = <lab_format>
ON_ERROR = ABORT_STATEMENT;
```

### 1.1.4 Integrations & Permissions Setup
Configure integrations only if the lab requires them (example shown):
```sql
-- Create notification channel
CREATE OR REPLACE NOTIFICATION INTEGRATION <lab_notifications>
  TYPE = EMAIL
  ENABLED = TRUE
  ALLOWED_RECIPIENTS = ('<your_email@company.com>');

GRANT USAGE ON INTEGRATION <lab_notifications> TO ROLE <lab_role>;
```

---
<a name="secondary-setup"></a>
## 1.2 <Secondary Service> Access
This lab uses a pre-provisioned <Secondary Service> workspace in <Cloud Account / Region>.

### 1.2.1 Sign in
1.Go to <SSO or console link>.
2. Select <Secondary Service Account> and choose role <Contributor / Developer>.
3. Ensure region <Region Name> is selected.

### 1.2.2 Launch Workspace
1. In the <Secondary Service> console, open <IDE or Studio>.
2. Create a new <Workspace / Space>:
  - Name: <lab-name>-<your-initials>
  - Environment Image: <required_image_version>
  - Instance Type: <recommended_instance>

### 1.2.3 Upload Required Files
1. Click the Upload icon and add:
  - connections.toml (update with your credentials)
  - rsa_private_key.pem (or other auth file)
  - <lab_notebook.ipynb>
  - <dataset.csv> (if needed for local processing)
   
---
<a name="foundation-knowledge"></a>
## Understanding Binary Classification Models

Before diving into building a model, let’s quickly walk through what we’re solving and how we’ll prepare the data.

### 🎯 Scenario
Briefly describe the business or technical problem, e.g.:

“Predict customer churn for a subscription service.”

### 📊 Why This Technique / Tool?
Explain **why you chose the model, algorithm, or service:**
Works well for <classification / regression / NLP> tasks
Handles <non-linear relationships / sparse data / etc.>
Industry-proven for <fraud detection / credit scoring / etc.>

### 🔍 Key Features or Columns
List important data columns and their types.

| Type | Example Features |
|------|------------------|
| **A** | <NUMERIC_FEATURE_1>, <NUMERIC_FEATURE_2> |
| **C** | <CATEGORY_FEATURE_1>, <CATEGORY_FEATURE_2> |

These features will be cleaned and transformed before model training.

### 🧠 Pre-processing Notes

Outline required transformations (e.g., one-hot encoding, scaling, text tokenization).

> **Tip:** Snowflake’s built-in `XXX` can do YYY. See the [Snowflake docs](https://docs.snowflake.com/en/user-guide/snowpark-ml).

### 🔬 Evaluating Your Model

Provide recommended metrics and why they matter (precision, recall, F1, RMSE, etc.).

---
<a name="next-steps"></a>
### 1.3 Next Steps
You’re ready to continue with Phase <PHASE NUMBER+1>: <Next Phase Title>. Typical tasks include:

1. Load data in <Secondary Service>.
2. Transform with <library/tool>.
3. Train model (<Algorithm>).
4. Evaluate using <metrics>.
5. Register the model in <Model Registry>.
6. Run batch or real-time inference.
7. Write predictions back to <Primary Platform>.
8. Monitor performance & drift, complete <Evaluation Steps>.

✅ No external endpoints needed—everything runs inside <Primary Platform> + <Secondary Service>.

---
<a name="troubleshooting"></a>
## Troubleshooting
### Common <Primary Platform> Issues
- **Permission errors:** confirm <lab_role> has required grants.
- **Connection failures:** double-check <account_identifier> format.
- **Key-pair auth:** verify private/public key pair matches DESC USER <service_user> output.

_Template version 1.0 — last updated <YYYY-MM-DD>
Replace or remove any section that isn’t relevant to your HOL._
