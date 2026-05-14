from faker import Faker
import sqlite3
import random

fake = Faker()

conn = sqlite3.connect("hw_2.sqlite")
cursor = conn.cursor()

for _ in range(5):
    fullname = fake.name()
    email = fake.unique.email()
    cursor.execute("INSERT INTO users (fullname, email) VALUES (?, ?)", (fullname, email))

cursor.execute("SELECT id FROM users")
user_ids = [row[0] for row in cursor.fetchall()]

cursor.execute("SELECT id FROM status")
status_ids = [row[0] for row in cursor.fetchall()]

for _ in range(10):
    title = fake.sentence(nb_words=4)
    description = fake.text()
    status_id = random.choice(status_ids)
    user_id = random.choice(user_ids)
    cursor.execute(
        "INSERT INTO tasks (title, description, status_id, user_id) VALUES (?, ?, ?, ?)",
        (title, description, status_id, user_id)
    )

conn.commit()
conn.close()
