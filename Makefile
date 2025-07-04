dev-init:
	terraform init

dev-plan:
	terraform plan -var-fil=./environments/dev/main.tfvars

dev-apply:
	terraform apply -var-fil=./environments/dev/main.tfvars

prod-init:
	terraform init

prod-plan:
	terraform plan -var-fil=./environments/prod/main.tfvars

prod-apply:
	terraform apply -var-fil=./environments/prod/main.tfvars


