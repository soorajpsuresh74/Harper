from fastapi import FastAPI
from pydantic import BaseModel
import logging
import os.path
import sqlite3

app = FastAPI()

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


# Model to receive credentials
class DoLoginModel(BaseModel):
    username: str
    password: str


class ValidateLogin:
    def __init__(self, json_object: dict):
        self.json_object = json_object
        self.base_directory = 'database/store/data/'
        self.db_path = os.path.join(self.base_directory, 'DB_LOGIN_CREDENTIALS.db')

        if not os.path.exists(self.base_directory):
            os.makedirs(self.base_directory)

        self.initialize_db()

    def initialize_db(self):
        logging.info("Initializing database...")
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            cursor.execute('''
            CREATE TABLE IF NOT EXISTS credentials(
            username TEXT PRIMARY KEY,
            password TEXT NOT NULL
                )
            ''')
            conn.commit()
            logging.info('Database initialized')

    def load_sample_data(self):
        logging.info("Loading sample data...")
        sample_data = [
            {"username": "q", "password": "qwerty"},
            {"username": "john", "password": "doe123"},
        ]
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            for data in sample_data:
                cursor.execute("INSERT OR IGNORE INTO credentials(username, password) VALUES (?, ?)",
                               (data['username'], data['password']))
            conn.commit()
            logging.info("Sample data loaded")

    def validate(self):
        username = self.json_object.get('username')
        password = self.json_object.get('password')

        if self.check_user_exists(username):
            if self.verify_password(username, password):
                logging.info("Login successful for user: %s", username)
                return True, username
            else:
                logging.warning("Invalid password for user: %s", username)
                return False, username
        else:
            logging.warning("User not found: %s", username)
            return False, username

    def check_user_exists(self, username):
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT COUNT(1) FROM credentials WHERE username = ?", (username,))
            exists = cursor.fetchone()[0] > 0
            logging.info("User exists: %s - %s", username, exists)
            return exists

    def verify_password(self, username, password):
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT password FROM credentials WHERE username =?", (username,))
            stored_password = cursor.fetchone()
            if stored_password:
                match = stored_password[0] == password
                logging.info('Password match for user: %s - %s', username, match)
                return match
            return False
