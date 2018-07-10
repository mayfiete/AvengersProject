import pyodbc
from MarvelClass import Marvel

# Put connection in a class later
server = '#############'
database = '##############'
cnxn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};SERVER=' + server + ';Trusted_Connection=yes;DATABASE=' + database)

pub_key = '#########################'
pri_key = '#########################'
x = Marvel(pub_key,pri_key)

# Determine the iteration cycle
limit = 100
recordOffset = 20
offsetInt = 0

# Loop through up to 300 comic books
while offsetInt < 300:
    print("Record Offset: ", offsetInt)
    j = x.fetch_comics_by_characterId(1009652, str(limit), "title", str(recordOffset))

    resourceCountPre = j['data']['results'][0]['resourceURI']
    resourceCount = int(len(resourceCountPre))
    print("Resource Count: ", resourceCount)

    iterCount = 0

    for resources in range(0,resourceCount):  #
        cursor = cnxn.cursor()
        resource=j['data']['results'][iterCount]['resourceURI']
        print(resource)
        comicid = resource.split("comics/")[1]
        print("Comic ID: ", comicid)
        cursor.execute('''INSERT INTO STAGE.ResourceURI (ResourceURI, ComicId)
                        VALUES (?,?)''', (resource,comicid))
        print("insert: ", resource, comicid)
        iterCount = iterCount+1

        # commit the transaction
        cnxn.commit()

    offsetInt = offsetInt + recordOffset
