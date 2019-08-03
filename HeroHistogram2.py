
import pyodbc
from class_DB_Connector import DB_Connector


# Review: https://matplotlib.org/faq/usage_faq.html#how-do-i-select-pyqt4-or-pyside
from pygal import Bar

import pygal as py

# Connect to the database
db_connection = DB_Connector()

#cursor = cnxn.cursor()
#cursor.execute('select count(UniqueId) from Heroes.FactProjectedBattleResults')

Alignment = 'Good'
IsTeam = 0

# determine the record count in the ResourceURI table
cursor = db_connection.query_param('''select 
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

row = cursor.fetchall()
#print(row)

x_value = row[1][1]
#print("X Value: ", x_value)

y_value = row[0][1]
#print("Y Value: ", y_value)

results = []
results.append(x_value)
results.append(y_value)
#print(results)

hist = py.Bar()

hist.title = "Did hero defeat Thanos?"

hist.x_labels = ['Yes', 'No']
hist.x_title = "Result"
hist.y_title = "Frequency of Result"

hist.add('Battle Results: ', results)
hist.render_to_file('BattleResults.svg')

#print(results)