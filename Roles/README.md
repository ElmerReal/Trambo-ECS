# Roles/roles.yml
The file  [roles](/Roles/roles.yml) is the template which creates all the policies and roles needed by the VPC and ECS cluster.

The roles created are:
- AutoscalingRole
- EC2Role
- ECSServiceRole

The policies created are:
- AutoscalingPolicy
- EC2Policy
- ECSPolicy

This template expose as Output the followings ids:
- AutoscalingRole
- EC2Role
- ECSServiceRole