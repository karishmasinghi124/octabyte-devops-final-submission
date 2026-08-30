# Challenges and Resolutions

## 1. Keeping application servers private
**Challenge:** application servers should not be directly reachable from the public internet.

**Resolution:** place EC2 instances in private subnets and expose them through an internet-facing Application Load Balancer.

## 2. Protecting PostgreSQL
**Challenge:** the database should not be publicly accessible.

**Resolution:** deploy RDS in private database subnets and allow TCP/5432 only from the application security group.

## 3. Managing secrets
**Challenge:** database credentials must not be committed to Git.

**Resolution:** generate the password through Terraform and store it in AWS Secrets Manager.

## 4. Safe production deployment
**Challenge:** a merge to main should not immediately release to production.

**Resolution:** the GitHub Actions production job targets a protected GitHub Environment with required reviewers.

## 5. Container/dependency security
**Challenge:** vulnerable dependencies or container packages can enter the release.

**Resolution:** run npm audit and Trivy scans in CI before deployment.

## 6. Centralized observability
**Challenge:** infrastructure and application behavior needs a central place for troubleshooting.

**Resolution:** configure CloudWatch metrics and log groups, with dashboards covering infrastructure and application-facing signals.

## 7. Terraform state
**Challenge:** local Terraform state is unsafe for a team.

**Resolution:** the repository includes an S3 backend template with DynamoDB locking instructions. A real deployment should configure the organization-owned state bucket/table before apply.
