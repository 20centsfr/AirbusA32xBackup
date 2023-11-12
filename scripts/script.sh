#!/bin/bash
set -x
set -e

# Récupérer la liste des fichiers modifiés à partir de l'événement GitHub
FILES=$(jq --raw-output '.pull_request.files[].filename' "$GITHUB_EVENT_PATH" | grep -E '\.jsx?$' | sed "s|^|$PWD/|")

if [[ -n "$FILES" ]]; then
  echo "Running pre-commit check on staged files:"
  echo "$FILES"
  echo ""

  for FILE in $FILES; do
    echo "Checking file: $FILE"
    if grep -q "secret" "$FILE"; then
      echo "Error: Found 'secret' keyword in $FILE. Please remove it before committing."
      exit 1
    fi
  done
fi

exit 0
