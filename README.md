# ELK-Tutorial
first setup your terraform variables as below
export AWS_ACCESS_KEY_ID=AKIXXXXXXXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=12+DQVlXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
export TF_VAR_profile=yours
export TF_VAR_region=eu-west-2
export TF_VAR_key_name=yourkey


## setup required artefacts
cd to  terraform/accessories and run terraform plan , then run terrafrom apply
if all goes well cd to network and do the same
next to ELK-Artefacts

