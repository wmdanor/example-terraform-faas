# Export vars
GOOS := linux## GOOS environment variable used for build
GOARCH := arm64## GOARCH environment variable used for build

FUNCTION_NAME_PREFIX := ## String that will be added in front of folder names to be used as functions names

EXCLUDE := ## Comma separate functions folders to exclude from push

# Internal vars
functions_dir := function
assets_dir := assets

comma := ,
exclude_functions := $(subst $(comma), ,$(EXCLUDE))

# In the current implementation function name must
# match with folder name of the function package
functions := $(shell ls $(functions_dir))
push_functions := $(filter-out $(exclude_functions),$(functions))

help_sh := ./../../help.sh

# Targets

.DEFAULT_GOAL := help

.PHONY: deploy
deploy: | clean build push## Build and upload function code


.PHONY: push
push: $(push_functions:%=push/%)## Upload function code
push/%: FUNCTION = $*
push/%:
	@echo "Pushing '$(FUNCTION)' function code"
	aws lambda update-function-code \
		--function-name '$(FUNCTION_NAME_PREFIX)$(FUNCTION)' \
		--zip-file fileb://$(assets_dir)/$(FUNCTION).zip --no-cli-pager


.PHONY: build
build: $(functions:%=build/%)## Build function code
build/%: FUNCTION = $*
build/%:
	@echo "Building '$(FUNCTION)' function code"
	GOOS=$(GOOS) GOARCH=$(GOARCH) CGO_ENABLED=0 go build \
		-tags lambda.norpc \
		-o $(assets_dir)/$(FUNCTION)/bootstrap \
		$(functions_dir)/$(FUNCTION)/main.go
	zip -j $(assets_dir)/$(FUNCTION).zip $(assets_dir)/$(FUNCTION)/bootstrap


.PHONY: clean
clean:## Delete previously built functions assets
	@rm -rf $(assets_dir)


.PHONY: test
test:## Run tests
	go test ./...


.PHONY: help
help:
	@$(help_sh) "$(MAKEFILE_LIST)"
