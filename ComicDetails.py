import pyodbc
from MarvelClass import Marvel
from class_DB_Connector import DB_Connector

# Connect to the database
db_connection = DB_Connector()

#cursor = cnxn.cursor()

pub_key = 'fdbf07e71c484f4d729b1e0f86c2a30e'
pri_key = '202aa57a3cc56c389f9c1127fe30fd43806075b5'
x = Marvel(pub_key, pri_key)

# determine the record count in the ResourceURI table
cursor = db_connection.query('select count(distinct ComicId) from Stage.ResourceURI')
iterMax = cursor.fetchone()
print(iterMax[0])

cursor = db_connection.query('SELECT distinct ComicId FROM Stage.ResourceURI')

row = cursor.fetchall()
print(row)


r = x.fetch_comics_by_comicId(23483)
print(r)

iterCount = 0

# Need to cycle the ComicId
for charReturn in range(0, iterMax[0] - 1):
    # while row:
    # row = cursor.fetchone()
    print('row = %r' % (row,))
    # print(row[iterCount][0])
    comId = row[iterCount][0]
    print("Current ComicId: ", comId)

    s = x.fetch_comics_by_comicId(comId)
    # Get Comic Details
    comicId = s['data']['results'][0]['id']
    print("Comic Id: ", comicId)
    comicName = s['data']['results'][0]['title']
    print("Comic Title: ", comicName)
    issueNumber = s['data']['results'][0]['issueNumber']
    print("Issue Number: ", issueNumber)
    #series = s['data']['results'][0]['series']['resourceURI']

    seriesResourceURI = s['data']['results'][0]['series']['resourceURI']
    #seriesCount = len(seriesResourceURI)
    #print("Series Count: ", seriesCount)
    print("Series Resource URI", seriesResourceURI)
    seriesId = seriesResourceURI.split("series/")[1]
    print("Series Id: ", seriesId)
    seriesName = s['data']['results'][0]['series']['name']
    print('Series Name: ', seriesName)

    cursor = db_connection.query_param('''INSERT INTO STAGE.ComicDetails (ComicId, ComicName, IssueNumber, SeriesResourceURI, SeriesId, SeriesName)
                      VALUES (? , ? , ?, ?, ?, ?)''', (comicId, comicName, issueNumber, seriesResourceURI, seriesId, seriesName))
    print("insert: ", comicId, comicName, issueNumber, seriesResourceURI, seriesId, seriesName)

    cursor.commit()

    iterCount = iterCount + 1

cursor.close()

#test
