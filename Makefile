.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[\.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

RENOVATE_CONFIGS := \
	circleci-orb.json \
	default.json \
	legacy.json \
	onsite-library.json

.PHONY: clean
clean: ## Clean up previous state to perform full re-validation
	rm -f renovate-schema.json
	rm -f .validated-*.json

renovate-schema.json:
	curl https://raw.githubusercontent.com/renovatebot/renovate/master/renovate-schema.json > "$@"

.validated-%.json: %.json renovate-schema.json
	docker-compose run \
		-e "RENOVATE_CONFIG_FILE=/var/src/renovate-config/$<" \
		--rm \
		validate
	npx ajv -s renovate-schema.json -d "$<"
	touch "$@"

.PHONY: validate
validate: $(addprefix .validated-,$(RENOVATE_CONFIGS)) ## Validate Renovate config presets
	@echo "All configs seem valid."
