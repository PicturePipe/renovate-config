# PicturePipe Renovate Preset Config

[![CircleCI Build](https://circleci.com/gh/PicturePipe/renovate-config.svg?style=shield)](https://circleci.com/gh/PicturePipe/renovate-config "CircleCI Build")

[Renovate](https://renovatebot.com/) preset config for PicturePipe projects.

## Usage

To use this preset config add a `renovate.json ` file to the root of the repository with the
following content:

```json
{
  "extends": ["github>PicturePipe/renovate-config"]
}
```

## Config Validation

If the preset config has been changed it should be validated:

```console
make validate
```

## License

Distributed under the MIT license.

Copyright 2019 reelport GmbH
