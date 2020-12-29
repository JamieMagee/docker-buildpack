ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

RUN install-tool nix 2.3.10

USER ubuntu

RUN set -ex; \
  nix --version

RUN set -ex; \
  nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version'

RUN set -ex; \
  nix-env -i hello -f '<nixpkgs>'; \
  hello

