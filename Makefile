include .env

IMAGE_NAME = fastapi-app
CONTAINER_NAME = fastapi-app

build:
	docker build -t $(IMAGE_NAME) .

push:
	docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_TOKEN}
	docker tag $(IMAGE_NAME) ${DOCKER_HUB_USER}/$(IMAGE_NAME)
	docker push ${DOCKER_HUB_USER}/$(IMAGE_NAME)

run:
	docker pull ${DOCKER_HUB_USER}/$(IMAGE_NAME)
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true
	docker run -d --name $(CONTAINER_NAME) -p 8080:8080 ${DOCKER_HUB_USER}/$(IMAGE_NAME)

deploy:
	scp -r .env Makefile ${SSH_USER}@${DEPLOY_HOST}:${DEPLOY_PATH}
	ssh ${SSH_USER}@${DEPLOY_HOST} "cd ${DEPLOY_PATH} && make run"

test:
	pytest --cov=src tests

test-in-docker:
	docker run --rm ${DOCKER_HUB_USER}/$(IMAGE_NAME) pytest --cov=src tests

stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true