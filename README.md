Refer to https://github.com/terraform-providers for more providers/plugins

To enable Debug
$env:TF_LOG = "DEBUG"
$env:TF_LOG_PATH = "C:/Repositories/terraform/terraform-eo/terraform.log"

Start with the 0-Setup to configure client environment
terraform get -update
update the backend.tf in each instance to reflect where the state file will go
Put variables into tfvars datafiles
create remote state section for each of the subsections being created (setup, role, post-process)
cd 1-QA/author
terraform init
terraform plan --var-file=../../datafiles/qa.tfvars
echo "yes" | terraform apply --var-file=../../datafiles/qa.tfvars
echo "yes" | terraform destroy --var-file=..../datafiles/qa.tfvars
