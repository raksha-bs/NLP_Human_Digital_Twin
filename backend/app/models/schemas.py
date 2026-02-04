from pydantic import BaseModel,  Field
from typing import List, Optional, Dict
from datetime import datetime, date

#Signup Models
class Injury(BaseModel):
    type: str
    other: Optional[str] = None
    date: date
    recovered: bool

class SignUpRequest(BaseModel):
    name: str
    age: int
    gender: str
    height_cm: float
    weight_kg: float
    fitness_level: str
    preferred_training: List[str]
    injuries: List[Injury]
# Dashboard Models
class DashboardRequest(BaseModel):
    user_id: str

# Activity Models
class ActivityStartRequest(BaseModel):
    user_id: str
    workoutType: str
    game_data: dict
class BeginActivityRequest(BaseModel):
    user_id: str
    plan: Dict

class ActivityUpdateRequest(BaseModel):
    user_id: str
    workoutType: str
    plan: str
    game_data: dict

class ActivityEndRequest(BaseModel):
    user_id: str
    time_worked_out:int
    workout_type: str
