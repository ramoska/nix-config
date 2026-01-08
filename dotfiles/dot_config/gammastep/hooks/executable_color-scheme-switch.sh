#!/usr/bin/env bash

notify-send "Gammastep Hook" "Event: $1\nOld: $2\nNew: $3" --icon=display-brightness-symbolic

if [ "$1" = "period-changed" ] || [ "$1" = "initial" ]; then
  case "$3" in
    night)
      dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
      ;;
    daytime|transition)
      dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
      ;;
  esac
fi
