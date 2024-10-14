from typing import List

from fastapi import FastAPI, HTTPException
import uvicorn
from fastapi.responses import JSONResponse

import config
from Models.createproject import CreateProjectModel
from Models.projectmanagermain import ProjectManagerMain
from database.Manager_Projects.fetchsavedproject import ProjectFetcher
from database.Manager_Projects.saveprojects import ProjectSaver

app = FastAPI(debug=config.DEBUG)


@app.post('/API/sast/create')
async def sast_create_project(project: CreateProjectModel):
    data_object = project.dict()
    connector = ProjectSaver(data_object)
    connector.save_project()
    connector.close()
    return {"message": "success"}


@app.get('/API/saved_projects')
async def show_saved_projects():
    fetcher = ProjectFetcher()
    projects = fetcher.fetch_saved()
    if not projects:
        raise HTTPException(status_code=404, detail="No projects found")
    return JSONResponse(content=projects)


@app.get('/API/projectmanager/fetch1')
async def show_saved_projects():
    data = [
        {
            "id": 1,
            "projectName": "Project A",
            "projectSource": "GitHub",
            "lastScan": "2 hours ago",
            "tags": ["web", "flutter"],
            "risk": "High",
            "high": 12,
            "medium": 5,
            "low": 3
        }, {

            "id": 2,
            "projectName": "Project A",
            "projectSource": "GitHub",
            "lastScan": "2 hours ago",
            "tags": ["web", "flutter"],
            "risk": "High",
            "high": 12,
            "medium": 5,
            "low": 3
        }, {

            "id": 3,
            "projectName": "Project A",
            "projectSource": "GitHub",
            "lastScan": "2 hours ago",
            "tags": ["web", "flutter"],
            "risk": "High",
            "high": 12,
            "medium": 5,
            "low": 3
        }

    ]
    return data


if __name__ == '__main__':
    uvicorn.run(app, host=config.HOST, port=config.PORT)
