# Strapi CMS - Cloud Deployment with Infrastructure as Code

A headless CMS deployed on the cloud using Infrastructure as Code principles.

## 🌐 Live Demo

| Resource          | URL                                |
| ----------------- | ---------------------------------- |
| **Strapi Server** | https://your-url. railway.app      |
| **Admin Panel**   | https://your-url.railway.app/admin |
| **Database**      | PostgreSQL (Railway)               |

## 🏗️ Architecture

### Production Architecture (AWS - Terraform)

```
┌─────────────────────────────────────────────────────────────────┐
│                          AWS Cloud                               │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │                     VPC (10.0.0.0/16)                      │  │
│  │                                                            │  │
│  │  ┌─────────────────────┐    ┌─────────────────────┐       │  │
│  │  │   Public Subnet 1    │    │   Public Subnet 2    │       │  │
│  │  │                      │    │                      │       │  │
│  │  │  ┌────────────────┐  │    │                      │       │  │
│  │  │  │      ALB       │  │    │                      │       │  │
│  │  │  └───────┬────────┘  │    │                      │       │  │
│  │  │          │           │    │                      │       │  │
│  │  │  ┌───────┴────────┐  │    │                      │       │  │
│  │  │  │  NAT Gateway   │  │    │                      │       │  │
│  │  │  └────────────────┘  │    │                      │       │  │
│  │  └─────────────────────┘    └─────────────────────┘       │  │
│  │                                                            │  │
│  │  ┌─────────────────────┐    ┌─────────────────────┐       │  │
│  │  │  Private Subnet 1   │    │  Private Subnet 2   │       │  │
│  │  │                      │    │                      │       │  │
│  │  │  ┌────────────────┐  │    │  ┌────────────────┐  │       │  │
│  │  │  │  ECS Fargate   │  │    │  │  ECS Fargate   │  │       │  │
│  │  │  │   (Strapi)     │  │    │  │   (Strapi)     │  │       │  │
│  │  │  └────────────────┘  │    │  └────────────────┘  │       │  │
│  │  │                      │    │                      │       │  │
│  │  │  ┌────────────────┐  │    │                      │       │  │
│  │  │  │ RDS PostgreSQL │  │    │                      │       │  │
│  │  │  └────────────────┘  │    │                      │       │  │
│  │  └─────────────────────┘    └─────────────────────┘       │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### Demo Deployment (Railway - Free Tier)

For cost-effective demonstration:

```
GitHub Repository
       │
       ▼
┌─────────────────┐      ┌─────────────────┐
│    Railway      │      │    Railway      │
│  (Strapi App)   │◄────►│  (PostgreSQL)   │
└─────────────────┘      └─────────────────┘
       │
       ▼
   Public URL
```

## 📁 Project Structure

```
├── terraform/                # AWS Infrastructure as Code
│   ├── main.tf              # Main configuration
│   ├── variables.tf         # Input variables
│   ├── outputs.tf           # Output values
│   ├── providers.tf         # AWS provider config
│   ├── vpc.tf               # Network configuration
│   ├── security-groups.tf   # Firewall rules
│   ├── rds.tf               # PostgreSQL database
│   ├── ecs.tf               # Container service
│   ├── alb.tf               # Load balancer
│   ├── iam.tf               # Permissions
│   ├── ecr.tf               # Container registry
│   └── terraform.tfvars. example
│
├── config/                   # Strapi configuration
│   ├── admin. js
│   ├── database.js
│   ├── middlewares.js
│   ├── plugins.js
│   └── server.js
│
├── src/                      # Strapi source code
├── public/                   # Static files
├── Dockerfile               # Container definition
├── package.json             # Dependencies
└── README.md                # This file
```

## 🚀 Deployment Options

### Option 1: Railway (Free - Used for Demo)

```bash
# 1. Fork this repository
# 2. Connect to Railway
# 3. Add PostgreSQL database
# 4. Set environment variables
# 5. Deploy!
```

### Option 2: AWS with Terraform

```bash
cd terraform

# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Deploy infrastructure
terraform apply

# Build and push Docker image
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <ecr-url>
docker build -t strapi .
docker tag strapi:latest <ecr-url>:latest
docker push <ecr-url>:latest
```

## 🔧 Technologies Used

| Technology     | Purpose                 |
| -------------- | ----------------------- |
| **Strapi**     | Headless CMS            |
| **PostgreSQL** | Database                |
| **Docker**     | Containerization        |
| **Terraform**  | Infrastructure as Code  |
| **AWS ECS**    | Container orchestration |
| **AWS RDS**    | Managed database        |
| **AWS ALB**    | Load balancing          |
| **Railway**    | Demo deployment         |

## 💰 Cost Comparison

| Platform         | Monthly Cost   |
| ---------------- | -------------- |
| Railway (Demo)   | $0 (Free tier) |
| AWS (Production) | ~$80-120       |

## 📊 Terraform Resources

The Terraform configuration creates:

- **VPC** with public and private subnets
- **Internet Gateway** for public access
- **NAT Gateway** for private subnet internet access
- **Application Load Balancer** for traffic distribution
- **ECS Cluster** with Fargate tasks
- **RDS PostgreSQL** instance
- **ECR Repository** for Docker images
- **Security Groups** for network isolation
- **IAM Roles** for permissions

## 🔐 Security Features

- Database in private subnet (not internet accessible)
- ECS tasks in private subnet
- Security groups restrict traffic
- Encrypted storage (RDS, ECR)
- No hardcoded secrets in code

## 📹 Demo Video

[Link to screencast video]

## 👤 Author

Anurag Sharma

## 📄 License

MIT
