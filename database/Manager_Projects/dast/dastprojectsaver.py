import os
import sqlite3
import uuid
import logging
import config

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


class DASTProjectSaver:
    def __init__(self, json_object: dict):
        self.json_object = json_object
        base_directory = 'database/store/data/'
        db_path = os.path.join(base_directory, 'DB_DAST_projects.db')

        # Ensure the directory exists
        if not os.path.exists(base_directory):
            os.makedirs(base_directory)

        self.db_path = db_path  # Store the database path for reuse
        self.connection = None
        self.cursor = None

    def connect(self):
        """Establish a database connection and create the table if necessary."""
        try:
            self.connection = sqlite3.connect(self.db_path)
            self.cursor = self.connection.cursor()
            self.create_table()
        except sqlite3.Error as e:
            logging.error(f"Error connecting to the database: {e}")
            raise

    def create_table(self) -> None:
        """Create the projects table if it doesn't exist."""
        try:
            self.cursor.execute('''  
            CREATE TABLE IF NOT EXISTS projects (
                serial_number INTEGER PRIMARY KEY AUTOINCREMENT,
                id TEXT NOT NULL UNIQUE,
                name TEXT NOT NULL,
                preset TEXT NOT NULL,
                config TEXT NOT NULL,
                team TEXT NOT NULL,
                localPath TEXT,
                sourcePath TEXT,
                excludedFolder TEXT,
                excludedFile TEXT,
                schedule TEXT,
                scheduleDate DATE,
                scheduleTime TEXT,
                scheduleDays TEXT,
                preScanMail TEXT,
                postScanMail TEXT,
                failureScanMail TEXT,
                status INTEGER
            )''')  # Removed the trailing comma
            self.connection.commit()
        except sqlite3.Error as e:
            logging.error(f"Error creating table: {e}")
            raise

    def save_project(self) -> None:
        """Insert a new project into the database."""
        try:
            if not self.connection or not self.cursor:
                self.connect()  # Ensure we are connected to the database

            project_id = self.json_object.get('id', str(uuid.uuid4()))  # Ensure project_id is unique

            self.cursor.execute('''  
            INSERT INTO projects (
                id, name, preset, config, team, localPath, sourcePath,
                excludedFolder, excludedFile, schedule,
                scheduleDate, scheduleTime, scheduleDays,
                preScanMail, postScanMail, failureScanMail, status
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''', (
                project_id,
                self.json_object.get('projectName', ''),
                self.json_object.get('preset', ''),
                self.json_object.get('config', ''),
                self.json_object.get('team', ''),
                self.json_object.get('localPath', ''),
                self.json_object.get('sourcePath', ''),
                self.json_object.get('excludedFolder', ''),
                self.json_object.get('excludedFile', ''),
                self.json_object.get('schedule', ''),
                self.json_object.get('scheduleDate', ''),
                self.json_object.get('scheduleTime', ''),
                ', '.join(self.json_object.get('scheduleDays', [])),
                self.json_object.get('preScanMail', ''),
                self.json_object.get('postScanMail', ''),
                self.json_object.get('postScanMail', ''),
                1 if self.json_object.get('status', False) else 0,
            ))

            self.connection.commit()
            logging.info("Project successfully added to the database.")
        except sqlite3.IntegrityError:
            logging.error("Project ID already exists in the database.")
        except sqlite3.Error as e:
            logging.error(f"Error while inserting project: {e}")
            raise

    def close(self) -> None:
        """Close the database connection."""
        if self.connection:
            self.connection.close()
            logging.info("Database connection closed.")

    def __del__(self):
        """Ensure the connection is closed when the object is deleted."""
        self.close()
