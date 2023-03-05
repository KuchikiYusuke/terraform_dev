env: ## Build terraform environment by .terraform-version
	tfenv install
	tfenv use

dev-init: ## terraform init in dev
	cd terraform/env/dev; terraform init; cd ../../../

dev-plan: ## terraform plan in dev
	cd terraform/env/dev; terraform plan; cd ../../../

dev-format: ## terraform format in dev
	cd terraform/env/dev; terraform fmt; cd ../../../
