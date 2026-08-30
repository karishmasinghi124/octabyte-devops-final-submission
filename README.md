# Octa Byte AI – DevOps Assignment Submission

## Submission checklist

| Requirement | Included |
|---|---|
| GitHub-ready repository with all code/configuration | Yes |
| Approach documentation | This README |
| Challenges document in PDF | `CHALLENGES.pdf` |
| Architecture documentation | `ARCHITECTURE.md` |
| CI/CD | `.github/workflows/` |
| Infrastructure as Code | `terraform/` |
| Docker | `app/Dockerfile` + `docker-compose.yml` |
| Monitoring/logging | `terraform/monitoring.tf`, `monitoring/` |
| Security/secrets | `terraform/security.tf`, `terraform/iam.tf`, Secrets Manager |
| Backup strategy | RDS automated backups |
| Visual evidence | `docs/architecture-overview.svg`, `docs/deployment-evidence.png` |
| Real AWS screenshots | Must be captured after deployment |
| Loom video | Must be recorded after deployment |

## 1. Architecture

Internet → public Application Load Balancer → private EC2 Docker instances → private RDS PostgreSQL.

Terraform creates a VPC with public/private subnets across two Availability Zones, security groups, EC2 Auto Scaling, ALB, ECR, RDS PostgreSQL, CloudWatch logging, and Secrets Manager.

## 2. Local execution

```bash
docker compose up --build
curl http://localhost:3000/health
```

Expected response:

```json
{"status":"healthy"}
```

## 3. AWS provisioning

Use AWS credentials with permission to create the resources in `terraform/`.

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply
```

For proper state management, configure the S3 backend and DynamoDB locking in `versions.tf` before applying in a shared environment.

After deployment:

```bash
terraform output load_balancer_dns
```

Open the resulting ALB DNS name in a browser.

## 4. CI/CD

### Pull requests
`.github/workflows/pr-tests.yml`:
- installs dependencies
- runs unit tests
- runs npm dependency audit
- scans the repository with Trivy

### Main branch
`.github/workflows/deploy.yml`:
1. Builds Docker image.
2. Scans the image with Trivy.
3. Pushes the image to ECR.
4. Deploys staging through AWS Systems Manager.
5. Deploys production only after approval through the protected `production` GitHub Environment.

Configure GitHub:
- Variable: `AWS_REGION`
- Variable: `ECR_REPOSITORY`
- Variable: `STAGING_INSTANCE_ID`
- Variable: `PRODUCTION_INSTANCE_ID`
- Secret: `AWS_ROLE_TO_ASSUME`

Configure the `production` environment with required reviewers.

## 5. Monitoring and logging

CloudWatch configuration covers:
- EC2 CPU
- EC2 memory
- EC2 disk
- ALB request rate
- ALB 4xx/5xx
- ALB target response time
- healthy/unhealthy targets
- RDS CPU
- RDS connections
- RDS storage

Application/system logs are sent to CloudWatch log groups.

Two dashboard definitions are supplied in `monitoring/`. Replace the example dimensions with the actual ALB/ASG/RDS dimensions after deployment.

## 6. Security

- ALB is internet-facing.
- Application instances are private.
- RDS is private.
- RDS port 5432 is allowed only from the application security group.
- Database credentials are generated and stored in AWS Secrets Manager.
- EC2 uses an IAM instance profile.
- EBS and RDS storage are encrypted.
- GitHub Actions is designed around OIDC rather than long-lived AWS credentials.
- Production deployment is protected by environment approval.

## 7. Backup and cost optimization

RDS has automated backups enabled with seven-day retention.

For assignment cost control:
- `t3.micro` EC2 instances
- small RDS instance
- one NAT gateway
- limited CloudWatch log retention
- two application instances only

Destroy the environment after evaluation if it is no longer required:

```bash
terraform destroy
```

## 8. Screenshots and Loom

The repository includes a screenshot checklist in `docs/screenshots.md`.

For the final submission, capture real screenshots from:
1. Terraform apply
2. AWS VPC/subnets
3. ALB and healthy targets
4. RDS
5. ECR
6. GitHub Actions successful run
7. production approval
8. CloudWatch infrastructure dashboard
9. CloudWatch application dashboard
10. running application

Record a short Loom video showing the repository, Terraform architecture, CI/CD run, AWS resources, monitoring, and the running application.

The repository cannot create a real GitHub URL or Loom URL without access to those accounts, so those two links must be added to the submission email after publishing/recording.
