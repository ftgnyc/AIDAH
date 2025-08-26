# AIDAH

### AIDAH BigQuery Schema

This repository contains the Terraform configuration to deploy the **AIDAH** data schema in Google BigQuery. The schema includes dimension and fact tables.

-----

### 🚀 Getting Started

#### Prerequisites

To get started, you'll need the following:

**1. Local Tools**

  * **Terraform:** Download and install the Terraform CLI from [the official website](https://www.terraform.io/downloads.html).
  * **Google Cloud SDK:** Install the `gcloud` CLI to authenticate with your Google Cloud account.

**2. Cloud Environment**

  * A **Google Cloud Project** must be created beforehand with billing enabled.


#### Google Cloud Authentication

Before running Terraform, you must authenticate so the CLI has permission to interact with your GCP project.

Open your terminal and run the following command to log in with your application default credentials:

```bash
gcloud auth application-default login
```

-----

### 🛠️ Deploying the Schema

Follow these steps to deploy the BigQuery schema to your GCP project:

#### 1\. Configure Environment Variables

Navigate to the `terraform/` folder in your project. You will see a file named `.env.example`.

1.  Copy the file and rename it to `.env`:
    ```bash
    cp .env.example .env
    ```
2.  Open the `.env` file and update the variables with your Google Cloud project values.

#### 2\. Load the Environment Variables

  * **Linux/macOS:** Run the following command to load the variables from the `.env` file into your terminal:

    ```bash
    source .env
    ```

  * **Windows:** Run the PowerShell script to load the variables:

    ```bash
    .\load.ps1
    ```

#### 3\. Initialize Terraform

Run this step only the first time to download the necessary plugins for Google Cloud.

```bash
terraform init
```

#### 4\. Plan and Apply

1.  **Plan the Changes:** Run `terraform plan` to see a summary of the resources that will be created. This allows you to verify that the plan matches your expectations.

    ```bash
    terraform plan
    ```

2.  **Apply the Changes:** If the plan is correct, run `terraform apply` to create the tables in your BigQuery dataset.

    ```bash
    terraform apply
    ```

Terraform will ask for confirmation. Type `yes` and press **Enter** to proceed with the deployment.

The process is now complete. Your BigQuery database schema is ready for use.
