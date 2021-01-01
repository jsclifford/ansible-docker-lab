[CmdletBinding()]
param (
    $DockerHubRepo = "joshcliffordextend",
    $ImageName = "centos-ansible",
    $DockerFile = "dockerfile"
)

# Script to create and push docker image. Also script to deploy log analytics workspace to Azure Dashboard
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path

try {
    echo "Checking to see if docker is installed."
    docker-compose --version
}
catch {
    echo "Docker is not installed or running. Please install docker and docker-compose or start docker."
    exit
}

$dockerIsUp = docker ps 2>&1
if($dockerIsUp -like '*error during connect*'){
    echo "Docker is stopped.  Please start docker daemon."
    exit
}

echo "Building docker image joshcliffordextend/centos-ansible"
docker build -t $DockerHubRepo/$ImageName -f "$ScriptDir/$DockerFile" "$ScriptDir"

echo ""
echo ""
echo ""
echo "Do you want to push the image to Docker Hub?[y|n]"
$pushImage = Read-Host
if($pushImage -eq 'y'){
    echo "Pushing docker image to Docker Hub"
    docker push $DockerHubRepo/$ImageName
}
