from pydantic import BaseModel, EmailStr
from typing import List, Optional


class CreateProjectModel(BaseModel):
    project_name: str
    local_path: str
    source_path: str
    excluded_folder: str
    excluded_file: str
    schedule: Optional[str]
    schedule_date: Optional[str]
    schedule_time: Optional[str]
    schedule_days: Optional[List[str]]
    pre_scan_mail: EmailStr
    post_scan_mail: EmailStr
    failure_scan_mail: EmailStr
    preset: Optional[str]
    config: Optional[str]
    team: Optional[str]
