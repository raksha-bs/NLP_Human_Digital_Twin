from app.db.mongo import get_db
from datetime import datetime, date, time
from app.models.schemas import SignUpRequest
from faker import Faker

fake = Faker()

def add_user(sign_up_data: SignUpRequest):
    """
    Adds a new user to the user_profiles collection with a custom user_id.
    """
    db = get_db()
    collection = db["user_profiles"]

    # Generate custom user_id
    user_id = f"athlete_{fake.unique.random_int(100, 999)}"

    # Prepare the document
  
    user_document = {
        "user_id": user_id,
        "name": sign_up_data.name,
        "age": sign_up_data.age,
        "gender": sign_up_data.gender,
        "height_cm": sign_up_data.height_cm,
        "weight_kg": sign_up_data.weight_kg,
        "fitness_level": sign_up_data.fitness_level,
        "preferred_training": sign_up_data.preferred_training,
        "injuries": [
        {
            "type": injury.type,
            "other": injury.other,
            "date": datetime.combine(injury.date, time.min) if isinstance(injury.date, date) and not isinstance(injury.date, datetime) else injury.date,
            "recovered": injury.recovered
        }
        for injury in sign_up_data.injuries
        ],
        "created_at": datetime.utcnow(),
        "active_session": None  # Initially no active session
    }

    # Insert into MongoDB
    insert_result = collection.insert_one(user_document)

    return {"message": "User added successfully", "user_id": user_id}