#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

echo "Starting EC2 bootstrap..."

############################################
# Update packages
############################################

apt-get update -y

############################################
# Install Docker
############################################

apt-get install -y docker.io

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

############################################
# Install AWS CLI v2 and curl
############################################

apt-get install -y curl unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
  -o "/tmp/awscliv2.zip"

unzip -q /tmp/awscliv2.zip -d /tmp

/tmp/aws/install

rm -rf /tmp/aws /tmp/awscliv2.zip

############################################
# Install SSM Agent
############################################

if ! systemctl list-unit-files | grep -q amazon-ssm-agent; then
    snap install amazon-ssm-agent --classic
fi

systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service || true
systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service || true

############################################
# Create application directory
############################################

mkdir -p /opt/devops

chown ubuntu:ubuntu /opt/devops

############################################
# Bootstrap complete
############################################

echo "EC2 bootstrap completed successfully."