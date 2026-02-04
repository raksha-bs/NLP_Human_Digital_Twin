from fastapi import APIRouter
from app.models.schemas import SignUpRequest
from app.services.signup_logic import add_user

router = APIRouter()

@router.post("/")
def create_profile(request:SignUpRequest):
    return add_user(request)