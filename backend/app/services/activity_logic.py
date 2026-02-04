import os
from app.services.llm_utils import (
 generate_state_summary, generate_training, generate_alternate_training
)
import json
from app.services.inference.pipeline import InferencePipeline
from app.db.mongo import get_db
from datetime import datetime

def get_current_state(user_id):
    pipeline = InferencePipeline(data_dir="data/sensor_csv")
    return pipeline.run(user_id)

def start_activity(user_id: str, workoutType: str, game_data: dict):
    # Logic to start and save session
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise EnvironmentError("OPENAI_API_KEY is not set in the environment.")
    
    
    state = get_current_state(user_id)
    result = generate_state_summary(state, user_id, api_key)

    summary = result["summary"]
    profile = result["profile"]
    plan = generate_training(summary, workoutType, profile, api_key)
    print(plan)

    return {
        "rationale": json.loads(plan)["rationale"],
        "training_plan": json.loads(plan)["training_plan"]
    }


def begin_activity(user_id: str, plan: dict):
    """
    Starts a new active session for a user with the given plan.
    """
    db = get_db()
    collection = db["user_profiles"]

    update_result = collection.update_one(
        {"user_id": user_id},
        {
            "$set": {
                "active_session": {
                    "activity_status": "ongoing",
                    "current_training_plan": plan,
                    "start_time": datetime.utcnow()
                }
            }
        }
    )

    if update_result.matched_count == 0:
        raise ValueError(f"No user found with user_id {user_id}")

    return {"message": f"Active session started for {user_id}."}

def update_activity(user_id: str, workoutType: str, plan: dict, game_data: dict):
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise EnvironmentError("OPENAI_API_KEY is not set in the environment.")
    
    
    state = get_current_state(user_id)
    result = generate_state_summary(state, user_id, api_key)

    summary = result["summary"]
    profile = result["profile"]
    plan = generate_alternate_training(summary, workoutType, profile, plan,  api_key)
    

    return {
        "rationale": json.loads(plan)["rationale"],
        "training_plan": json.loads(plan)["training_plan"]
    }

def end_activity(user_id: str, time_worked_out: int, workout_type: str):
    """
    Ends the user's current active session and archives it into past workouts.
    """

    db = get_db()
    collection = db["user_profiles"]

    user = collection.find_one({"user_id": user_id})
    if not user or "active_session" not in user:
        raise ValueError(f"No active session found for user {user_id}")

    active_session = user["active_session"]

    # Build the completed workout entry
    completed_workout = {
        "activity_status": "completed",
        "training_plan": active_session.get("current_training_plan"),
        "start_time": active_session.get("start_time"),
        "end_time": datetime.utcnow(),
        "date_completed": datetime.utcnow().date().isoformat(),
        "workout_type": workout_type,
        "time_worked_out_minutes": time_worked_out
    }

    # Update user profile: push to past_workouts, remove active_session
    update_result = collection.update_one(
        {"user_id": user_id},
        {
            "$push": {"past_workouts": completed_workout},
            "$unset": {"active_session": ""}
        }
    )

    if update_result.matched_count == 0:
        raise ValueError(f"Failed to archive session for user {user_id}")

    return {"message": f"Workout session completed and archived for {user_id}."}