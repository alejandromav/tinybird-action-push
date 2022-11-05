# Tinybird GitHub Action Push
This action allows you to push changes to your Tinybird data project.

It will detected **changed files from the latest commit** that triggered the action, and push those changes.

If you need more options, you can use the Tinybird CLI action and pass the arguments you need: [https://github.com/alejandromav/tinybird-action-push](https://github.com/alejandromav/tinybird-action-push)

## Usage
To use the action simply create an `*.yml` file in the `.github/workflows/` directory. Ref. https://docs.github.com/es/actions/learn-github-actions/workflow-syntax-for-github-actions

For example, this will push your latest changes to Tinybird:

```yaml
name: Push changes to Tinybird  # feel free to pick your own name

on:
  push:
    branches:
    - master
    - main
    - stable
    - release/v*

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    # Important: This sets up your GITHUB_WORKSPACE environment variable
    - uses: actions/checkout@v3

    - name: Push changes to Tinybird
      uses: alejandromav/tinybird-action-push@1.1.4
      with:
        # [required]
        # Tinybird admin token. Please, use Github secrets (https://docs.github.com/en/actions/security-guides/encrypted-secrets)
        token: ${{ secrets.TINYBIRD_TOKEN }}

        # [optional]
        # Tinybird host. Defaults to `https://api.tinybird.co`.
        host: https://api.us-east.tinybird.co
        #
        # You can also use and env var if you don't want to reveal your Tinybird host (dedicated clusters, etc.)
        # host: ${{ secrets.TINYBIRD_HOST }}

        # [optional]
        # Option to force changes or not, and update existing objects. Defaults to `true`.
        force: false

        # [optional]
        # Option to populate materialized views with existing data. Defaults to `false`.
        populate: true

```

<br>

## License
The Dockerfile and associated scripts and documentation in this project are released under the [MIT](license).
