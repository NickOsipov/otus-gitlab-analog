#!/bin/bash

# Скрипт для создания .env файла из переменных окружения

: > .env

# Добавляем переменные только если они установлены
[ -n "$DOCKER_HUB_USER" ] && echo "DOCKER_HUB_USER=${DOCKER_HUB_USER}" >> .env
[ -n "$DOCKER_HUB_TOKEN" ] && echo "DOCKER_HUB_TOKEN=${DOCKER_HUB_TOKEN}" >> .env
[ -n "$SSH_USER" ] && echo "SSH_USER=${SSH_USER}" >> .env
[ -n "$DEPLOY_HOST" ] && echo "DEPLOY_HOST=${DEPLOY_HOST}" >> .env
[ -n "$DEPLOY_PATH" ] && echo "DEPLOY_PATH=${DEPLOY_PATH}" >> .env

echo ".env file created successfully"

