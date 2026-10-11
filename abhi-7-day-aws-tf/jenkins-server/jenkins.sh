#!/bin/bash

set -e

cd ~

sudo yum update -y

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/rpm-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key

sudo yum upgrade

sudo yum install java-21-amazon-corretto -y

sudo yum install jenkins -y

sudo systemctl enable jenkins

sudo systemctl start jenkins

echo "waiting for jenkins to initialize..."

sleep 15

sudo systemctl status jenkins

sleep 15

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo ip addr