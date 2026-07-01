#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# FIXED: Removed spaces around the '=' sign
IMG_NAME="avenger_logo.jpeg"
BUCKET_NAME="ultron-s3-us-east-1-gp-bucket"
TF_BUCKET_NAME="ultron-s3-poc-hands-on"

# Fetch instance ID (Note: If IMDSv2 is strictly enforced on your EC2, this curl might require a token)
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Copy from source bucket to your TF bucket
aws s3 cp s3://$BUCKET_NAME/$IMG_NAME s3://$TF_BUCKET_NAME/$IMG_NAME

# Download directly from your provisioned bucket to the web directory
aws s3 cp s3://$TF_BUCKET_NAME/$IMG_NAME /var/www/html/$IMG_NAME

# FIXED: Corrected typos, variables, and properly formatted the HTML block
cat <<EOF > /var/www/html/index.html
<h1>Hello World from $(hostname -f)</h1>
<h2>Instance ID: $INSTANCE_ID</h2>
<img src="$IMG_NAME" alt="avenger_logo" style="max-width:100%; height:auto;">
EOF