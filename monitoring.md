# Monitoring

## Dashboard 1 – Infrastructure
Use EC2 CPU, memory, disk, RDS CPU, RDS connections and RDS free storage.

## Dashboard 2 – Application
Use ALB request count, ALB 4xx/5xx, target response time and healthy/unhealthy targets.

## Recommended alarms
- ALB 5xx above threshold
- Target response time above threshold
- EC2 CPU above 80%
- RDS CPU above 80%
- RDS free storage below threshold
- Unhealthy targets greater than zero

`cloudwatch-dashboard.json` is a starter dashboard definition; actual AWS resource dimensions should be filled with outputs from the deployed environment.
