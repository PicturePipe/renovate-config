.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[\.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: validate-json
validate-json: ## Validate JSON files
	find . -name '*.json' -print0 | xargs -0 -I % -n1 sh  -c 'echo %; jq . % > /dev/null;'

.PHONY: validate-presets
validate-presets: ## Validate Renovate config presets
	docker-compose run --rm validate
	docker-compose run -e RENOVATE_CONFIG_FILE=/var/src/renovate-config/circleci-orb.json --rm \
		validate
	docker-compose run -e RENOVATE_CONFIG_FILE=/var/src/renovate-config/legacy.json --rm \
		validate
	docker-compose run -e RENOVATE_CONFIG_FILE=/var/src/renovate-config/onsite-library.json --rm \
		validate

.PHONY: validate
validate: validate-json validate-presets ## Validate JSON files and Renovate config presets
