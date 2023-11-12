#!/bin/bash

FILES=$(find .)

if [[ -n "$FILES" ]]; then
  echo "Running pre-commit check on staged files:"
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

