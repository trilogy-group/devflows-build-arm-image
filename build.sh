#!/bin/bash

FRAMEWORK="$(bash framework-resolver.sh)"
echo Framework ${FRAMEWORK}

if [ "${FRAMEWORK}" = "unknown" ]; then
    echo "Could not resolve framework. Skipping build."
    exit 1
fi

echo Creating ECR Repository ${ECR_REPOSITORY}
aws --region ${AWS_REGION} ecr create-repository --repository-name ${ECR_REPOSITORY} 2>/dev/null || echo Repository already exists!!

export IMAGE_TAG="${IMAGE_TAG}-arm64"

echo "Starting ARM build for repo: ${GITHUB_REPOSITORY}, framework: ${FRAMEWORK}"
cp ${FRAMEWORK}/build.sh ${GITHUB_REPOSITORY}/build.sh
cd ${GITHUB_REPOSITORY}
bash build.sh
