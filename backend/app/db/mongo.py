from pymongo import MongoClient
import os

def get_db():
    client = MongoClient(os.getenv("MONGO_URI"))
    return client["digital_twin_db"]

def get_user_profile(user_id):
    db = get_db()
    profile = db["user_profiles"].find_one({"user_id": user_id})
    if not profile:
        raise ValueError("User not found.")
    return profile