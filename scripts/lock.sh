#!/usr/bin/env bash

function enable() {
  rm -f /tmp/.xautolock-disabled
  xautolock -enable
  notify-send "Xautolock" "Xautolock is enabled" -u normal
}

function disable() {
  xautolock -disable
  notify-send "Xautolock" "Xautolock is disabled" -u critical
  touch /tmp/.xautolock-disabled
}

function toggle() {
  if [[ -f "/tmp/.xautolock-disabled" ]]; then
      enable
  else
      disable
  fi
}

function status() {
  if [[ -f "/tmp/.xautolock-disabled" ]]; then
    echo "󰌿";
  else
    echo "󰌾";
  fi
}


case "$1" in 
	disable)
		disable
		;;

	enable)
		enable
		;;

	status)
		status
		;;

  toggle)
    toggle
    ;;

esac

