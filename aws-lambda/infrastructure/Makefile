# Export vars

ARGS := ## Args to be additionally passed to Terraform CLI

FUNCTION_NAME_PREFIX := ## String that will be added in front function names

# Internal vars

tf_backend_config_file := backend.json

tf_plan_file := plan.tfplan

tf_init_args := -backend-config=$(tf_backend_config_file)
tf_plan_args := -var=prefix=$(FUNCTION_NAME_PREFIX)

dummy_asset_file := dummy.zip

help_sh := ./../../help.sh

# Targets

.DEFAULT_GOAL := help

.PHONY: deploy
deploy: | plan apply ## Plan and apply without confirmation


.PHONY: apply
apply:## Apply previously created plan
	terraform apply $(tf_plan_file) $(ARGS)
	@rm -f $(tf_plan_file)


.PHONY: destroy
destroy: init## Destroy created infrastructure
	terraform destroy -input=false $(tf_plan_args) $(ARGS)


.PHONY: plan
plan: init## Plan infrastructure changes and save to a file
	terraform plan -out $(tf_plan_file) -input=false $(tf_plan_args) $(ARGS)


.PHONY: init
init: $(tf_backend_config_file) $(dummy_asset_file)
	terraform init $(tf_init_args)


.PHONY: clean
clean:## Delete dummy asset and .terraform folder
	@rm -f $(dummy_asset_file)
	@rm -f $(tf_backend_config_file)
	@rm -rf .terraform


$(dummy_asset_file):
	@zip $(dummy_asset_file) .gitignore


$(tf_backend_config_file):
	@aws ssm get-parameter --name /terraform/backend/config --with-decryption \
		--query 'Parameter.Value' \
		--output text > $(tf_backend_config_file)


.PHONY: help
help:
	@$(help_sh) "$(MAKEFILE_LIST)"
