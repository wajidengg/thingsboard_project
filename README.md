# ThingsBoard Installation on AWS EC2 using Terraform

This project automates the deployment of a ThingsBoard server on an AWS EC2 instance using Terraform. It includes provisioning AWS resources such as an EC2 instance, a PostgreSQL RDS database, and security groups, along with installing and configuring ThingsBoard.

---

## Features

- Automates the deployment of ThingsBoard on Ubuntu EC2
- Provisions PostgreSQL RDS instance for ThingsBoard
- Configures Nginx as a reverse proxy for ThingsBoard
- Security group rules for SSH, HTTP, MQTT, CoAP, and ThingsBoard ports
- Easy-to-use Terraform scripts

---

## Prerequisites

1. **AWS Account**: Ensure you have access to an AWS account.
2. **Terraform**: Install Terraform on your machine. ([Download Terraform](https://www.terraform.io/downloads))
3. **AWS Credentials**: Configure your AWS CLI with proper credentials.
   ```bash
   aws configure
   ```
4. **Key Pair**: Ensure you have an AWS key pair for SSH access (e.g., `vockey.pem`).

---

## Installation Steps

### Step 1: Clone the Repository
Clone this repository to your local machine:
```bash
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>
```

---

### Step 2: Customize Variables
Update the `variables.tf` file with your values:
- `subnet_id`: Set the Subnet ID for your VPC.
- `db_password`: Provide a secure password for the PostgreSQL database.

Alternatively, pass these variables during the `terraform apply` command.

---

### Step 3: Initialize Terraform
Initialize Terraform to download required providers:
```bash
terraform init
```

---

### Step 4: Deploy the Infrastructure
Run the following command to deploy the infrastructure:
```bash
terraform apply
```

Provide any required variable values if prompted.

---

### Step 5: Access ThingsBoard
1. Once Terraform completes, it will output the ThingsBoard URL. Example:
   ```
   http://<public-ip>:8080
   ```
2. Open the URL in your browser to access the ThingsBoard UI.
3. Use the default login credentials:
   - **Username**: `sysadmin@thingsboard.org`
   - **Password**: `sysadmin`

---

## Security Group Ports

The following ports are opened in the security group:
- **22**: SSH
- **80**: HTTP (Nginx)
- **8080**: ThingsBoard UI
- **1883**: MQTT
- **5683**: CoAP

---

## Cleanup
To destroy the infrastructure, run:
```bash
terraform destroy
```

---

## Troubleshooting

- **SSH Connection Issues**: Ensure the correct key pair is used and the security group allows inbound SSH traffic on port 22.
- **ThingsBoard Access**: Verify the public IP is accessible and the security group allows inbound HTTP traffic on port 8080.

---

## License

This project is licensed under the [MIT License](LICENSE).

```