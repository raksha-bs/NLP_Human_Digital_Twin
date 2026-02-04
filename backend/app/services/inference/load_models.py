import joblib
import pickle
from app.services.inference.multi_task_model import MultiTaskModel

def load_all_models():
    return {
        "anxiety": joblib.load("models/anxiety_model.pkl"),
        "stress": joblib.load("models/stress_model.pkl"),
        "motivation": joblib.load("models/motivation_model.pkl"),
        "physical": pickle.load(open("models/physicalModel.pkl", "rb")),
        "focus_classifier": joblib.load("models/focus_classifier.pkl"),
        "accuracy_regressor": joblib.load("models/accuracy_regressor.pkl"),
        "decision_regressor": joblib.load("models/decision_regressor.pkl"),
        "focus_label_encoder": joblib.load("models/focus_label_encoder.pkl"),
        "cognitive_features": joblib.load("models/model_features.pkl"),
        "cognitive_features": joblib.load("models/model_features.pkl"),
        "balance_model": joblib.load("models/model_balance.pkl"),
        "dexterity_model": joblib.load("models/model_dexterity.pkl"),
        "posture_model": joblib.load("models/model_posture.pkl"),
        "leader_model": joblib.load("models/leadership_predict.pkl"),
        "engage_model": joblib.load("models/engagement_predict.pkl"),
        "engage_encoder": joblib.load("models/engagement_encoder.pkl"),
        "coop_model": joblib.load("models/cooperation_predict.pkl")
    }

# Use global caching to avoid reloading models
MODELS = load_all_models()
