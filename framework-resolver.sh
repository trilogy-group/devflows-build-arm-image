#!/bin/bash

framework="unknown"

# typescript OR typescript-eng
does_ts_config_exist="$(test -e ${GITHUB_REPOSITORY}/tsconfig.json && echo yes || echo no)"
if [ "${does_ts_config_exist}" = "yes" ]; then
    framework="typescript"
    is_eng_framework="$(test -e ${GITHUB_REPOSITORY}/devflows-app && echo yes || echo no)"
    if [ "${is_eng_framework}" = "yes" ]; then
        framework="typescript-eng"
    fi
    echo ${framework}
    exit 0
fi

# python
is_python_framework="$(test -e ${GITHUB_REPOSITORY}/requirements.txt && echo yes || echo no)"
if [ "${is_python_framework}" = "yes" ]; then
    echo "python"
    exit 0
fi

# Java
is_java_framework="$(test -e ${GITHUB_REPOSITORY}/pom.xml || test -e ${GITHUB_REPOSITORY}/gradlew && echo yes || echo no)"
if [ "${is_java_framework}" = "yes" ]; then
    echo "java"
    exit 0
fi

echo ${framework}
