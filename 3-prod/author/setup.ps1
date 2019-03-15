[cmdletbinding()]
param(
  [switch]$plan,
  [switch]$apply,
  [switch]$destroy
)

$varfile="../../datafiles/prod.tfvars"

function Test-Initialize {
  if (!(Test-Path .terraform)) {
    write-host "======== Initializing Terraform ========" -foregroundcolor "Yellow"
    terraform init
    write-host "======== Terraform Initialized ========" -foregroundcolor "Green"
  }
}

if ((!$plan) -and (!$apply) -and (!$destroy)) {
  write-host 'Accepted flags: -plan, -apply, -destroy' -foregroundcolor "magenta"
}

if ($plan) {
  write-host "======== Performing Terraform Plan ========" -foregroundcolor "Yellow"
  Test-Initialize
  terraform plan --var-file=$varfile
  write-host "======== Terraform Plan Completed ========" -foregroundcolor "Green"
}
if ($apply) {
  write-host "======== Performing Terraform Apply ========" -foregroundcolor "Yellow"
  Test-Initialize
  echo "yes" | terraform apply --var-file=$varfile
  write-host "======== Terraform Apply Completed ========" -foregroundcolor "Green"
}
if ($destroy) {
  write-host "======== Performing Terraform Destroy ========" -foregroundcolor "Yellow"
  Test-Initialize
  echo "yes" | terraform destroy --var-file=$varfile
  write-host "======== Terraform Destroy Completed ========" -foregroundcolor "Green"
}
