import sqlite3

conn = sqlite3.connect('gaming.db')
cursor = conn.cursor()

cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
print('TABLES:', cursor.fetchall())

print('\nUSERS:')
cursor.execute('PRAGMA table_info(users)')
for row in cursor.fetchall():
    print(row)

print('\nBETS:')
cursor.execute('PRAGMA table_info(bets)')
for row in cursor.fetchall():
    print(row)

print('\nSESSIONS:')
cursor.execute('PRAGMA table_info(sessions)')
for row in cursor.fetchall():
    print(row)

conn.close()