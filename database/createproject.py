import os
import sqlite3
import uuid
import logging

import config


class ProjectSaver:
    def __init__(self, json_object):
        self.json_object = json_object
        base_directory = 'store/data/'
        db_path = os.path.join(base_directory, 'create_project.db')

        # Create the directory if it doesn't exist
        if not os.path.exists(base_directory):
            os.makedirs(base_directory)

        # Connect to the SQLite database
        self.connection = sqlite3.connect(db_path)
        self.cursor = self.connection.cursor()
        self.create_table()

    def create_table(self):
        self.cursor.execute('''
        CREATE TABLE IF NOT EXISTS projects(
            serial_number INTEGER PRIMARY KEY AUTOINCREMENT,
            id TEXT NOT NULL,
            preset TEXT NOT NULL,
            config TEXT NOT NULL,
            team TEXT NOT NULL,
            localPath TEXT NOT NULL,
            sourcePath TEXT NOT NULL,
            excludedFolder TEXT NOT NULL,
            excludedFile TEXT NOT NULL,
            schedule TEXT NOT NULL,
            scheduleDate DATE NOT NULL,
            scheduleTime TEXT NOT NULL,
            scheduleDays TEXT NOT NULL,
            preScanMail TEXT NOT NULL,
            postScanMail TEXT NOT NULL,
            failureScanMail TEXT NOT NULL
        )''')
        self.connection.commit()

    def add_to_db(self):
        try:
            # Generate a unique ID if not provided
            project_id = self.json_object.get('id', str(uuid.uuid4()))

            # Insert the project data into the database
            self.cursor.execute('''
            INSERT INTO projects (
                id, preset, config, team, localPath, sourcePath, 
                excludedFolder, excludedFile, schedule, 
                scheduleDate, scheduleTime, scheduleDays, 
                preScanMail, postScanMail, failureScanMail
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''', (
                project_id,
                self.json_object.get('preset'),
                self.json_object.get('config'),
                self.json_object.get('team'),
                self.json_object.get('local_path'),
                self.json_object.get('source_path'),
                self.json_object.get('excluded_folder'),
                self.json_object.get('excluded_file'),
                self.json_object.get('schedule'),
                self.json_object.get('schedule_date'),
                self.json_object.get('schedule_time'),
                ', '.join(self.json_object.get('schedule_days', [])),  # Join list to string
                self.json_object.get('pre_scan_mail'),
                self.json_object.get('post_scan_mail'),
                self.json_object.get('failure_scan_mail')
            ))
            self.connection.commit()
            config.log_info("Project successfully added to the database.")
        except Exception as e:
            config.log_error(f"Error while inserting project: {e}")

    def close(self):
        self.connection.close()
