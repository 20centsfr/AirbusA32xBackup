#!/bin/bash

FILES=$(git diff --name-only --diff-filter=ACM | grep -E '\.jsx?$' || true)

if [[ -n "$FILES" ]]; then
  echo "Running pre-commit check on changed files:"
  echo "$FILES"
  echo ""

  for FILE in $FILES; do
    if grep -q "secret" "$FILE"; then
      echo "Error: Found 'secret' keyword in $FILE. Please remove it before committing."
      exit 1
    fi
  done
fi

exit 0
