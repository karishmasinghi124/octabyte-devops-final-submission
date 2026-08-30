# Real Screenshot Checklist

Replace/add real screenshots under `docs/screenshots/` before submitting.

- `01-terraform-apply.png`
- `02-vpc-subnets.png`
- `03-alb-targets.png`
- `04-rds.png`
- `05-ecr.png`
- `06-github-actions.png`
- `07-production-approval.png`
- `08-cloudwatch-infrastructure.png`
- `09-cloudwatch-application.png`
- `10-running-app.png`

## What each screenshot should demonstrate

**Terraform:** successful apply and outputs.

**VPC:** public/private subnet layout.

**ALB:** target group has healthy EC2 targets.

**RDS:** PostgreSQL is available and not publicly accessible.

**ECR:** image with commit tag exists.

**GitHub Actions:** tests, scan, build, push and deployment succeeded.

**Production approval:** protected environment waiting for or receiving reviewer approval.

**CloudWatch:** infrastructure dashboard and application dashboard.

**Running app:** ALB URL returning the sample application response.
