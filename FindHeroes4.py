<<<<<<< HEAD
import pyodbc
from MarvelClass import Marvel
import time

# Put connection in a class later
server = '#############'
database = '##############'
cnxn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};SERVER=' + server + ';Trusted_Connection=yes;DATABASE=' + database)

cursor = cnxn.cursor()

pub_key = '###################'
pri_key = '###################'
x = Marvel(pub_key, pri_key)

# determine the record count in the ResourceURI table
cursor.execute('select count(distinct ComicId) from Stage.ResourceURI')
iterMax = cursor.fetchone()
print(iterMax[0])

cursor.execute('SELECT distinct ComicId FROM Stage.ResourceURI')

row = cursor.fetchall()
print(row)

r = x.fetch_characters_by_comicId(17645)
print("Comic Characters: ", r)

iterCount = 0

# Need to cycle the ComicIds
for charReturn in range(0, iterMax[0] - 1):
    print('row = %r' % (row,))
    comId = row[iterCount][0]
    print("Current ComicId: ", comId)
    # Pass this value to the Marvel API to fetch
    # heroes associated with comic books that feature
    # Thanos
    s = x.fetch_characters_by_comicId(comId)
    hero = s['data']['count']
    print("Hero: ", int(hero))
    heroCount = int(hero)
    if heroCount == 0:
        cursor.execute('''select @@version ''')
        continue
    heroCountIter = 0
    for heroes in range(0, heroCount):
        print("HeroCountIter: ", heroCountIter)

        heroId = s['data']['results'][heroCountIter]['id']
        print("Hero Id: ", heroId)

        heroName = s['data']['results'][heroCountIter]['name']
        print("Hero Name: ", heroName)

        heroDescription = s['data']['results'][heroCountIter]['description']
        print("Hero Description: ", heroDescription)

        cursor.execute('''INSERT INTO STAGE.CharacterCatalog (CharacterId, CharacterName, CharacterDescription, ComicId)
                          VALUES (? , ? , ?, ?)''', (heroId, heroName, heroDescription, comId))
        print("insert: ", heroName, heroDescription, comId)
        heroCountIter = heroCountIter + 1

        heroComicCountIter = 0

        # Count the number of comics that belong to the hero
        comicList = s['data']['results'][0]['comics']['items']
        print("Comic List: ", comicList)
        comicCountIter = int(len(comicList))
        print("Comic Count: ", comicCountIter)

        # fetch the heroes from the comic list
        for comicCounts in comicList:
            comicListResourceURI = comicList[heroComicCountIter]['resourceURI']
            print("Hero Name: ", heroName, "Comic Resource URI: ", comicListResourceURI)
            comicListComicId = comicListResourceURI.split("comics/")[1]
            print(comicListComicId)
            cursor.execute('''INSERT INTO STAGE.CharacterComics (CharacterId, CharacterName, ResourceURI, ComicId, SubComicId, SeparationDegrees)
                                     VALUES (? , ? , ?, ?, ?, ?)''', (heroId, heroName, comicListResourceURI, comId, comicListComicId, 0 ))
            print("insert: ", heroId, heroName, comicListResourceURI, comId, comicListComicId, 0)
            heroComicCountIter = heroComicCountIter + 1

    iterCount = iterCount + 1

    cnxn.commit()
cnxn.close()

=======
import pyodbc
from MarvelClass import Marvel
import time

# Put connection in a class later
server = 'TERRYMAYFIELD66\JAMEST'
database = 'DataScience'
cnxn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};SERVER=' + server + ';Trusted_Connection=yes;DATABASE=' + database)

cursor = cnxn.cursor()

pub_key = 'fdbf07e71c484f4d729b1e0f86c2a30e'
pri_key = '202aa57a3cc56c389f9c1127fe30fd43806075b5'
x = Marvel(pub_key, pri_key)

# determine the record count in the ResourceURI table
cursor.execute('select count(distinct ComicId) from Stage.ResourceURI')
iterMax = cursor.fetchone()
print(iterMax[0])

cursor.execute('SELECT distinct ComicId FROM Stage.ResourceURI')

row = cursor.fetchall()
print(row)

r = x.fetch_characters_by_comicId(17645)
print("Comic Characters: ", r)

iterCount = 0

# Need to cycle the ComicIds
for charReturn in range(0, iterMax[0] - 1):
    print('row = %r' % (row,))
    comId = row[iterCount][0]
    print("Current ComicId: ", comId)
    # Pass this value to the Marvel API to fetch
    # heroes associated with comic books that feature
    # Thanos
    s = x.fetch_characters_by_comicId(comId)
    hero = s['data']['count']
    print("Hero: ", int(hero))
    heroCount = int(hero)
    if heroCount == 0:
        cursor.execute('''select @@version ''')
        continue
    heroCountIter = 0
    for heroes in range(0, heroCount):
        print("HeroCountIter: ", heroCountIter)

        heroId = s['data']['results'][heroCountIter]['id']
        print("Hero Id: ", heroId)

        heroName = s['data']['results'][heroCountIter]['name']
        print("Hero Name: ", heroName)

        heroDescription = s['data']['results'][heroCountIter]['description']
        print("Hero Description: ", heroDescription)

        cursor.execute('''INSERT INTO STAGE.CharacterCatalog (CharacterId, CharacterName, CharacterDescription, ComicId)
                          VALUES (? , ? , ?, ?)''', (heroId, heroName, heroDescription, comId))
        print("insert: ", heroName, heroDescription, comId)
        heroCountIter = heroCountIter + 1

        heroComicCountIter = 0

        # Count the number of comics that belong to the hero
        comicList = s['data']['results'][0]['comics']['items']
        print("Comic List: ", comicList)
        comicCountIter = int(len(comicList))
        print("Comic Count: ", comicCountIter)

        # fetch the heroes from the comic list
        for comicCounts in comicList:
            comicListResourceURI = comicList[heroComicCountIter]['resourceURI']
            print("Hero Name: ", heroName, "Comic Resource URI: ", comicListResourceURI)
            comicListComicId = comicListResourceURI.split("comics/")[1]
            print(comicListComicId)
            cursor.execute('''INSERT INTO STAGE.CharacterComics (CharacterId, CharacterName, ResourceURI, ComicId, SubComicId, SeparationDegrees)
                                     VALUES (? , ? , ?, ?, ?, ?)''', (heroId, heroName, comicListResourceURI, comId, comicListComicId, 0 ))
            print("insert: ", heroId, heroName, comicListResourceURI, comId, comicListComicId, 0)
            heroComicCountIter = heroComicCountIter + 1

    iterCount = iterCount + 1

    cnxn.commit()
cnxn.close()

>>>>>>> 8b0eefac84fe5495a97e9b34101742777100a87b
