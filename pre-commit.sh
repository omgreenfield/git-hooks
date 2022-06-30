#!/bin/bash

echo "Running pre-commit hook"

# If any command fails, exit immediately with that command's exit status
set -eo pipefail

# Get only changed files that match our file suffix pattern
get_pattern_files() {
  pattern=$(echo "$*" | sed "s/ /\$\\\|/g")
  echo "$CHANGED_FILES" | { grep "$pattern$" || true; }
}

# Find all changed files for this commit
# Compute the diff only once to save a small amount of time.
CHANGED_FILES=$(git diff --name-only --cached --diff-filter=ACMR)

# Checks all files with spec.rb
SPEC_FILES=$(get_pattern_files spec.rb)

if [[ -n "$CHANGED_FILES" ]]
then
  for i in "${SPEC_FILES[@]}"
  do
    if grep -q "fit" $i
    then
      echo Found \"fit\" in $i
      exit 1
    fi

    if grep -q "fcontext" $i
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
fi
