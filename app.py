import os
from dotenv import load_dotenv
from src.utils import get_system_specs

def run_app():
    load_dotenv()
    app_name = os.getenv("APP_NAME", "Device Tool")
    
    print(f"--- {app_name} ---")
    specs = get_system_specs()
    
    for key, value in specs.items():
        print(f"{key}: {value}")

if __name__ == "__main__":
    run_app()