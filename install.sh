#!/bin/bash

GRAY="\033[38;5;250m"
GREEN="\033[38;5;82m"
BLUE="\033[36m"
RESET="\033[97m"
SCRIPT_PATH="$(pwd)"
USER_INPUT=_
EMAIL_INPUT=_
PASS_INPUT=_

source ${SCRIPT_PATH}/scripts/pkg_manager.sh
source ${SCRIPT_PATH}/scripts/pkgs.sh
source ${SCRIPT_PATH}/scripts/gpg_key.sh
source ${SCRIPT_PATH}/scripts/config.sh
source ${SCRIPT_PATH}/scripts/credentials.sh


main() {
  sudo -v
  while true; do sudo -n true; sleep 60; done &
  KEEP_ALIVE_PID=$!
  
  # set credentials params
  set_credentials
  
  # pkg_manager.sh
  #install_yay
  #install_snap
  #update_pkgs_manager
  
  # gpg_key.sh
  #set_gpg_key
  
  # pkgs.sh
  install_drivers
  install_all_pkgs

  # config.sh
  #set_configs
  #set_stow
  #config_greeter

  kill $KEEP_ALIVE_PID
  echo -e "${RESET}"
}

main
