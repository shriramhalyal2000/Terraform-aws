!/bin/bash
# Prevent interactive prompts from blocking the script
export DEBIAN_FRONTEND=noninteractive

# 1. Update packages and install Apache + AWS CLI
apt-get update -y
apt-get install -y apache2 awscli

# 2. Start and enable Apache immediately to ensure directories exist
systemctl start apache2
systemctl enable apache2

# 3. Get the instance ID securely using IMDSv2 (Token-based)
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# 4. (Optional) Download the images from S3 bucket
# Uncomment the line below if your EC2 instance profile has proper S3 IAM permissions
 aws s3 cp s3://myterraformprojectbucket2023/project.webp /var/www/html/project.png

# 5. Create the portfolio HTML file dynamically inserting the Instance ID
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  <style>
    /* Add animation and styling for the text */
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
    body {
      font-family: Arial, sans-serif;
      margin: 40px;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 1</h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Welcome to Shriram Halyal tf task</p>
</body>
</html>
EOF
# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2