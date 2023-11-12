#!/bin/bash

# Récupérer la liste des fichiers modifiés à partir de l'événement GitHub
FILES=$(jq --raw-output '.pull_request.head.repo.contents_url' "$GITHUB_EVENT_PATH" | xargs -I {} curl -s -H "Authorization: Bearer $GITHUB_TOKEN" "{}" | jq --raw-output '.[].name' | grep -E '\.jsx?$' | sed "s|^|$PWD/|")

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
