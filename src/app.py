"""
Script: app.py
Description: This script is the main entry point for the FastAPI application.
"""

from typing import Dict

from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def health_check() -> Dict[str, str]:
    """
    Endpoint to check the health of the application.

    Returns
    -------
    Dict[str, str]
        A dictionary with the status of the application.
    """
    return {"status": "ok"}
