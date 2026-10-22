# Lab 01 – Environment Setup and Unix Data Exploration

This lab sets up the Big Data Engineering environment (WSL2 Ubuntu, Python virtual environment, PySpark, DuckDB, Docker) and generates the DataShop seed data.

## Contents

| File | Purpose |
|------|---------|
| `verify_environment.py` | Checks the Python version and the required libraries (PySpark, Pandas, PyArrow, dbt-core, Great Expectations). |
| `generate_datashop_data.py` | Generates the DataShop seed data: 100,000 transactions, 5,000 customers and 100 products (CSV). |
| `explore_data.sh` | Unix exploration of the transactions file (`wc`, `head`, `cut`, `sort`, `uniq`) and a DuckDB query for the average amount per category. |
| `architecture_sketch.png` | Sketch of the course architecture (ingestion, storage, batch processing, streaming, orchestration, quality, serving). |
| `screenshots/` | Screenshots of the environment verification output and of the data generation output. |

## How to run

```bash
source ../bde_env/bin/activate
python verify_environment.py
python generate_datashop_data.py
chmod +x explore_data.sh
./explore_data.sh
```

By default, the scripts read and write the data in `datashop_data/`, located one level above `lab01/` (for example `/mnt/c/Big_Data_Engineering_Labs/datashop_data`). `explore_data.sh` accepts another directory as its first argument. The generated CSV files are not committed to Git (see `.gitignore`).

## Reflection

The main challenge was installing Python 3.11. The package was not available in the default Ubuntu repositories (`Unable to locate package python3.11`), and the alternative deadsnakes repository failed with `503 Service Unavailable` errors, because my Ubuntu release is very recent. I resolved it by checking the course requirement, which accepts Python 3.10 or later, and by using the Python 3.14.4 already installed on the system inside a virtual environment (`python3 -m venv`). A second issue appeared when I tested PySpark: it failed with `JAVA_GATEWAY_EXITED` because Java was missing. Installing `openjdk-17-jre-headless` fixed it, and a small Spark job then returned the expected result. The lesson is that importing a library does not prove that it works, so a functional test is a useful complement to the verification script.
