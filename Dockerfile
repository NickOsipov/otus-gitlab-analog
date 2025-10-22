FROM python:3.11.4-slim-bookworm

ENV APP_HOME=/app
WORKDIR $APP_HOME

RUN apt-get update && apt-get install -y make

COPY requirements requirements

RUN pip install --no-cache-dir -r requirements/requirements.txt
RUN pip install --no-cache-dir -r requirements/requirements-test.txt

COPY src src
COPY tests tests

ENV PYTHONPATH=$APP_HOME

CMD ["uvicorn", "src.app:app", "--host", "0.0.0.0", "--port", "8080"]