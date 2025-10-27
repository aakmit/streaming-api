#!/usr/bin/env bash
# install_docker_ubuntu.sh
# Installs Docker Engine, CLI, containerd, Buildx, and Compose plugin on Ubuntu.
# Usage:
#   chmod +x install_docker_ubuntu.sh
#   ./install_docker_ubuntu.sh
# Optional flags:
#   -y        Non-interactive (auto "yes" for apt)
#   --no-group  Skip adding current user to the 'docker' group

set -Eeuo pipefail

AUTO_YES=""
ADD_GROUP=1

for arg in "$@"; do
  case "$arg" in
    -y) AUTO_YES="-y" ;;
    --no-group) ADD_GROUP=0 ;;
    *) echo "Unknown argument: $arg" >&2; exit 2 ;;
  esac
done

#--- Helpers ---------------------------------------------------------------#
log() { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[WARN]\033[0m %s\n" "$*"; }
err() { printf "\033[1;31m[ERR ]\033[0m %s\n" "$*" >&2; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    err "Required command '$1' not found. Install it and re-run."
    exit 1
  }
}

#--- Pre-flight checks -----------------------------------------------------#
require_cmd lsb_release || { err "lsb_release not found. Install 'lsb-release' first."; exit 1; }

ID=$(lsb_release -is 2>/dev/null || echo "")
CODENAME=$(lsb_release -cs 2>/dev/null || echo "")

if [[ "${ID,,}" != "ubuntu" ]]; then
  err "This script is intended for Ubuntu. Detected: ${ID:-unknown}"
  exit 1
fi

log "Detected Ubuntu codename: ${CODENAME}"

require_cmd curl
require_cmd sudo
require_cmd dpkg
require_cmd tee

#--- Install prerequisites -------------------------------------------------#
log "Updating apt package index..."
sudo apt-get update

log "Installing prerequisites: ca-certificates, curl, gnupg, apt-transport-https..."
sudo apt-get install $AUTO_YES ca-certificates curl gnupg apt-transport-https

#--- Setup Docker's official GPG key --------------------------------------#
log "Creating /etc/apt/keyrings if needed..."
sudo install -m 0755 -d /etc/apt/keyrings

KEYRING="/etc/apt/keyrings/docker.asc"
REPO_LIST="/etc/apt/sources.list.d/docker.list"

log "Fetching Docker's official GPG key to ${KEYRING}..."
# Use a temporary file then move into place atomically
TMP_KEY="$(mktemp)"
if ! curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" -o "${TMP_KEY}"; then
  err "Failed to download Docker GPG key."
  exit 1
fi
sudo mv "${TMP_KEY}" "${KEYRING}"
sudo chmod a+r "${KEYRING}"

#--- Add the Docker apt repository ----------------------------------------#
ARCH=$(dpkg --print-architecture)
log "Detected architecture: ${ARCH}"

REPO_LINE="deb [arch=${ARCH} signed-by=${KEYRING}] https://download.docker.com/linux/ubuntu ${CODENAME} stable"

if [[ -f "${REPO_LIST}" ]] && grep -Fq "download.docker.com/linux/ubuntu ${CODENAME} stable" "${REPO_LIST}"; then
  log "Docker repository already present at ${REPO_LIST}"
else
  log "Adding Docker repository to ${REPO_LIST}..."
  echo "${REPO_LINE}" | sudo tee "${REPO_LIST}" >/dev/null
fi

#--- Install Docker packages ----------------------------------------------#
log "Updating apt package index (with Docker repo)..."
sudo apt-get update

log "Installing Docker Engine & components..."
sudo apt-get install $AUTO_YES docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#--- Enable and start Docker ----------------------------------------------#
if systemctl list-unit-files | grep -q '^docker.service'; then
  log "Enabling and starting docker.service..."
  sudo systemctl enable docker >/dev/null 2>&1 || true
  sudo systemctl start docker || true
else
  warn "docker.service not found in systemd list; continuing anyway."
fi

#--- Add current user to docker group (optional) --------------------------#
if [[ $ADD_GROUP -eq 1 ]]; then
  if getent group docker >/dev/null 2>&1; then
    if id -nG "$USER" | grep -qw docker; then
      log "User '$USER' already in 'docker' group."
    else
      log "Adding '$USER' to 'docker' group (you'll need to log out/in to apply)..."
      sudo usermod -aG docker "$USER" || warn "Failed to add user to docker group."
    fi
  else
    log "Creating 'docker' group and adding '$USER'..."
    sudo groupadd docker || true
    sudo usermod -aG docker "$USER" || warn "Failed to add user to docker group."
  fi
else
  warn "Skipped adding user to 'docker' group due to --no-group flag."
fi

#--- Verify installation ---------------------------------------------------#
if command -v docker >/dev/null 2>&1; then
  DOCKER_VER=$(docker --version || true)
  COMPOSE_VER=$(docker compose version || true)
  log "Docker installed successfully."
  [[ -n "$DOCKER_VER" ]] && echo "  - $DOCKER_VER"
  [[ -n "$COMPOSE_VER" ]] && echo "  - $COMPOSE_VER"
  echo
  echo "Next steps:"
  echo "  • Log out and back in (or run 'newgrp docker') to use 'docker' without sudo."
  echo "  • Test: docker run --rm hello-world"
else
  err "Docker binary not found after installation. Check apt output above."
  exit 1
fi
