import pandas as pd
#import pyodbc 
import sqlalchemy

# Specify the server and database details
server = r'localhost\SQLEXPRESS'
database = 'paintings'

# Use Windows Authentication (trusted connection)
#connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes'
connection_string = f'mssql+pyodbc://{server}/{database}?trusted_connection=yes&driver=ODBC+Driver+17+for+SQL+Server'
engine = sqlalchemy.create_engine(connection_string)

# Connect to the database
try:
#    cnxn = pyodbc.connect(connection_string)
#    print("Connected successfully!")
    engine = sqlalchemy.create_engine(connection_string)
except sqlalchemy.Error as e:
    #pyodbc.Error as e:
    print(f"Error connecting to the database: {e}")

data_files = ['artist', 'canvas_size', 'image_link', 'museum', 'museum_hours', 'product_size', 'subject', 'work']   

for data_file in data_files:
    #df = pd.read_csv(f'C:\Users\oeast\OneDrive\Documents\GitHub\portfolio\portfolio\SQL Projects\Famous Painting\Dataset\{data_file}.csv')
    df = pd.read_csv(f'C:/Users/oeast/OneDrive/Documents/GitHub/portfolio/portfolio/SQL Projects/Famous Painting/Dataset/{data_file}.csv')
    
    df.to_sql(data_file, engine, if_exists='replace', index=False)