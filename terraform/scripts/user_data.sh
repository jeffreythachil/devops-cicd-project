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
# Install AWS CLI
############################################

apt-get install -y awscli

############################################
# Install SSM Agent if not already present
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
# Finish
############################################

echo "EC2 bootstrap completed."