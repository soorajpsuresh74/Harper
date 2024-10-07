from fastapi import FastAPI
import uvicorn

import config
from Models.createproject import CreateProjectModel

app = FastAPI(debug=config.DEBUG)


@app.post('/API/sastproject/create')
async def sast_create_project(project: CreateProjectModel):
    print(project.json())
    return {"message": "success"}


if __name__ == '__main__':
    uvicorn.run(app, host=config.HOST, port=config.PORT)
