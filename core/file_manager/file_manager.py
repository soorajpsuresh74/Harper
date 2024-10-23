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


if __name__ == "__main__":
    file_manager = FileManager(id='e9f874f6-318e-4036-bb6f-c3050988f942')
    project_path = file_manager.path_from_id()

    if project_path:
        config.log_info(f"Project path: {project_path}")
    else:
        config.log_info("Project not found in either database.")
