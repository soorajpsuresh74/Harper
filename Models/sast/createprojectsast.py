from pydantic import BaseModel
from typing import List, Optional


class CreateProjectModelSAST(BaseModel):
    projectName: str
    preset: Optional[str]
    config: Optional[str]
    team: Optional[str]
    localPath: Optional[str]
    sourcePath: Optional[str]
    excludedFolder: Optional[str]
    excludedFile: Optional[str]
    schedule: Optional[str]
    scheduleDate: Optional[str]
    scheduleTime: Optional[str]
    scheduleDays: Optional[List[str]]
    preScanMail: str
    postScanMail: str
    failureScanMail: str
    status: bool
