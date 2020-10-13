import pyodbc


class DB_Connector(object):

    def __init__(self):
        self.cnxn = pyodbc.connect('Driver={SQL Server Native Client 11.0}; Server=avengerstraining.database.windows.net; Database=avengers; UID=xxxxxx; PWD=xxxxxx;')
        # Unpack Other Database Arguments Here
        self.db_cur = self.cnxn.cursor()

    def query(self, query):
        return self.db_cur.execute(query)

    def query_param(self, query, params):
        return self.db_cur.execute(query, params)

    def __del__(self):
        self.cnxn.close()

# db_connection = DB_Connector()
# cursor = db_connection.query('select count(distinct ComicId) from Stage.ResourceURI')
# row = cursor.fetchall()
# print(str(row))
