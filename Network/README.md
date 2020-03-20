# Network/network.yml
The file  [network](/Network/network.yml) is the template which creates all the resources needed by the VPC.

The complete diagram is the following:
![alt text](/Pictures/CloudFormation1.png)

## RouteTable publica

Destino  | Target
------------- | -------------
10.0.0.0/16  | local
0.0.0.0/0  | Internet Gatway

## RouteTable privada

Destino  | Target
------------- | -------------
10.0.0.0/16  | local

## Subnets

CIDR  | Nombre | Tipo
------------- | ------------- | -------------
10.0.0.0/24  | SN-Elmer-Public-1 | publica
10.0.1.0/24  | SN-Elmer-Public-2 | publica
10.0.2.0/24  | SN-Elmer-Public-3 | publica
10.0.3.0/24  | SN-Elmer-Private-1 | privada
10.0.4.0/24  | SN-Elmer-Private-2 | privada
10.0.5.0/24  | SN-Elmer-Private-3 | privada

# Network/loadbalancer.yml
The file  [loadbalancer](/Network/loadbalanceer.yml) is the template which creates all the resources needed by the ECS Cluster and the Application Load Balancer.

The resources created are:

Nombre | Tipo
------------- | -------------
ECSCluster | AWS::ECS::Cluster
taskdefinition |  AWS::ECS::TaskDefinition
service | AWS::ECS::Service
ServiceScalingTarget | AWS::ApplicationAutoScaling::ScalableTarget
ECSALB | AWS::ElasticLoadBalancingV2::LoadBalancer
ALBListener | AWS::ElasticLoadBalancingV2::Listener
ECSALBListenerRule | AWS::ElasticLoadBalancingV2::ListenerRule
ECSTG | AWS::ElasticLoadBalancingV2::TargetGroup
ECSAutoScalingGroup | AWS::AutoScaling::AutoScalingGroup
LaunchConf | AWS::AutoScaling::LaunchConfiguration
EC2InstanceProfile | AWS::IAM::InstanceProfile