from fastapi import APIRouter, Query
from app.models.schemas import DashboardRequest
from app.services.dashboard_logic import parse_state

router = APIRouter()

@router.get("/")
def get_dashboard_output(user_id: str = Query(...)):
    return parse_state(user_id)
