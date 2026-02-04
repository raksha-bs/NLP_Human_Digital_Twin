import openai
from pymongo import MongoClient
from app.db.mongo import get_user_profile
import json

def get_training_plan(summary,workoutType,profile ):
    plan_prompt = f"""
    You are a digital coach. Based on the following individual’s digital twin state summary, profile and preferred workout type for that day, generate a personalized training plan for today.
    PREFERRED WORKOUT:
    {workoutType}
    PROFILE:
    {profile}
    The training plan must:
    - Respect physical fatigue and injury risks
    - Leverage strengths (e.g., high endurance, hyper-focus)
    - Adapt difficulty to energy and motivation levels
    - Include rest or mobility if needed
    - Be structured as daily blocks
    -Take the workouttype into consideration
    - **Specify exact exercises, poses, or movements (e.g., list yoga poses, cardio drills, strength exercises) instead of generic advice**
    - **Ensure each exercise/pose has a clear name (e.g., "Downward Dog", "Lunges") and optionally add short instructions if needed**
    
    Digital Twin State:
    {summary}

    Return output in JSON:
    {{
    "training_plan": {{
        "Warmup": "...",
        "Main workout": "...",
        "Additional advice": "..."
    }},
    "rationale": "Explain why this plan fits the current state of the individual in 2 sentences or less"
    }}
    """

    return plan_prompt


def reasoning_prompt(state, profile):

    with open("corelations.json", "r") as f:
        correlation_json = json.load(f)
    prompt = f"""
    We are designing a digital twin system to model a human being, i.e. a Human Digital Twin. We want to represent the digital twin with 5 human centric categories: 1) mental, 2) physical, 3) cognitive, 4) biomechanical and 5) interpersonal. Current use case is to model athletes or individuals interested in sports and exercising.

    Your task is to analyze the following individual’s profile and current multimodal state outputs from five independent models (mental, physical, cognitive, biomechanical, and interpersonal). Use the data to generate a **holistic summary** of the person's current overall state, identifying relationships or interactions across domains — for example, how fatigue may be affecting focus, or how social tension may lower motivation.

    Please use the correlation schema below as a guide for reasoning. These correlations represent known relationships between different human states, and should be factored into your analysis:
    
    CORRELATION_SCHEMA:
    {correlation_json}

    PROFILE:
    {profile}

    STATE DATA:
    MENTAL: {state['mental']}
    PHYSICAL: {state['physical']}
    COGNITIVE: {state['cognitive']}
    BIOMECHANICAL: {state['biomechanical']}
    INTERPERSONAL: {state['interpersonal']}

    FORMAT:
    {{
    "summary": "A short paragraph summarizing the individual's overall condition, including notable cross-domain effects.",
    "inferred_interactions": [
        {{
        "cause":...,
        "effect": ...,
        "relationship": ..."
        }},
        ...
    ],
    "risk_flags": [
        ....
    ]
    }}
    """
    return prompt


def get_alternate_plan(summary, workoutType, profile, plan):
    plan_prompt = f"""
    You are a digital fitness coach. The individual below did not like their original training plan.
    Please generate an **alternative training plan** for them that:
    - Focuses on the same general goals
    - Modifies exercises or structure
    - Offers a slightly different style (e.g., swap cardio for strength intervals)
    
    ORIGINAL PLAN:
    {plan}
    PREFERRED WORKOUT:
    {workoutType}
    PROFILE:
    {profile}
    The training plan must:
    - Respect physical fatigue and injury risks
    - Leverage strengths (e.g., high endurance, hyper-focus)
    - Adapt difficulty to energy and motivation levels
    - Include rest or mobility if needed
    - Be structured as daily blocks
    -Take the workout type into consideration
    - **Specify exact exercises, poses, or movements (e.g., list yoga poses, cardio drills, strength exercises) instead of generic advice**
    - **Ensure each exercise/pose has a clear name (e.g., "Downward Dog", "Lunges") and optionally add short instructions if needed**
    
    Digital Twin State:
    {summary}

    Return output in JSON:
    {{
    "training_plan": {{
        "Warmup": "...",
        "Main workout": "...",
        "Additional advice": "..."
    }},
    "rationale": "Explain why this plan fits the current state of the individual and how it might be better than the previous one in 4 lines or less"
    }}
    """
    return plan_prompt

def call_openai(prompt, api_key):
    openai.api_key = api_key

    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are a knowledgeable digital twin interpreter"},
            {"role": "user", "content": prompt}
        ],
        temperature=0.7,
        max_tokens=1000
    )

    return response['choices'][0]['message']['content']

def dashboard_prompt(state, profile):
    prompt = f"""
    We are designing a digital twin system to model a human being, i.e. a Human Digital Twin. The system captures five categories of human state: mental, physical, cognitive, biomechanical, and interpersonal.

    You are an assistant summarizing a user's digital twin health and performance state for a mobile dashboard.

    The system captures five domains: mental, physical, cognitive, biomechanical, and interpersonal.

    Your task:
    - Provide a 1-line summary for each domain separately.
    - Generate an overall "Training Readiness Score" as a percentage (0% to 100%), based on the user's overall condition across all domains.
    - Think about factors like energy level, fatigue, motivation, focus, injury risk, balance, and social engagement when calculating readiness.

    Return a valid JSON object in the following format:

    {{
      "mental_summary": "...",
      "physical_summary": "...",
      "cognitive_summary": "...",
      "biomechanical_summary": "...",
      "interpersonal_summary": "...",
      "training_readiness_score": 85  # Example value
    }}

    PROFILE:
    {profile}

    STATE DATA:
    MENTAL: {state['mental']}
    PHYSICAL: {state['physical']}
    COGNITIVE: {state['cognitive']}
    BIOMECHANICAL: {state['biomechanical']}
    INTERPERSONAL: {state['interpersonal']}
    """
    return prompt

def get_summary(state, user_id,api_key):
    profile = get_user_profile(user_id)
    prompt = dashboard_prompt(state, profile)
    return call_openai(prompt, api_key)

def generate_state_summary(state, user_id, api_key):
    profile = get_user_profile(user_id)
    prompt = reasoning_prompt(state, profile)
    summary = call_openai(prompt, api_key)
    return {"summary":summary, "profile": profile}

def generate_training(summary, workoutType, profile, api_key):
    prompt = get_training_plan(summary, workoutType, profile)
    return call_openai(prompt, api_key)

def generate_alternate_training(summary, workoutType, profile, plan, api_key):
    prompt = get_alternate_plan(summary, workoutType, profile, plan)
    return call_openai(prompt, api_key)