Notes:

backend.tf needs to point to the correct bucket
'Terraform init' must be run to initialize the back end first, then a plan, and apply can be performed

Steps:
cd 0-setup
terraform init
terraform plan --var-file=../datafiles/setup.tfvars
echo "yes" | terraform apply --var-file=../datafiles/setup.tfvars
echo "yes" | terraform destroy --var-file=../datafiles/setup.tfvars

Description:
Creates the core Client environment objects. This includes:
- Resource Group
- Network
- Storage Account (for files, and state files)
- Security Groups
