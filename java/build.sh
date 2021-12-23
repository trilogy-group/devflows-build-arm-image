#!/bin/bash

if test -f "gradlew"; then
    yum update && amazon-linux-extras install java-openjdk11 && yum install java-11-openjdk-devel -y
    ./gradlew clean assemble
    cp ../logs-extension-arm64 ./lambda/build/extensions/logs-extension
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} -f lambda/src/main/docker/Dockerfile.lambda.arm64 lambda
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
elif test -f "devhub/Dockerfile"; then
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} -f devhub/Dockerfile .
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
else        
    cp ../${RUNTIME_GITOPS_REPOSITORY}/java/Dockerfile.arm64 ./Dockerfile
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} .
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
fi
