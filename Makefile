help: ## Show this help message
	@echo "Usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

dev-init:
	git pull
	rm -f .terraform/terraform.tfstate
	terraform init -backend-config=./environments/dev/state.tfvars

dev-plan:
	terraform plan -var-file=./environments/dev/main.tfvars

dev-apply: dev-init
	terraform apply -var-file=./environments/dev/main.tfvars -auto-approve -var token=$(token)

dev-destroy: dev-init
	terraform destroy -var-file=./environments/dev/main.tfvars -auto-approve  -var token=$(token)

prod-init:
	rm -f .terraform/terraform.tfstate
	terraform init -backend-config=./environments/prod/state.tfvars

prod-plan:
	terraform plan -var-file=./environments/prod/main.tfvars

prod-apply: prod-init
	terraform apply -var-file=./environments/prod/main.tfvars -auto-approve  -var token=$(token)

prod-destroy: prod-init
	terraform destroy -var-file=./environments/prod/main.tfvars -auto-approve  -var token=$(token)

tools-infra:
	git pull
	rm -f .terraform/terraform.tfstate
	cd tools ; terraform init ; terraform apply -auto-approve

