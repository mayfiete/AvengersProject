

# import database connection module
import pyodbc
# import visualization module that supports bar charts
from pygal import Bar
import pygal as py

# Put connection in a class later
server = '#############'
database = '##############'
cnxn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};SERVER=' + server + ';Trusted_Connection=yes;DATABASE=' + database)

cursor = cnxn.cursor()


cursor.execute('select count(UniqueId) from Heroes.FactProjectedBattleResults')

# define orientation of the data on the bar graph
Alignment = 'Good'
IsTeam = 0

# run query in SQL to get data need to answer question
# How often will characters in this category defeat Thanos?
cursor.execute('''select 
	CASE 
		WHEN IsThanosDefeated = 0 THEN 'No' 
		ELSE 'Yes'  
	END AS IsThanosDefeated, 
	COUNT(UniqueId) AS Battles
from Heroes.FactProjectedBattleResults 
where Alignment = ? 
    and IsTeam = ?
group by IsThanosDefeated; 
''', (Alignment, IsTeam))

# fetch the results
row = cursor.fetchall()
#print(row)

# Pull out the Yes values
x_value = row[1][1]
#print("X Value: ", x_value)

# Pull out the No values
y_value = row[0][1]
#print("Y Value: ", y_value)

# Put the results in a dictionary
results = []
results.append(x_value)
results.append(y_value)
#print(results)

# Provide the graph type
hist = py.Bar()

# Chart design
hist.title = "Did hero defeat Thanos?"
hist.x_labels = ['Yes', 'No']
hist.x_title = "Result"
hist.y_title = "Frequency of Result"

# Add the data
hist.add('Battle Results: ', results)
hist.render_to_file('BattleResults.svg')
#print(results)