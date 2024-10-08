import os.path
import sqlite3

import config


class ProjectFetcher:
    def __init__(self):
        base_directory = 'database/store/data/'
        db_path = os.path.join(base_directory, 'saved_projects.db')

        self.connection = sqlite3.connect(db_path)
        self.cursor = self.connection.cursor()
        self.projects = []

    def fetch_saved(self):
        try:
            self.cursor.execute('SELECT * FROM projects')
            rows = self.cursor.fetchall()

            for row in rows:
                project = {
                    'id': row[1],
                    "preset": row[2],
                    "config": row[3],
                    "team": row[4],
                }
                self.projects.append(project)
            if len(self.projects) != 0:
                return self.projects
            return []
        except Exception as e:
            config.log_error(f"Error while retrieving projects: {e}")
            return []

    def close(self):
        self.connection.close()
