import sqlite3

connection = sqlite3.connect('store/data/create_project.db')
cursor = connection.cursor()

cursor.execute("SELECT * FROM projects;")
rows = cursor.fetchall()
print("Current records in the database:")
for row in rows:
    print(row)

# Close the connection
connection.close()
