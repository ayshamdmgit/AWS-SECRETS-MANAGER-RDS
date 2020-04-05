AWS Secrets Manager RDS Setup


We are going to going through the basic hierarchy of setting up the relevant codes for enabling password management for AWS RDS

This github will guide in creating the below resources - 
1. Set up RDS via Terraform
2. Set up Lambda for password rotation and accessing Secrets Manager via Terraform
3. Lambda to rotate the password automatically (Python Code)
4. Lambda to access the password from Secrets Manager (Python Code)
