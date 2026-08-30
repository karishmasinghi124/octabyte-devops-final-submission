#!/bin/bash
set -eux
dnf update -y
dnf install -y docker amazon-cloudwatch-agent
systemctl enable --now docker
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${ecr_repository}
docker pull ${ecr_repository}:latest || true
cat >/etc/systemd/system/octabyte-app.service <<'UNIT'
[Unit]
After=docker.service
Requires=docker.service
[Service]
Restart=always
ExecStart=/usr/bin/docker run --rm --name octabyte-app -p ${app_port}:${app_port} -e PORT=${app_port} ${ecr_repository}:latest
ExecStop=/usr/bin/docker stop octabyte-app
[Install]
WantedBy=multi-user.target
UNIT
systemctl daemon-reload
systemctl enable --now octabyte-app.service
cat >/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'JSON'
{"logs":{"logs_collected":{"files":{"collect_list":[{"file_path":"/var/log/messages","log_group_name":"/octabyte/system","log_stream_name":"{instance_id}"}]}}},"metrics":{"metrics_collected":{"mem":{"measurement":["mem_used_percent"]},"disk":{"measurement":["used_percent"],"resources":["*"]}}}}
JSON
systemctl enable --now amazon-cloudwatch-agent
