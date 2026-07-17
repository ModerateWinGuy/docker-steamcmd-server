#!/bin/bash
# Patches a key inside a PalWorldSettings.ini-style "OptionSettings=(...)" line.
set_ini_value() {
  local ini="$1"
  local key="$2"
  local value="$3"
  local quote="${4:-false}"
  local private="${5:-false}"
  local escaped
  escaped="$(printf '%s\n' "${value}" | sed 's/[&/\]/\\&/g')"
  if [ "${quote}" = true ]; then
    escaped="\"${escaped}\""
  fi
  if grep -q "^OptionSettings=(.*${key}=" "${ini}"; then
    sed -i "s|\(${key}=\)[^,]*|\1${escaped}|" "${ini}"
  else
    sed -i "s|^\(OptionSettings=(\)|\1${key}=${escaped}, |" "${ini}"
  fi
  if [ "${private}" = true ]; then
    echo "---Set ${key} (value hidden)---"
  else
    echo "---Set ${key} to $(grep -Po "(?<=${key}=)[^,]*" "${ini}")---"
  fi
}
