#!/bin/bash

cp ../${RUNTIME_GITOPS_REPOSITORY}/typescript-eng/Dockerfile.arm64 ./Dockerfile
npm config set @trilogy-group:registry https://npm.pkg.github.com/
npm config set //npm.pkg.github.com/:_authToken ${GITHUB_TOKEN}
# Install dependencies
npm run ci-all || npm ci
# Build
npm run build

echo "DF_FUNCTIONS_VERSION=${IMAGE_TAG}" >> ./.devflows/.env
docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} .
docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
