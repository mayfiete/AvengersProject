import pyodbc
from MarvelClass import Marvel
from class_DB_Connector import DB_Connector


# Connect to the database
db_connection = DB_Connector()
#cursor = db_connection.query('select count(distinct ComicId) from Stage.ResourceURI')
#row = cursor.fetchall()
#print(str(row))

pub_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxx'
pri_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxx'
x = Marvel(pub_key,pri_key)

# Determine the iteration cycle
limit = 100
recordOffset = 20
offsetInt = 0

# Loop through up to 300 comic books
while offsetInt < 40:
    print("Record Offset: ", offsetInt)
    j = x.fetch_comics_by_characterId(1009652, str(limit), "title", str(recordOffset))

    resourceCountPre = j['data']['results'][0]['resourceURI']
    resourceCount = int(len(resourceCountPre))
    print("Resource Count: ", resourceCount)

    iterCount = 0

    for resources in range(0,resourceCount):  #
        #cursor = cnxn.cursor()
        resource=j['data']['results'][iterCount]['resourceURI']
        print(resource)
        comicid = resource.split("comics/")[1]
        print("Comic ID: ", comicid)
        cursor = db_connection.query_param('''INSERT INTO STAGE.ResourceURI (ResourceURI, ComicId)
                        VALUES (?,?)''', (resource,comicid))
        print("insert: ", resource, comicid)
        iterCount = iterCount+1

        # commit the transaction
        # How do I structure this commit?
        cursor.commit()

    offsetInt = offsetInt + recordOffset
# close the cursor 
cursor.close()