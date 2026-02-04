MENTAL_FEATURES = [
    "eda", "eda_delta", "hrv_mean_hr", "hrv_sdnn", "hrv_rmssd", "hrv_lf", "hrv_hf", "hrv_lf_hf"
]

COGNITIVE_FEATURES = [
    "time_on_task", "num_correct", "num_incorrect", "hr_mean", "hr_std", "gsr_mean", "gsr_std",
    "rr_mean", "rr_std", "temperature_mean", "temperature_std",
    "band_ax_mean", "band_ax_std", "band_ay_mean", "band_ay_std", "band_az_mean", "band_az_std"
]

BIOMECHANICAL_FEATURES = [
    "x_mean","x_std","x_min","x_max","x_range","x_median","x_iqr",
    "y_mean","y_std","y_min","y_max","y_range","y_median","y_iqr",
    "z_mean","z_std","z_min","z_max","z_range","z_median","z_iqr",
    "magnitude_mean","magnitude_std","magnitude_min","magnitude_max","magnitude_range",
    "magnitude_median","magnitude_iqr","jerk_mean","jerk_std","total_movement"
]

INTERPERSONAL_FEATURES = [
    "avg_power", "total_speaking_time", "initiations", "avg_arousal", "smile_rate",
    "avg_utterance_length", "agreement_word_count", "interrupt_rate", "avg_valence", "total_turns"
]
def apply_label_encodings(df, encoders, cols):
    for col in cols:
        if col in df.columns and col in encoders:
            df[col] = encoders[col].transform([df[col].values[0]])
    return df