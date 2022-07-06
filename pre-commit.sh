#!/bin/bash

echo "Running pre-commit hook"

# If any command fails, exit immediately with that command's exit status
set -eo pipefail

if [[ -n "$(git diff --name-only --cached | grep 'spec.rb')" ]]
then
  git diff --name-only --cached | grep "spec.rb" | while read -r i
  do
    if grep -qE "fit \"|fit '" $i
    then
      echo Found \"fit\" in $i
      exit 1
    fi

    if grep -qE "fcontext" $i
    then
      echo Found \"fcontext\" in $i
      exit 1
    fi

    if grep -qE "fdescribe" $i
    then
      echo Found \"fdescribe\" in $i
      exit 1
    fi
  done
fi
