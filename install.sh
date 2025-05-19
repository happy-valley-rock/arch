#!/bin/bash

GRAY="\033[38;5;250m"
GREEN="\033[38;5;82m"
BLUE="\033[36m"
RED="\033[0;31m"
RESET="\033[97m"
SCRIPT_PATH="$(pwd)"
USER_INPUT=_
EMAIL_INPUT=_
PASS_INPUT=_
option=""

source ${SCRIPT_PATH}/scripts/pkg_manager.sh
source ${SCRIPT_PATH}/scripts/pkgs.sh
source ${SCRIPT_PATH}/scripts/gpg_key.sh
source ${SCRIPT_PATH}/scripts/config.sh
source ${SCRIPT_PATH}/scripts/credentials.sh
source ${SCRIPT_PATH}/scripts/trycatch.sh
source ${SCRIPT_PATH}/scripts/menu.sh

main() {
  sudo -v
  while true; do sudo -n true; sleep 60; done &
  KEEP_ALIVE_PID=$!

  try_block='menu'
  catch_block='echo -e "${RED}ERROR"'
  finally_block='echo ""
  read -p " > press any key to continue..."'

  while [[ $option != "q" ]]; do
    try "$try_block" "$catch_block" "$finally_block"
  done

  kill $KEEP_ALIVE_PID
  echo -e "${RESET}"
}

main
