#!/bin/bash

echo "Running pre-commit hook"

# If any command fails, exit immediately with that command's exit status
set -eo pipefail

git diff --name-only --cached | grep "spec.rb" | while read -r i; do
  # because "fit" is a word, look for (fit ") or (fit ') like the beginning of a block
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

  if grep -q "fdescribe" $i
  then
    echo Found \"fdescribe\" in $i
    exit 1
  fi
done
