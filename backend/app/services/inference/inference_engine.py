import pandas as pd
import numpy as np
from app.services.inference.multi_task_model import MultiTaskModel
from .load_models import MODELS
from .features import (
    MENTAL_FEATURES, COGNITIVE_FEATURES,
    BIOMECHANICAL_FEATURES, INTERPERSONAL_FEATURES,
    apply_label_encodings
)

def run_inference(sensor_input: dict):
    df = pd.DataFrame([sensor_input])

    # MENTAL
    df_mental = df[MENTAL_FEATURES]
    mental = {
        "stress_level": int(MODELS["stress"].predict(df_mental)[0]),
        "anxiety_level": str(MODELS["anxiety"].predict(df_mental)[0]),
        "motivation_score": int(MODELS["motivation"].predict(df_mental)[0])
    }

    # PHYSICAL
    physical_package = MODELS["physical"]
    df = apply_label_encodings(df, physical_package["label_encoders"],
                               ['workout_intensity', 'time_of_day', 'energy_level', 'fatigue_level', 'posture_label'])
    df_physical = df[physical_package["feature_columns"]]
    Y_class_pred = physical_package["classifier"].predict(df_physical)
    Y_reg_pred = physical_package["regressor"].predict(df_physical)
    physical = {
        k: v.item() if isinstance(v, (np.generic, np.ndarray)) else v
        for k, v in zip(
            physical_package["classification_targets"] + physical_package["regression_targets"],
            list(Y_class_pred[0]) + list(Y_reg_pred[0])
        )
}

    # COGNITIVE
    df_cog = df[MODELS["cognitive_features"]]  # Just 1 row

    # Predict each target
    focus_pred = MODELS["focus_classifier"].predict(df_cog)
    focus_label = MODELS["focus_label_encoder"].inverse_transform(focus_pred)[0]

    acc_pred = MODELS["accuracy_regressor"].predict(df_cog)[0]
    dec_pred = MODELS["decision_regressor"].predict(df_cog)[0]

    # Map and interpret
    focus_map = {
        'low': 'low',
        'medium': 'normal',
        'high': 'hyper'
    }
    focus_output = focus_map.get(focus_label, focus_label)

    def interpret_decision_score(score):
        if score >= 0.00003:
            return "fast"
        elif score >= 0.000015:
            return "average"
        else:
            return "hesitant"

    decision_output = interpret_decision_score(dec_pred)

    reaction_time = int(df_cog["time_on_task"].values[0]) if "time_on_task" in df_cog.columns else None

    cognitive = {
    "focus_level": focus_output,
    "decision_making": decision_output,
    "reaction_time": reaction_time,
    "accuracy": float(round(acc_pred, 3))
    }

    # BIOMECHANICAL
    df_bio = df[BIOMECHANICAL_FEATURES]
    biomechanical = {
        "balance_score": float(MODELS["balance_model"].predict(df_bio)[0]),
        "dexterity_score": float(MODELS["dexterity_model"].predict(df_bio)[0]),
        "posture_analysis": str(MODELS["posture_model"].predict(df_bio)[0])
    }

    # INTERPERSONAL
    df_inter = df[INTERPERSONAL_FEATURES]
    interpersonal = {
        "leadership_score": float(MODELS["leader_model"].predict(df_inter)[0]),
        "social_engagement": MODELS["engage_encoder"].inverse_transform(
            MODELS["engage_model"].predict(df_inter))[0],
        "cooperation_score": float(MODELS["coop_model"].predict(df_inter)[0])
    }

    return {
        "mental": mental,
        "physical": physical,
        "cognitive": cognitive,
        "biomechanical": biomechanical,
        "interpersonal": interpersonal
    }
