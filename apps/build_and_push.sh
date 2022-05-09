REGISTRY=skaylinkgmbh
IMAGE_NAME=ix-multicloud-demo-petra
IMAGE_VERSION=latest
FOLDER=petra
cd ${FOLDER}
docker build -t ${IMAGE_NAME} .
docker tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
cd ..


REGISTRY=skaylinkgmbh
IMAGE_NAME=ix-multicloud-demo-klaus
IMAGE_VERSION=latest
FOLDER=klaus
cd ${FOLDER}
docker build -t ${IMAGE_NAME} .
docker tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
cd ..
