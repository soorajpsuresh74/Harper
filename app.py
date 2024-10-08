from fastapi import FastAPI, HTTPException
import uvicorn
from fastapi.responses import JSONResponse

import config
from Models.createproject import CreateProjectModel
from database.Manager_Projects.fetchsavedproject import ProjectFetcher
from database.Manager_Projects.saveprojects import ProjectSaver

app = FastAPI(debug=config.DEBUG)


@app.post('/API/sastproject/create')
async def sast_create_project(project: CreateProjectModel):
    data_object = project.dict()
    connector = ProjectSaver(data_object)
    connector.add_to_db()
    connector.close()
    return {"message": "success"}


@app.get('/API/saved_projects')
async def show_saved_projects():
    fetcher = ProjectFetcher()
    projects = fetcher.fetch_saved()
    if not projects:
        raise HTTPException(status_code=404, detail="No projects found")
    return JSONResponse(content=projects)


if __name__ == '__main__':
    uvicorn.run(app, host=config.HOST, port=config.PORT)
