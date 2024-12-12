import pandas as pd 
import os
import mysql.connector
from sqlalchemy import create_engine

username = 'root'
password = 'Swethap%4004'
database = 'ecommerce_data'
port=3306
host = '127.0.0.1'

engine = create_engine(f'mysql+mysqlconnector://{username}:{password}@{host}/{database}?connect_timeout=8000')
folder = 'transformed_data'
files = {
    't_fact.csv': 'fact',
    't_customer.csv': 'customer',
    't_store.csv': 'store',
    't_item.csv': 'item',
    't_time.csv': 'time',
    't_trans.csv': 'transaction'
}

for file, table_name in files.items():
    file_path = os.path.join(folder,file)
    df = pd.read_csv(file_path)
    df.to_sql(table_name, con=engine, if_exists='replace', index=False, dtype=None)

    print(f'data from {file} has been loaded into the {table_name} table')