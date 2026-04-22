import sqlite3
import pandas as pd

conn = sqlite3.connect('gaming.db')
cursor = conn.cursor()

cursor.executescript('''
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY,
    username TEXT,
    country TEXT,
    registration_date TEXT,
    age INTEGER
);

CREATE TABLE IF NOT EXISTS sessions (
    session_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    session_date TEXT,
    duration_minutes INTEGER,
    device TEXT
);

CREATE TABLE IF NOT EXISTS bets (
    bet_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    bet_date TEXT,
    amount REAL,
    game TEXT,
    result TEXT
);

INSERT INTO users VALUES
(1,'alex_g','Spain','2024-01-15',28),
(2,'maria_s','UK','2024-01-20',34),
(3,'john_d','Germany','2024-02-01',25),
(4,'sofia_r','Spain','2024-02-10',31),
(5,'lucas_m','Italy','2024-02-15',22),
(6,'anna_k','UK','2024-03-01',29),
(7,'pedro_v','Spain','2024-03-10',45),
(8,'emma_w','Germany','2024-03-15',27);

INSERT INTO sessions VALUES
(1,1,'2024-03-01',45,'mobile'),
(2,1,'2024-03-02',30,'desktop'),
(3,2,'2024-03-01',60,'desktop'),
(4,3,'2024-03-02',20,'mobile'),
(5,4,'2024-03-03',90,'tablet'),
(6,5,'2024-03-03',15,'mobile'),
(7,6,'2024-03-04',50,'desktop'),
(8,7,'2024-03-04',75,'mobile'),
(9,8,'2024-03-05',40,'desktop'),
(10,1,'2024-03-05',55,'mobile');

INSERT INTO bets VALUES
(1,1,'2024-03-01',50.0,'slots','win'),
(2,1,'2024-03-02',30.0,'poker','loss'),
(3,2,'2024-03-01',100.0,'roulette','win'),
(4,3,'2024-03-02',25.0,'slots','loss'),
(5,4,'2024-03-03',75.0,'poker','win'),
(6,5,'2024-03-03',10.0,'slots','loss'),
(7,6,'2024-03-04',200.0,'roulette','win'),
(8,7,'2024-03-04',150.0,'poker','loss'),
(9,8,'2024-03-05',80.0,'slots','win'),
(10,1,'2024-03-05',45.0,'roulette','loss');
''')

conn.commit()
conn.close()
print("Database created successfully!")