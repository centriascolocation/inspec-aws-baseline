SHELL := /bin/bash

# set the default region:
AWS_REGION ?= eu-central-1
AWS_PROFILE ?= centrias

INSPEC_VERSION = 4.36.4
INSPEC_OPTIONS = --log-level=error --show-progress
INSPEC_ACCEPT_EULA = --chef-license=accept-silent
INSPEC_DOCKER_RUN = docker container run -it -e AWS_SESSION_TOKEN -e AWS_REGION -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY --rm -v $(PWD):/share inspec_git_crypt:$(INSPEC_VERSION)

.PHONY: help terraform test tests
help: ## this help
	@echo "Please use 'make <target>' where <target> is one of"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-32s\033[0m %s\n", $$1, $$2}'

update-toc: ## update the table of contents
	doctoc README.md --github

build-docker-images: ## custom Docker image with additional batteries included
	docker build \
		--build-arg INSPEC_VERSION=$(INSPEC_VERSION) \
		-f docker/Dockerfile-inspec \
		-t inspec_git_crypt:$(INSPEC_VERSION) .

test: ## runs InSpec tests
	@echo "Please be patient - this can take a while ......."
	@-export $(shell aws-vault exec -n $(AWS_PROFILE) -- env | grep --color=never ^AWS | xargs) && \
		$(INSPEC_DOCKER_RUN) \
		exec -t aws:// \
		$(INSPEC_ACCEPT_EULA) \
		.
