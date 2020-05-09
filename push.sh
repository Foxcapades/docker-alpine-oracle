#!/bin/bash

echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin
docker push ${IMAGE_NAME}:${TRAVIS_BRANCH}
docker push ${IMAGE_NAME}:latest