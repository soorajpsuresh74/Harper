from pydantic import BaseModel, EmailStr
from typing import List, Optional


class CreateProjectModel(BaseModel):
    project_name: str
    local_path: Optional[str]
    source_path: Optional[str]
    excluded_folder: Optional[str]
    excluded_file: Optional[str]
    schedule: Optional[str]
    schedule_date: Optional[str]
    schedule_time: Optional[str]
    schedule_days: Optional[List[str]]
    pre_scan_mail: str
    post_scan_mail: str
    failure_scan_mail: str
    preset: Optional[str]
    config: Optional[str]
    team: Optional[str]
    status: bool
