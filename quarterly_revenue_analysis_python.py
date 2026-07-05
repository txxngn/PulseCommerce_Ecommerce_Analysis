import pandas as pd

# 1. Load the Excel file
try:
    df_orders = pd.read_excel('/content/PulseCommerce_data_only.xlsx')
    print("Successfully loaded data.")
except ValueError as e:
    print(f"Error loading: {e}")
    raise

# Display the columns to verify
print("\nColumns in 'orders_data' sheet:", df_orders.columns.tolist())
display(df_orders.head())

# RESULT OUTPUT:
# Successfully loaded data.
# Columns in 'orders_data' sheet: ['USER_ID', 'ORDER_ID', 'PURCHASE_TS', 'PURCHASE_TS_cleaned', 'PURCHASE_YEAR', 'PURCHASE_MONTH', 'SHIP_TS', 'TIME_TO_SHIP', 'DELIVERY_TS', 'REFUND_TS', 'PRODUCT_NAME', 'PRODUCT_NAME_Cleaned', 'PRODUCT_ID', 'USD_PRICE', 'LOCAL_PRICE', 'CURRENCY', 'PURCHASE_PLATFORM', 'MARKETING_CHANNEL', 'MARKETING_CHANNEL_cleaned', 'ACCOUNT_CREATION_METHOD', 'ACCOUNT_CREATION_METHOD_Cleaned', 'COUNTRY_CODE', 'LOYALTY_PROGRAM', 'CREATED_ON', 'Date_Check\n(if ship time >= purchase time', 'Region', 'Is Refund']


# 2. Data Cleaning and Preparation
# Ensure 'PURCHASE_TS' is in datetime format
if 'PURCHASE_TS' in df_orders.columns:
    df_orders['PURCHASE_TS'] = pd.to_datetime(df_orders['PURCHASE_TS'], errors='coerce')
else:
    raise KeyError("'PURCHASE_TS' column not found. Cannot perform time-based analysis.")

# Ensure 'USD_PRICE' is numeric (assuming this is the revenue column from kernel state)
if 'USD_PRICE' in df_orders.columns:
    df_orders['USD_PRICE'] = pd.to_numeric(df_orders['USD_PRICE'], errors='coerce').fillna(0)
else:
    raise KeyError("'USD_PRICE' column not found. Cannot calculate revenue.")

# Drop rows where 'PURCHASE_TS' is NaT (Not a Time) after conversion issues
df_orders.dropna(subset=['PURCHASE_TS'], inplace=True)

# Filter for Q4 2022 (October, November, December)
q4_2022_df_orders = df_orders[
    (df_orders['PURCHASE_TS'].dt.year == 2022) &
    (df_orders['PURCHASE_TS'].dt.quarter == 4)
]
q4_2022_revenue = q4_2022_df_orders['USD_PRICE'].sum()

# Filter for Q4 2021 (October, November, December)
q4_2021_df_orders = df_orders[
    (df_orders['PURCHASE_TS'].dt.year == 2021) &
    (df_orders['PURCHASE_TS'].dt.quarter == 4)
]
q4_2021_revenue = q4_2021_df_orders['USD_PRICE'].sum()

print(f"\nQ4 2022 Revenue: ${q4_2022_revenue:,.2f}")
print(f"Q4 2021 Revenue: ${q4_2021_revenue:,.2f}")

# RESULT OUTPUT:
# Q4 2022 Revenue: $648,986.26
# Q4 2021 Revenue: $2,280,598.96




# 3. Compare the revenues
if q4_2022_revenue > q4_2021_revenue:
    difference = q4_2022_revenue - q4_2021_revenue
    percentage_change = (difference / q4_2021_revenue) * 100 if q4_2021_revenue != 0 else 0
    print(f"Q4 2022 revenue is higher than Q4 2021 revenue by ${difference:,.2f} ({percentage_change:.2f}% increase).")
elif q4_2022_revenue < q4_2021_revenue:
    difference = q4_2021_revenue - q4_2022_revenue
    percentage_change = (difference / q4_2021_revenue) * 100 if q4_2021_revenue != 0 else 0
    print(f"Q4 2022 revenue is lower than Q4 2021 revenue by ${difference:,.2f} ({percentage_change:.2f}% decrease).")
else:
    print("Q4 2022 revenue is the same as Q4 2021 revenue.")

# RESULT OUTPUT:
# Q4 2022 revenue is lower than Q4 2021 revenue by $1,631,612.70 (71.54% decrease).
