#!/bin/bash

set -e

check_semver ${NIX_VERSION}

if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${NIX_VERSION}
  exit 1
fi

echo "max-jobs = auto" | tee -a /tmp/nix.conf >/dev/null
echo "trusted-users = root ubuntu" | tee -a /tmp/nix.conf >/dev/null

installer_options=(
  --nix-extra-conf-file /tmp/nix.conf
)

curl -sSL https://nixos.org/releases/nix/nix-$NIX_VERSION/nix-$NIX_VERSION-x86_64-linux.tar.xz --output nix.txz
tar xJf nix.txz
rm nix.txz

mkdir -m 0755 /nix
chown ubuntu /nix
groupadd -r nixbld
for n in $(seq 1 10); do useradd -c "Nix build user $n" -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(command -v nologin)" "nixbld$n"; done

su ubuntu -c '"./nix-${NIX_VERSION}-x86_64-linux/install" "${installer_options[@]}"'
ln -s /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/

rm -r nix-${NIX_VERSION}-x86_64-linux*

export_path "/home/ubuntu/.nix-profile/bin"
export_env NIX_PATH /nix/var/nix/profiles/per-user/ubuntu/channels

nix --version
