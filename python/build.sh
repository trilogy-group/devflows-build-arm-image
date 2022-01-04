#!/bin/bash

if test -f 'manage.py'; then
    echo "Django Framework"
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} -f ../Dockerfile.django .
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
elif test -f "main.py"; then 
    echo "FastAPI Framework"
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} -f ../Dockerfile.fastapi .
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
else
    cp ../${RUNTIME_GITOPS_REPOSITORY}/python/Dockerfile.arm64 ./Dockerfile
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} .
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
fi