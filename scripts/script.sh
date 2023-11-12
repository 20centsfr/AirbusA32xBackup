#!/bin/bash

# Récupérer la liste de tous les fichiers sauf scripts/script.sh
FILES=$(find . -type f -not -path "./scripts/script.sh")

if [[ -n "$FILES" ]]; then
  echo "Running "secret" check on staged files:"
  echo "$FILES"
  echo ""

  for FILE in $FILES; do
    if grep -q "secret" "$FILE"; then
      echo "Error: Found 'secret' keyword in $FILE. Please remove it before committing."
      exit 1
    fi
  done
fi

echo "No 'secret' keyword found. Good to go!"

exit 0

