from typing import List

from pydantic import BaseModel


class UserBase(BaseModel):
    first_name: str
    last_name: str
    phone_num: str
    email: str


class UserInDB(UserBase):
    id: int
    tokens: List[str] | None


# model to create a user
class UserIn(UserBase):
    password: str


# model to use in responses
class UserOut(UserBase):
    id: int


class UserNameEdit(BaseModel):
    first_name: str | None = None
    last_name: str | None = None


class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    email: str | None = None
