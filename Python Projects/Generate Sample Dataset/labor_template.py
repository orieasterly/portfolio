import random
import csv
from datetime import datetime, timedelta

# Set the static variable for hours per week
HOURS_PER_WEEK = 40
YEAR = 2022

def generate_random_range(department):
    # Define different random ranges for each department
    ranges = {
        "Processing": (0.9, 1.1),
        "Bacon": (0.85, 1.08),
        "Ham": (0.92, 1.07),
        "Sausages": (0.88, 1.12),
        "Warehousing": (0.97, 1.03),
    }
    return ranges[department]

def randomize(base_value, low_range, high_range):
    return float(base_value * (low_range + random.random() * (high_range - low_range)))

def count_weekdays(YEAR, month):
    # Get the number of days in the month
    last_day_of_month = datetime(YEAR, month + 1, 1) if month < 12 else datetime(YEAR + 1, 1, 1)
    num_days_in_month = (last_day_of_month - datetime(YEAR, month, 1)).days

    # Count the number of weekdays (Monday to Friday)
    weekdays = sum((datetime(YEAR, month, day).weekday() < 5) for day in range(1, num_days_in_month + 1))

    return weekdays

def create_row(YEAR, month, department, fte_range, kg_range, hourly_rate_range):
    # Get department-specific random range
    low_range, high_range = generate_random_range(department)

    # Randomize FTE, Product_KG, and hourly rate within specified range
    fte = randomize(random.uniform(fte_range[0], fte_range[1]), low_range, high_range)
    #product_kg = randomize(random.randint(kg_range[0], kg_range[1]), low_range, high_range)
    kg_range = randomize(random.uniform(kg_range[0], kg_range[1]), low_range, high_range)
    hourly_rate = random.uniform(hourly_rate_range[0], hourly_rate_range[1])

    # Count weekdays in the month (Monday to Friday)
    weekday_count = count_weekdays(YEAR, month)

    # Calculate labor_hours as fte * weekday_count * HOURS_PER_WEEK
    labor_hours = round(fte * weekday_count * HOURS_PER_WEEK, 2)

    # Calculate labor_cost as labor_hours * hourly_rate
    labor_cost = round(labor_hours * hourly_rate, 2)

    product_kg = round(labor_hours * kg_range, 2)


    # Format month in "dd-mmm-yyyy" format
    formatted_month = datetime(YEAR, month, 1).strftime("%d-%b-%Y")

    return [YEAR, formatted_month, department, labor_cost, labor_hours, product_kg]

# Define base values for each department
base_values = {
    "Processing": {"fte": (10, 20), "kg_per_MH": (45.5, 51.0), "hourly_rate": (20, 30)},
    "Bacon": {"fte": (12, 22), "kg_per_MH": (40.5, 45.0), "hourly_rate": (25, 35)},
    "Ham": {"fte": (11, 21), "kg_per_MH": (18.5, 21.0), "hourly_rate": (22, 32)},
    "Sausages": {"fte": (10, 20), "kg_per_MH": (90.5, 101.0), "hourly_rate": (23, 33)},
    "Warehousing": {"fte": (15, 25), "kg_per_MH": (50.5, 61.0), "hourly_rate": (18, 28)},
}

# Define column names (can be customized)
COLUMNS = ["Year", "Month", "Department", "Labor Cost", "Labor Hours", "Product KG"]

# Specify output file path
OUTPUT_FILE = "generated_data.csv"

# Empty list to store rows
data = []

# Generate data for multiple months (modify as needed)
for month in range(1, 13):  # Loop through numeric months for formatting
    for department in ["Processing", "Bacon", "Ham", "Sausages", "Warehousing"]:
        # Generate year dynamically based on the current year
        # Append the row to the data list
        data.append(create_row(YEAR, month, department, base_values[department]["fte"],
                               base_values[department]["kg_per_MH"], base_values[department]["hourly_rate"]))

# Open the output file in write mode with overwrite
with open(OUTPUT_FILE, "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(COLUMNS)
    writer.writerows(data)

print(f"Data successfully generated and saved to '{OUTPUT_FILE}'")
