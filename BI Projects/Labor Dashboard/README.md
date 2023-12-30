# Monthly Labor and Production Data Generator
This Python script generates synthetic data for monthly labor and production metrics for different departments within a company. The data includes information such as labor cost, labor hours, and product kilograms produced.

Key Features:
Customizable Parameters:

Base values for each department, such as Full-Time Equivalent (FTE), Kilograms per Machine Hour (KG/MH), and Hourly Rates, can be easily adjusted.
Randomization:

The script utilizes randomization to simulate variations in labor and production metrics within specified ranges for each department.
Date Handling:

It dynamically calculates the number of weekdays in a given month, considering Monday to Friday as workdays.
Output Format:

The generated data is saved to a CSV file with columns including Year, Month, Department, Labor Cost, Labor Hours, and Product KG.
Usage:
Set Parameters:

Adjust base values for each department in the base_values dictionary.
Specify the output file path (OUTPUT_FILE) for saving the generated data.
Run the Script:

Execute the script to generate synthetic data for multiple months across different departments.
Example:
python
Copy code
# Set parameters
base_values = {
    "Processing": {"fte": (10, 20), "kg_per_MH": (45.5, 51.0), "hourly_rate": (20, 30)},
    # ... (other departments)
}

# Specify output file path
OUTPUT_FILE = "generated_data.csv"

# Run the script
python generate_data_script.py
Output:
The generated data is saved to a CSV file (generated_data.csv) with columns: Year, Month, Department, Labor Cost, Labor Hours, and Product KG.
