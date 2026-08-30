# Architecture Decisions

## Flow
Internet → ALB → private EC2 → RDS PostgreSQL.

## Network
The VPC spans two Availability Zones. Public subnets contain the ALB. Private application subnets contain EC2 instances. Private database subnets contain RDS.

## Compute
EC2 + Docker keeps the assignment implementation straightforward while demonstrating networking, IAM, load balancing and deployment.

## Database
RDS PostgreSQL provides managed database operations and automated backups.

## Secrets
Terraform generates a strong database password and stores it in Secrets Manager.

## CI/CD
Pull requests run tests and security checks. Main builds and scans the container, pushes to ECR, deploys staging, and then waits for protected production approval.

## Observability
CloudWatch collects infrastructure, ALB and RDS metrics plus centralized system/application logs.

## Production improvements
Add HTTPS with ACM, WAF, autoscaling policies, VPC endpoints, stronger least-privilege IAM, blue/green deployment, multi-NAT for resilience, and more granular alarms.
