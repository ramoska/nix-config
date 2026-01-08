#!/usr/bin/env bash

if [ "$1" = "period-changed" ]; then
  case "$3" in
    night)
      dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
      ;;
    daytime)
      dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
      ;;
  esac
fi
