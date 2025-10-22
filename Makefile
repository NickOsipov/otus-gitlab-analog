include .env

build:
	docker build -t fastapi-app .

push:
	docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_TOKEN}
	docker tag fastapi-app ${DOCKER_HUB_USER}/fastapi-app
	docker push ${DOCKER_HUB_USER}/fastapi-app

run:
	docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_TOKEN}
	docker pull ${DOCKER_HUB_USER}/fastapi-app
	docker stop fastapi-app || true
	docker rm fastapi-app || true
	docker run -p 8080:8080 ${DOCKER_HUB_USER}/fastapi-app

test:
	pytest --cov=src tests

test-in-docker:
	docker run --rm ${DOCKER_HUB_USER}/fastapi-app make test

stop:
	docker stop fastapi-app || true
	docker rm fastapi-app || true