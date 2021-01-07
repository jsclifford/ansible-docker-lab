#!/bin/bash

DockerHubRepo="joshcliffordextend"
ImageName="centos-ansible"
DockerFile="dockerfile"

while getopts r:i:f: flag
do
    case "${flag}" in
        r) DockerHubRepo=${OPTARG};;
        i) ImageName=${OPTARG};;
        f) DockerFile=${OPTARG};;
    esac
done


# Script to create and push docker image. Also script to deploy log analytics workspace to Azure Dashboard
ScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Building docker image joshcliffordextend/centos-ansible"
docker build -t $DockerHubRepo/$ImageName -f "$ScriptDir/$DockerFile" "$ScriptDir"

echo ""
echo ""
echo ""
read -p "Do you want to push the image to Docker Hub?[y|n]" pushImage
if [[ $pushImage = 'y' ]]; then
    echo "Pushing docker image to Docker Hub"
    docker push $DockerHubRepo/$ImageName
fi
