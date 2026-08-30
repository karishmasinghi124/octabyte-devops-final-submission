data "aws_ssm_parameter" "al2023" {
  name="/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
resource "aws_launch_template" "app" {
  name_prefix="${var.project_name}-"
  image_id=var.ami_id != "" ? var.ami_id : data.aws_ssm_parameter.al2023.value
  instance_type=var.instance_type
  iam_instance_profile { name=aws_iam_instance_profile.ec2.name }
  vpc_security_group_ids=[aws_security_group.app.id]
  user_data=base64encode(templatefile("${path.module}/user_data.sh",{ecr_repository=aws_ecr_repository.app.repository_url,region=var.aws_region,app_port=var.app_port}))
  block_device_mapping { device_name="/dev/xvda"; ebs { volume_size=20; volume_type="gp3"; encrypted=true; delete_on_termination=true } }
}
resource "aws_autoscaling_group" "app" {
  min_size=2; max_size=2; desired_capacity=2
  vpc_zone_identifier=aws_subnet.private_app[*].id
  target_group_arns=[aws_lb_target_group.app.arn]; health_check_type="ELB"
  launch_template { id=aws_launch_template.app.id; version="$Latest" }
}
