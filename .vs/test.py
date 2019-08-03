import pyodbc
from MarvelClass import Marvel
from class_DB_Connector import DB_Connector

# Connect to the database
db_connection = DB_Connector()

#cursor = cnxn.cursor()

pub_key = '97349e5751b85b4e6da3fd96b1c2e2c1'
pri_key = '01a66ca70cdbf6e8c4ac3fccfda2a4b2a17f62cc'
x = Marvel(pub_key, pri_key)

# determine the record count in the ResourceURI table
cursor = db_connection.query('select count(distinct ComicId) from Stage.ResourceURI')
iterMax = cursor.fetchone()
print(iterMax[0])

cursor = db_connection.query('SELECT distinct ComicId FROM Stage.ResourceURI')

row = cursor.fetchall()
print(row)