#!/bin/bash

try() {
  try_block="$1"
  catch_block="$2"
  finally_block="$3"

  eval "$try_block"
  local status=$?

  if [ $status -ne 0 ]; then
    if [ -n "$catch_block" ]; then
      eval "$catch_block"
    fi
  fi

  if [ -n "$finally_block" ]; then
    eval "$finally_block"
  fi

  return $status
}
