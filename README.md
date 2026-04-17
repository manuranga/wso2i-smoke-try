# wso2i-smoke-try

Smoke tests for WSO2 Integrator using [wso2ipw](https://github.com/manuranga/wso2ipw).

## What it does

1. Downloads the WSO2 Integrator Linux pack from GitHub Releases
2. Installs `wso2ipw` (Playwright-based CLI for WSO2 Integrator automation)
3. Runs a headless Xvfb session on `ubuntu-latest`
4. Executes `tests/hello-service.sh` — creates an HTTP service, adds a return node, runs it, verifies `GET /greeting` returns `"Hello, World!"`

## Usage

Trigger via **Actions → Smoke Test → Run workflow**, specifying the integrator version.

## Migration to product-integrator

When moving to `wso2/product-integrator`, replace the download step with artifact download from the build job:

```yaml
# After compile/build job:
smoke-test:
  needs: compile
  # ...
  steps:
    - uses: actions/download-artifact@v4
      with:
        name: artifacts-linux
    - run: |
        tar -xzf vscode-linux-x64.tar.gz
        chmod +x VSCode-linux-x64/bin/wso2-integrator
        echo "WSO2_INTEGRATOR_PATH=$(realpath VSCode-linux-x64/bin/wso2-integrator)" >> "$GITHUB_ENV"
```
