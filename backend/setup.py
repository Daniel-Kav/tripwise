import os
import subprocess
import sys
from pathlib import Path

def run_command(command):
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {command}")
        print(f"Error: {e}")
        sys.exit(1)

def main():
    # Create virtual environment
    if not os.path.exists("venv"):
        print("Creating virtual environment...")
        run_command("python -m venv venv")
    
    # Activate virtual environment and install requirements
    if sys.platform == "win32":
        activate_cmd = "venv\\Scripts\\activate"
    else:
        activate_cmd = "source venv/bin/activate"
    
    print("Installing requirements...")
    run_command(f"{activate_cmd} && pip install -r requirements.txt")
    
    # Create Django project
    print("Creating Django project...")
    run_command(f"{activate_cmd} && django-admin startproject tripwise .")
    
    # Create apps
    apps = ["api", "core", "trips", "eld"]
    for app in apps:
        print(f"Creating {app} app...")
        run_command(f"{activate_cmd} && python manage.py startapp {app}")
    
    print("Setup completed successfully!")

if __name__ == "__main__":
    main() 