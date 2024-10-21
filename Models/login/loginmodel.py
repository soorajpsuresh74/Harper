from pydantic import BaseModel


class DoLoginModel(BaseModel):
    username: str
    password: str
