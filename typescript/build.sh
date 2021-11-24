#!/bin/bash

aws s3 cp s3://devflows-function-framework/typescript/setup.sh ./.devflows/setup.sh
chmod +x ./.devflows/setup.sh
./.devflows/setup.sh
docker build -f .devflows/Dockerfile -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} .
docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
