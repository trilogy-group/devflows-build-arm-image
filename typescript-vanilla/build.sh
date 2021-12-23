#!/bin/bash

# Install dependencies
npm run ci-all | npm ci
# Build
npm run build

docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} -f devflows/Dockerfile .
docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
