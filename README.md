# Zendesk Ticket Mapper - AWS Fargate 

## These are the terraform files required for creating a Fargate ECS Task Definition for Zendesk Ticket Mapper.

## In addition to the Task Definition, this creates an Aurora RDS cluster for Zendesk Ticket Mapper

### Prerequisites

You'll need to make sure that the VPC where the Aurora RDS Cluster resides, can be accessible by the VPC where you're running the Fargate ECS Task.


Make sure you change the `acc_number` with the correct AWS Account number and `env` with the correct environment. In this case, prod.

### Other variables

The `variables.tf` file contains data that also has to be modified according to the correct VPC and subnets, along with setting up the correct ECS Cluster where the ZTM Task Definition to run.

These settings allow the ZTM ECS Task to be run as a service right after deployment.

# Running Teraform  

In the /tf directory, run:

```terraform init```

```terraform plan```

If Terraform completes this dry run successfully,  you can apply these changes with:

```terraform apply``` 

When asked for input, type ```yes```
