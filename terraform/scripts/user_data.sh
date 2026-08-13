#!/bin/bash

set -e

##############################################
# Update Packages
##############################################

apt update -y

##############################################
# Install Docker
##############################################

apt install -y docker.io

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

##############################################
# Install AWS CLI
##############################################

apt install -y unzip curl

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

./aws/install

##############################################
# Login to Amazon ECR (Retry until IAM credentials are available)
##############################################

REGION="ap-south-1"
ACCOUNT_ID="163265929593"
REPOSITORY="devops-cicd-project"

echo "Waiting for IAM credentials..."

for i in {1..30}; do

    if aws sts get-caller-identity >/dev/null 2>&1; then
        echo "IAM credentials available."
        break
    fi

    echo "IAM credentials not ready yet... Retrying in 10 seconds."
    sleep 10

done

echo "Logging into Amazon ECR..."

aws ecr get-login-password --region $REGION | \
docker login \
--username AWS \
--password-stdin \
${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

##############################################
# Pull Latest Image
##############################################

docker pull \
${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY}:latest

##############################################
# Run Container
##############################################

docker run -d \
--name flask-app \
--restart unless-stopped \
-p 80:5000 \
${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY}:latest