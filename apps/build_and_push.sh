#!/bin/bash
set -e

REGISTRY=skaylinkgmbh

function push_image () {
  cd ${FOLDER}
  docker build -t ${IMAGE_NAME} .
  docker tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
  docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
  cd ..
}

IMAGE_NAME="ix-multicloud-demo-petra"
IMAGE_VERSION=latest
FOLDER=petra
push_image

IMAGE_NAME="ix-multicloud-demo-klaus"
IMAGE_VERSION=latest
FOLDER=klaus
push_image
