#!/bin/bash

cp ../${RUNTIME_GITOPS_REPOSITORY}/typescript-eng/Dockerfile.arm64 ./Dockerfile
# Install dependencies
npm run ci-all || npm ci
# Build
npm run build

echo "DF_FUNCTIONS_VERSION=${IMAGE_TAG}" >> ./.devflows/.env
docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} .
docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
