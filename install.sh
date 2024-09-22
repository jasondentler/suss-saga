#!/bin/bash

# Install NVM
install_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  local last_exit_status="$?"
  if [[ $last_exit_status -ne 0 ]]; then
    exit $last_exit_status
  fi

  # Load NVM
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

  last_exit_status="$?"
  if [[ $last_exit_status -ne 0 ]]; then
    exit $last_exit_status
  fi

  if command -v nvm >/dev/null; then
    echo "nvm installed"
  else
    echo "nvm not found"
    exit 1
  fi

  nvm install && nvm use
  last_exit_status="$?"
  if [[ $last_exit_status -ne 0 ]]; then
    echo -n "Failed to install node version "
    cat .nvmrc
    exit $last_exit_status
  fi

}

install_nvm
