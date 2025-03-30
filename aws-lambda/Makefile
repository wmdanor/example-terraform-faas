# Export vars

APP := true## Whether to apply target to app
INFRA := true## Whether to apply target to infrastructure

# Internal vars

function_name_prefix=aws-lambda-

app_dir := app
infrastructure_dir := infrastructure
dirs := $(app_dir) $(infrastructure_dir)

# Infrastructure must be deployed first,
# so app will have place where to upload the code.
ifeq ($(INFRA),true)
selected_dirs := $(infrastructure_dir)
endif
ifeq ($(APP),true)
selected_dirs := $(selected_dirs) $(app_dir)
endif

help_sh := ./../help.sh

# Targets 

.DEFAULT_GOAL := help

.PHONY: deploy
deploy: | $(selected_dirs:%=deploy-%)## Deploy


.PHONY: deploy-$(infrastructure_dir)
deploy-$(app_dir):
	$(MAKE) -C $(app_dir) deploy FUNCTION_NAME_PREFIX=$(function_name_prefix)


.PHONY: deploy-$(infrastructure_dir)
deploy-$(infrastructure_dir):
	$(MAKE) -C $(infrastructure_dir) deploy FUNCTION_NAME_PREFIX=$(function_name_prefix)


.PHONY: destroy
destroy:## Destroy
	$(MAKE) -C $(infrastructure_dir) destroy


.PHONY: clean
clean: $(selected_dirs:%=clean-%)## Clean
clean-%: dir = $*
clean-%:
	$(MAKE) -C $(dir) clean


.PHONY: help
help:
	@$(help_sh) "$(MAKEFILE_LIST)"
