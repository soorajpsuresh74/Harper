import json
from fastapi import FastAPI
import uvicorn

import config
from Models.createproject import CreateProjectModel
from database.createproject import ProjectSaver

app = FastAPI(debug=config.DEBUG)


@app.post('/API/sastproject/create')
async def sast_create_project(project: CreateProjectModel):
    data_object = project.dict()
    connector = ProjectSaver(data_object)
    connector.add_to_db()
    connector.close()
    return {"message": "success"}


if __name__ == '__main__':
    uvicorn.run(app, host=config.HOST, port=config.PORT)
