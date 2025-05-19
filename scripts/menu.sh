#!/bin.bash

UP_ARROW=$'\n[A'
DOWN_ARROW=$'\n[B'
OPTION_COUNT=0
key_pressed=''

menu_tab() {
  if [[ "$1" == "$OPTION_COUNT" ]]; then
    echo "${GREEN} "
  fi
}

menu_header() {
  P_COLOR=$BLUE
  S_COLOR=$GRAY
  clear
 
  echo -e "                     ${P_COLOR}_            _      ${S_COLOR}      _      _              "
  echo -e "         ${P_COLOR}.          ${P_COLOR}/_\  _ __ ___| |__   ${S_COLOR} _ __(_) ___(_)_ __   __ _  "
  echo -e "        ${P_COLOR}/#\        ${P_COLOR}//_ \| '__/ __| '_ \  ${S_COLOR}| '__| |/ __| | '_ \ / _\` | "
  echo -e "       ${P_COLOR}/###\      ${P_COLOR}/  _  \ | | (__| | | | ${S_COLOR}| |  | | (__| | | | | (_| | "
  echo -e "      ${P_COLOR}/p^###\     ${P_COLOR}\_/ \_/_|  \___|_| |_| ${S_COLOR}|_|  |_|\___|_|_| |_|\__, | "
  echo -e "     ${P_COLOR}/##P^q##\    ${S_COLOR}| |__  _   _    ___ _______                 |___/  "
  echo -e "    ${P_COLOR}/##(   )##\   ${S_COLOR}| '_ \| | | |  / _ \_  / _ \ "
  echo -e "   ${P_COLOR}/###P   q#,^\  ${S_COLOR}| |_) | |_| | |  __// /  __/ "
  echo -e "  ${P_COLOR}/P^         ^q\ ${S_COLOR}|_.__/ \__, |  \___/___\___| "
  echo -e "                         ${S_COLOR}|___/ "
  echo -e "${RED} \"${key_pressed}\"${RESET}" 
  echo -e "${RESET}==> Installation of packages and some configs ${GRAY}(q=quit; w=up; s=down; f=select)"
  echo -e "${BLUE}$(menu_tab 0)  -> 0 - run all the tasks"
  echo -e "${BLUE}$(menu_tab 1)  -> 1 - set credentials for sudo use"
  echo -e "${BLUE}$(menu_tab 2)  -> 2 - install packages manager and update"
  echo -e "${BLUE}$(menu_tab 3)  -> 3 - config and create GPG keys"
  echo -e "${BLUE}$(menu_tab 4)  -> 4 - install hardware drivers"
  echo -e "${BLUE}$(menu_tab 5)  -> 5 - install packages"
  echo -e "${BLUE}$(menu_tab 6)  -> 6 - add symslinks configs"
  echo -e "${BLUE}$(menu_tab 7)  -> 7 - adopt current configs"
  echo -e "${BLUE}$(menu_tab 8)  -> 8 - make some extra settings"
  echo -e "${BLUE}$(menu_tab 9)  -> 9 - exit"
  echo -e "${GRAY}"
}

menu_options() {
  option=$1
  #read -p " > enter the option: " option

  if [[ $option == "0" || $option == "1" ]]; then
    set_credentials
  elif [[ $option == "0" || $option == "2" ]]; then
    install_yay
    install_snap
    update_pkgs_manager
  elif [[ $option == "0" || $option == "3" ]]; then
    set_gpg_key
  elif [[ $option == "0" || $option == "4" ]]; then
    install_drivers
  elif [[ $option == "0" || $option == "5" ]]; then
    install_all_pkgs
  elif [[ $option == "0" || $option == "6" ]]; then
    set_all_stow
  elif [[ $option == "0" || $option == "7" ]]; then
    adopt_all_stow
  elif [[ $option == "0" || $option == "8" ]]; then
    set_configs
  elif [[ $option == "q" || $option == "9" ]]; then
    echo "leaving..."
    exit 0
  fi
}

listener_keyboard() {
  echo "listener"
  MAX_COUNT=9
  MIN_COUNT=0
  OPTION_COUNT=0
  callback=$1
  key_pressed=''

  while true; do
    case "$key_pressed" in
      w)
        OPTION_COUNT=$(($OPTION_COUNT - 1))
        ;;
      s)
        OPTION_COUNT=$(($OPTION_COUNT + 1))
        ;;
      A)
        OPTION_COUNT=$(($OPTION_COUNT - 1))
        ;;
      B)
        OPTION_COUNT=$(($OPTION_COUNT + 1))
        ;;
      "__ENTER__")
        break
        ;;
      f)
        break
        ;;
      q)
        echo "leaving..."
        break
       ;;
      *)
        ;;
    esac

    if [[ $OPTION_COUNT -lt $MIN_COUNT ]]; then
      OPTION_COUNT=$MIN_COUNT
    elif [[ $OPTION_COUNT -gt $MAX_COUNT ]]; then
      OPTION_COUNT=$MAX_COUNT
    fi

    $callback
    read -rsn1 key_pressed
  done
}

menu() {
  listener_keyboard menu_header
  option="$OPTION_COUNT"
  menu_options $option
}
