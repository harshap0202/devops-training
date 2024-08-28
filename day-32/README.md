# Deploying a Multi-Tier Web Application Using Amazon ECS

## Project Requirements:
 - **ECS Cluster:** Create an ECS Cluster using Fargate.
 - **Task Definitions:** Define task definitions for web services.
 - **Services:** Create ECS services for each tier without using a Load Balancer or API Gateway.
 - **Security Groups:** Configure security groups to allow traffic between services directly.
 - **IAM Roles:** Create and assign IAM roles for ECS tasks.
 - **VPC and Networking:** Create a VPC with public and private subnets, ensuring proper routing of traffic without a NAT gateway.
 - **Secrets Management:** Use AWS Secrets Manager or SSM Parameter Store to manage database credentials.
 - **Scaling:** Implement auto-scaling policies for the ECS services.

## Project Deliverables:

### ECS Cluster Setup
Create an ECS cluster using the Fargate launch type.
Ensure the cluster is running in a VPC with public and private subnets.

![alt text](<img/Screenshot from 2024-08-28 21-08-29.png>)

### Task Definitions
Create task definitions:

![alt text](<img/Screenshot from 2024-08-28 21-06-36.png>)

### RDS Instance Setup
Launch an RDS instance using the free tier template with MySQL.

![alt text](<img/Screenshot from 2024-08-28 20-53-01.png>)

### ECS Services Setup
Deploy the frontend services using ECS.

![alt text](<img/Screenshot from 2024-08-28 20-53-26.png>)


### Networking and Security
Set up VPC with public subnets for the frontend service and RDS.

![alt text](<img/Screenshot from 2024-08-28 21-10-27.png>)

### IAM Roles 
Create and assign IAM roles for ECS tasks.

![alt text](<img/Screenshot from 2024-08-28 21-15-34.png>)

### Scaling and Monitoring
Implement auto-scaling policies based on CPU and memory usage for both services.
Set up CloudWatch alarms to monitor service performance and trigger scaling events.

![alt text](<img/Screenshot from 2024-08-28 21-16-53.png>)

### Deployment and Validation
Deploy the multi-tier web application using the ECS services.

 - `terraform init`
![alt text](<img/Screenshot from 2024-08-28 20-21-31.png>) 

 - `terraform plan`
![alt text](<img/Screenshot from 2024-08-28 20-22-18.png>) 

 - `terraform apply`
![alt text](<img/Screenshot from 2024-08-28 20-26-44.png>)

### Resource Cleanup
Once the deployment is validated, ensure that all AWS resources are properly terminated:
Stop and delete ECS tasks and services.
Delete the ECS cluster.
Terminate the RDS instance.
Clean up any associated S3 buckets, IAM roles, and security groups.

 - `terraform destroy`
![alt text](<img/Screenshot from 2024-08-28 21-20-20.png>) 
![alt text](<img/Screenshot from 2024-08-28 21-38-12.png>)