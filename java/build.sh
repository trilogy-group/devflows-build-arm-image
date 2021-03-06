#!/bin/bash

if test -f "gradlew"; then
    yum update && amazon-linux-extras install java-openjdk11 && yum install java-11-openjdk-devel -y
    ./gradlew clean assemble
    mkdir -p ./lambda/build/extensions
    cp ../logs-extension-arm64 ./lambda/build/extensions/logs-extension
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} -f ../Dockerfile.java.gradlew.arm64 lambda
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
elif test -f "devhub/Dockerfile"; then
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} -f devhub/Dockerfile .
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
else        
    cp ../${RUNTIME_GITOPS_REPOSITORY}/java/Dockerfile.arm64 ./Dockerfile
    cp ../${RUNTIME_GITOPS_REPOSITORY}/java/entry.sh ./entry.sh
    mvn compile dependency:copy-dependencies -DincludeScope=runtime -P lambda
    docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} .
    docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
fi
