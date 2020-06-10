#!/usr/bin/env bash
# Validate Renovate config presets

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
# set -o xtrace

readonly PRESETS=(circleci-orb.json default.json legacy.json onsite-library.json)
readonly SCHEMA_URL=https://docs.renovatebot.com/renovate-schema.json

echo "Downloading $SCHEMA_URL"
curl --fail --silent --show-error --location --remote-name "$SCHEMA_URL"
echo

for PRESET in "${PRESETS[@]}"; do
    if [ ! -f "$PRESET" ]; then
        echo "$PRESET not found" >&2
        exit 1
    fi
    echo "[$PRESET]"
    RENOVATE_CONFIG_FILE="$PRESET" npx renovate-config-validator
    npx ajv --extend-refs=true -s renovate-schema.json -d "$PRESET"
    echo
done
