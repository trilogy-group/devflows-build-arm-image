#!/bin/bash

if test -f "devhub/Dockerfile"; then
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} -f devhub/Dockerfile .
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
else        
    cp ../${RUNTIME_GITOPS_REPOSITORY}/java/Dockerfile.arm64 ./Dockerfile
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} .
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
fi
