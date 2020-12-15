ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

RUN install-tool powershell 7.1.0

RUN install-tool scoop 2020-11-26

USER ubuntu

RUN set -ex; \
  pwsh -Version

RUN set -ex; \
  pwsh -Command Write-Host Hello, World!
