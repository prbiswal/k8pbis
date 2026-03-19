#!/bin/bash

# Usage:
# ./create-pr.sh "branch-name" "PR title" "PR description"

BRANCH_NAME=$1
PR_TITLE=$2
PR_DESC=$3

# Fail if no branch name
if [ -z "$BRANCH_NAME" ]; then
  echo "❌ Branch name required"
  exit 1
fi

# Create branch
git checkout -b "$BRANCH_NAME"

# Add & commit
git add .
git commit -m "$PR_TITLE"

# Push branch
git push origin "$BRANCH_NAME"

# Create PR
az repos pr create \
  --source-branch "$BRANCH_NAME" \
  --target-branch main \
  --title "$PR_TITLE" \
  --description "$PR_DESC"

echo "✅ PR created successfully!"