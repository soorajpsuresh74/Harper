import os
from sqlalchemy import create_engine, Column, String
from sqlalchemy.orm import sessionmaker, declarative_base
import config

Base = declarative_base()
config.log_info("Base created")


class DatabaseUrl:
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
    PARENT_DIR = os.path.dirname(BASE_DIR)
    GRANDPARENT_DIR = os.path.dirname(PARENT_DIR)

    DATABASE_URLS = [
        f'sqlite:///{os.path.join(GRANDPARENT_DIR, "database/store/data/DB_DAST_projects.db")}',
        f'sqlite:///{os.path.join(GRANDPARENT_DIR, "database/store/data/DB_SAST_projects.db")}'
    ]


class Projects(Base):
    __tablename__ = 'projects'
    id = Column(String, primary_key=True)
    localPath = Column(String)


class FileManager:
    def __init__(self, id):
        self.id = id

    def path_from_id(self):
        for db_url in DatabaseUrl.DATABASE_URLS:
            config.log_info(f"Attempting to connect to database: {db_url}")
            engine = create_engine(db_url)
            Session = sessionmaker(bind=engine)
            session = Session()
            config.log_info(f"Attempting making session to database: {db_url}")

            try:
                project = session.query(Projects).filter_by(id=self.id).first()
                if project:
                    config.log_info(f"Found path for project {self.id} in {db_url}: {project.localPath}")
                    return project.localPath
                else:
                    config.log_info(f"No project found with ID: {self.id} in {db_url}")
            except Exception as e:
                config.log_info(f"Error fetching path for project {self.id} in {db_url}: {e}")
                return None
            finally:
                session.close()
        config.log_info(f"No project found with ID: {self.id} in both databases.")
        return None

    def files_from_path(self):
        path = self.path_from_id()

        if path and os.path.exists(path):
            try:
                files = [os.listdir(path)]
                config.log_info(f"Files found in {path}: {files}")
                return files
            except Exception as e:
                config.log_info(f"Error reading files from path {path}: {e}")
                return []
        else:
            config.log_info("Invalid path or project not found.")
            return []

    def sort_files(self):
        files = self.files_from_path()
        python = []
        go = []
        java = []
        js = []

        for file in files:
            if isinstance(file, str):
                if file.endswith('.py'):
                    python.append(file)
                elif file.endswith('.go'):
                    go.append(file)
                elif file.endswith('.java'):
                    java.append(file)
                elif file.endswith('.js'):
                    js.append(file)

        config.log_info(f"Sorted Python files: {python}")
        config.log_info(f"Sorted Go files: {go}")
        config.log_info(f"Sorted Java files: {java}")
        config.log_info(f"Sorted JavaScript files: {js}")

        return {
            'python': python,
            'go': go,
            'java': java,
            'js': js,
        }


if __name__ == "__main__":
    file_manager = FileManager(id='e9f874f6-318e-4036-bb6f-c3050988f942')
    project_path = file_manager.path_from_id()

    if project_path:
        config.log_info(f"Project path: {project_path}")
    else:
        config.log_info("Project not found in either database.")
