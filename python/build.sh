#!/bin/bash

cp ../${RUNTIME_GITOPS_REPOSITORY}/typescript/Dockerfile.arm64 ./Dockerfile
docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} .
docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
