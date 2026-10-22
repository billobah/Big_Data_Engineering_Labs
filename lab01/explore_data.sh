#!/usr/bin/env bash
# explore_data.sh - Unix exploration of the DataShop seed data (Lab 01, Exercise 3)
# Usage: ./explore_data.sh [data_directory]
# Default directory: <project root>/datashop_data, i.e. one level above this script's folder
# (e.g. /mnt/c/Big_Data_Engineering_Labs/datashop_data)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="${1:-$SCRIPT_DIR/../datashop_data}"
TXN="$DATA_DIR/datashop_transactions.csv"
CUST="$DATA_DIR/datashop_customers.csv"
PROD="$DATA_DIR/datashop_products.csv"

echo "=== 1. Row counts (wc -l; includes the header line, so data rows = result - 1) ==="
wc -l "$TXN" "$CUST" "$PROD"

echo
echo "=== 2. Header and first 4 data rows of the transactions file (head) ==="
head -5 "$TXN"

echo
echo "=== 3. Transactions per category (cut | sort | uniq -c; field 4 = category) ==="
# The header line is skipped with tail so that it does not appear as a category.
tail -n +2 "$TXN" | cut -d',' -f4 | sort | uniq -c | sort -nr

echo
echo "=== 4. Average transaction amount per category (DuckDB) ==="
# DuckDB is used instead of awk: read_csv_auto handles RFC 4180 CSV files correctly,
# including quoted fields that contain commas.
duckdb -c "
SELECT
    category,
    ROUND(AVG(amount), 2) AS avg_amount
FROM read_csv_auto('$TXN')
GROUP BY category
ORDER BY avg_amount DESC
"
