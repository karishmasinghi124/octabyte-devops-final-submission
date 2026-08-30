resource "aws_cloudwatch_log_group" "app" { name="/octabyte/application"; retention_in_days=7 }
resource "aws_cloudwatch_log_group" "system" { name="/octabyte/system"; retention_in_days=7 }
