import pandas as pd
from pathlib import Path
from app.services.inference.inference_engine import run_inference

class InferencePipeline:
    def __init__(self, data_dir: str = "data/sensor_csv"):
        self.data_path = Path(data_dir)

    def load_user_sensor_data(self, user_id: str) -> dict:
        """
        For now, this assumes one CSV file: 'data/sensor_csv/<user_id>.csv'
        And only reads the first row for inference.
        """
        file_path = self.data_path / f"{user_id}.csv"
        if not file_path.exists():
            raise FileNotFoundError(f"No sensor data file found for user_id: {user_id}")
        
        df = pd.read_csv(file_path)
        return df.iloc[0].to_dict()

    def run(self, user_id: str) -> dict:
        sensor_data = self.load_user_sensor_data(user_id)
        return run_inference(sensor_data)
