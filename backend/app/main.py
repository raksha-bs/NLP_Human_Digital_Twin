from fastapi import FastAPI
from app.api import activity
import os
from app.api import dashboard
from app.api import signUp
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI(title="Twinverse Backend")


origins = [
    "http://localhost:3000",  # Or whatever port Flutter runs on
    "http://127.0.0.1:8000",  # Add mobile app origin if needed
    "*",  # You can use this for dev, but avoid in production
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],  # or ["POST"] if you want to limit
    allow_headers=["*"],
)


app.include_router(activity.router, prefix="/activity", tags=["Activity"])
app.include_router(dashboard.router, prefix="/dashboard", tags=["Dashboard"])
app.include_router(signUp.router, prefix="/signup", tags=["Signup"])