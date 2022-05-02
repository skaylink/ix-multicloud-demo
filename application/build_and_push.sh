REGISTRY=skaylinkgmbh
IMAGE_NAME=ix-multicloud-demo-alice
IMAGE_VERSION=latest
FOLDER=alice
cd ${FOLDER}
docker build -t ${IMAGE_NAME} .
docker tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
cd ..


REGISTRY=skaylinkgmbh
IMAGE_NAME=ix-multicloud-demo-bob
IMAGE_VERSION=latest
FOLDER=bob
cd ${FOLDER}
docker build -t ${IMAGE_NAME} .
docker tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
cd ..
