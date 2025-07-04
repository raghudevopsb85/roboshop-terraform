dev-init:
	rm -f .terraform/terraform.tfstate
	terraform init -backend-config=./environments/dev/state.tfvars

dev-plan:
	terraform plan -var-file=./environments/dev/main.tfvars

dev-apply:
	terraform apply -var-file=./environments/dev/main.tfvars

prod-init:
	rm -f .terraform/terraform.tfstate
	terraform init -backend-config=./environments/prod/state.tfvars

prod-plan:
	terraform plan -var-file=./environments/prod/main.tfvars

prod-apply:
	terraform apply -var-file=./environments/prod/main.tfvars


