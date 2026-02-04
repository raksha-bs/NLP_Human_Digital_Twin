from fastapi import APIRouter
from app.models.schemas import ActivityStartRequest, BeginActivityRequest, ActivityUpdateRequest, ActivityEndRequest
from app.services.activity_logic import start_activity, begin_activity, update_activity, end_activity

router = APIRouter()

@router.post("/generate")
def generate_activity_route(request: ActivityStartRequest):
    return start_activity(request.user_id, request.workoutType, request.game_data)

@router.post("/start")
def start_activity_route(request: BeginActivityRequest):
    return begin_activity(request.user_id, request.plan)

@router.post("/update")
def update_activity_route(request: ActivityUpdateRequest):
    return update_activity(request.user_id, request.workoutType, request.plan, request.game_data)

@router.post("/end")
def end_activity_route(request: ActivityEndRequest):
    return end_activity(request.user_id, request.time_worked_out, request.workout_type)
