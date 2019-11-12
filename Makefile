.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[\.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: validate
validate: ## Validate Renovate config presets
	docker-compose run --rm validate
	docker-compose run -e RENOVATE_CONFIG_FILE=/var/src/renovate-config/circleci-orb.json --rm \
		validate
	docker-compose run -e RENOVATE_CONFIG_FILE=/var/src/renovate-config/legacy.json --rm \
		validate
	docker-compose run -e RENOVATE_CONFIG_FILE=/var/src/renovate-config/onsite-library.json --rm \
		validate
