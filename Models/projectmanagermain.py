from pydantic import BaseModel


class ProjectManagerMain(BaseModel):
    name: str
    source: str
    last_scan: str
    tags: str
    risk: str
    high: int
    medium: int
    low: int

    class Config:
        schema_extra = {
            "example": {
                "name": "Project A",
                "source": "GitHub",
                "last_scan": "2 hours ago",
                "tags": "web, flutter",
                "risk": "High",
                "high": 12,
                "medium": 5,
                "low": 3
            }
        }
