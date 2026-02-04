import os
from app.services.llm_utils import (
     get_summary
)
from app.services.inference.pipeline import InferencePipeline
import numpy as np
import json

def convert_np(obj):
    if isinstance(obj, dict):
        return {k: convert_np(v) for k, v in obj.items()}
    elif isinstance(obj, list):
        return [convert_np(i) for i in obj]
    elif isinstance(obj, np.generic):
        return obj.item()
    else:
        return obj
def get_current_state(user_id):
    pipeline = InferencePipeline(data_dir="data/sensor_csv")
    return pipeline.run(user_id)

def parse_state(user_id: str):
    # Logic to start and save session
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise EnvironmentError("OPENAI_API_KEY is not set in the environment.")
    
    
    state = get_current_state(user_id)
    summary = get_summary(state, user_id, api_key)
    summary_dict = json.loads(summary)
    return {
        "state": state,
        "summary": summary_dict
    }