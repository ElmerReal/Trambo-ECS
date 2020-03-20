# Trambo-ECS
March 9, 2020

## Index
- [Instructions](#Instructions)
- [Folder Hierarchy](#Folder-Hierarchy)
- [Solution Explanation](#Solution-Explanation)

## Instructions

Excercise 2 (Provide resources needed by ECS using cloudformation):
- Create a nginx image using a custom html page.
- Create an ECR repository and push the nginx image previously created
- Create an ECS Cluster
- Create an application load balancer to receive the http trafic to ngnix container.
- Create a task definition using ngninx container pushed to ECR repository.
- Create an ECS Service to use the task definition previously created and public the container throughth de Application Load Balancer.

## Folder Hierarchy

```
./
│   README.md
│   principal.yml    
│
└───Network
│   |   loadbalancer.yml
│   |   network.yml
|   |   README.md
|   
└───Roles
│   │   roles.yml
│   │   README.md
|   
└───Imagen
    │   Dockerfile
    |   README.md
    |
    └───page
        │   index.html 
```

## Solution Explanation
The main idea of the exercise its provide all the resources needed by the ECS Cluster in order to work properly via CloudFormation templates.

The templates used tho provide all the stack resources are separated by modules depending their kind and functionality.
1. [Network](/Network)
    In the nework.yml file were created all the resources needed for the VPC and the ECS cluster.
2. [Roles](/Role)
    In the file roles.yml were created all the policies and roles needed for the VPC, LoadBalancer, ECS cluster, ALB, etc.

The complete diagram is the following:
![alt text](/Pictures/Pic1.png)

# principal.yml
The file [principal](/principal.yml) is in charge of calls all the others templates and manage the parameters and outputs, works like a bridge because can take a ouptup of a specific template and send as input for another one. This file is structured as following:

- Description

    Is a string that describes the template
- Parameters

    This block indicates the parameters needed by the stack, in this case when the usera create the stack he also has to provide the values of this parameters.
    

        ```

        BucketS3: 
            Description: "URL del Bucket donde estaran almacenado los templates templates"
            Type: String
        EC2TYPE:
            Description: "Tipo EC2"
            Type: String
            Default: t2.micro
            AllowedValues: 
            - t2.micro
            - t2.medium
            - t2.large

        ```
- Resources

    This block indicates which resources will be used and calls another templates.

    - RolesStack

        In this case we just create some policies and roles that will use in the other stacks
        ```

        RolesStack: 
            Type: AWS::CloudFormation::Stack
            Properties: 
            TemplateURL:
                !Join
                - ""
                - - !Ref BucketS3
                    - "/Roles/roles.yml"

        
        ```

    - NetworkStack

        In this case we just create one object of the network template because we only need one VPC.
        ```

            NetworkStack: 
                Type: AWS::CloudFormation::Stack
                Properties: 
                TemplateURL: 
                    !Join
                    - ""
                    - - !Ref BucketS3
                        - "/Network/network.yml"
        
        ```

    - LoadBalancerStack

        This block creates all realted with application load balancer, autoscaling group and ecs cluster. Also this tempplate receive as parameter the id of some roles created in roles neested stack and also values related to the VPC.

        ```
            LoadBalancerStack: 
                Type: AWS::CloudFormation::Stack
                Properties: 
                TemplateURL: 
                    !Join
                    - ""
                    - - !Ref BucketS3
                        - "/Network/loadbalancer.yml"
                Parameters:
                    RefSubnetPublica: !GetAtt NetworkStack.Outputs.RefSubnetPublic1
                    RefSG : !GetAtt NetworkStack.Outputs.RefSG
                    RefVPC : !GetAtt NetworkStack.Outputs.RefVPC
                    ParentStackName : !Ref AWS::StackName
                    EC2TYPE : !Ref EC2TYPE
                    Keyname : "Key"
                    ClusterPadre: !Ref AWS::StackName
                    AutoscalingRole: !GetAtt RolesStack.Outputs.AutoscalingRole
                    EC2Role: !GetAtt RolesStack.Outputs.EC2Role
                    ECSServiceRole: !GetAtt RolesStack.Outputs.ECSServiceRole

        ```