
import pyodbc

class DB_Connector(object):

    def __init__(self, server='WCF-P0207', database='SuperHeroes'):
        self.server = str(server)
        self.database = str(database)
        self.cnxn = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};SERVER=' + server + ';Trusted_Connection=yes;DATABASE=' + database)
        # Unpack Other Database Arguments Here
        self.db_cur = self.cnxn.cursor()

    def query(self, query):
        return self.db_cur.execute(query)

    def query_param(self, query, params):
        return self.db_cur.execute(query, params)

    def __del__(self):
        self.cnxn.close()


#db_connection = DB_Connector()
#cursor = db_connection.query('select count(distinct ComicId) from Stage.ResourceURI')
#row = cursor.fetchall()
#print(str(row))
