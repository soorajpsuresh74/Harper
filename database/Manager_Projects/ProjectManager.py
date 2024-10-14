import logging
import os.path
import sqlite3
import sys

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


class ProjectManagerDB:
    def __init__(self):
        self.base_directory = 'database/store/data/'
        self.db_sast = os.path.join(self.base_directory, 'DB_SAST_projects.db')
        self.db_dast = os.path.join(self.base_directory, 'DB_DAST_projects.db')

        if not os.path.exists(self.db_sast) or not os.path.exists(self.db_dast):
            logging.error('Database files not found. Exiting...')
            sys.exit()

    @staticmethod
    def get_all_projects_from_db(db_path):
        connector = sqlite3.connect(db_path)
        cursor = connector.cursor()

        try:
            cursor.execute('SELECT * FROM projects')
            projects = cursor.fetchall()
        except Exception as e:
            logging.error(f"Error retrieving data from {db_path}: {e}")
            return []
        finally:
            connector.close()

        formatted_projects = []
        for project in projects:
            project_data = {
                'id': project[0],
                'projectName': project[1],
                'config': project[2],
                'team': project[3],
                'preset': project[4],
                'status': project[5],
            }
            formatted_projects.append(project_data)

        return formatted_projects

    def get_all_projects(self):
        sast_projects = self.get_all_projects_from_db(self.db_sast)
        dast_projects = self.get_all_projects_from_db(self.db_dast)
        logging.info('Get all projects function succeeded')
        return sast_projects + dast_projects

