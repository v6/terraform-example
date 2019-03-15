Notes:

backend.tf needs to point to the correct bucket
'Terraform init' must be run to initialize the back end first, then a plan, and apply can be performed

Steps:
cd author
terraform init
terraform plan --var-file=../../datafiles/stage.tfvars
echo "yes" | terraform apply --var-file=../../datafiles/stage.tfvars
echo "yes" | terraform destroy --var-file=../../datafiles/stage.tfvars
cd publish
terraform init
terraform plan --var-file=../../datafiles/stage.tfvars
echo "yes" | terraform apply --var-file=../../datafiles/stage.tfvars
echo "yes" | terraform destroy --var-file=../../datafiles/stage.tfvars
cd dispatch
terraform init
terraform plan --var-file=../../datafiles/stage.tfvars
echo "yes" | terraform apply --var-file=../../datafiles/stage.tfvars
echo "yes" | terraform destroy --var-file=../../datafiles/stage.tfvars
