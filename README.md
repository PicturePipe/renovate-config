# PicturePipe Renovate Config Presets

[![CircleCI Build][circleci-logo]](https://circleci.com/gh/PicturePipe/renovate-config "CircleCI Build")
[![Renovate enabled][renovate-logo]](https://renovateapp.com/ "Renovate enabled")

[circleci-logo]: https://circleci.com/gh/PicturePipe/renovate-config.svg?style=shield
[renovate-logo]: https://img.shields.io/badge/renovate-enabled-brightgreen.svg

[Renovate config presets](https://docs.renovatebot.com/config-presets/) for PicturePipe projects.

## Usage

To use a config preset add a `renovate.json ` file to the root of the repository and reference the
config preset to be used.

This configuration will use the default preset (`default.json`):

```json
{
  "extends": ["github>PicturePipe/renovate-config"]
}
```

More than one config preset can be referenced. This configuration will use `default.json` and
`onsite-library.json`:

```json
{
  "extends": [
    "github>PicturePipe/renovate-config",
    "github>PicturePipe/renovate-config:onsite-library"
  ]
}
```

## Config Preset Validation

After a config preset has been changed, it should be validated:

```console
make validate
```

## License

Distributed under the MIT license.

Copyright 2019 reelport GmbH
