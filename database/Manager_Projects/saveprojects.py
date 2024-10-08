import os
import sqlite3
import uuid
import logging
import config


class ProjectSaver:
    def __init__(self, json_object: dict):
        self.json_object = json_object
        base_directory = 'database/store/data/'
        db_path = os.path.join(base_directory, 'saved_projects.db')

        if not os.path.exists(base_directory):
            os.makedirs(base_directory)

        self.connection = sqlite3.connect(db_path)
        self.cursor = self.connection.cursor()
        self.create_table()

    def create_table(self) -> None:
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

    def save_project(self) -> None:  # Renamed for clarity
        try:
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
                self.json_object.get('project_name', ''),
                self.json_object.get('preset', ''),
                self.json_object.get('config', ''),
                self.json_object.get('team', ''),
                self.json_object.get('local_path', ''),
                self.json_object.get('source_path', ''),
                self.json_object.get('excluded_folder', ''),
                self.json_object.get('excluded_file', ''),
                self.json_object.get('schedule', ''),
                self.json_object.get('schedule_date', ''),
                self.json_object.get('schedule_time', ''),
                ', '.join(self.json_object.get('schedule_days', [])),
                self.json_object.get('pre_scan_mail', ''),
                self.json_object.get('post_scan_mail', ''),
                self.json_object.get('failure_scan_mail', ''),
                1 if self.json_object.get('status', False) else 0,
            ))
            self.connection.commit()
            config.log_info("Project successfully added to the database.")
        except sqlite3.IntegrityError:
            config.log_error("Project ID already exists in the database.")
        except Exception as e:
            config.log_error(f"Error while inserting project: {e}")

    def close(self) -> None:
        self.connection.close()
