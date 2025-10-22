"""
Module: test_app.py
Description: This module contains the tests for the app module.
"""

from fastapi.testclient import TestClient
from src.app import app

client = TestClient(app)

def test_health_check():
    """
    Test the health_check endpoint.
    """
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}

