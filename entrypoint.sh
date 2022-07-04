#!/bin/sh -l

: "${TOKEN?Tinybird token not found, please check README.md.}"
: "${GITHUB_WORKSPACE?GITHUB_WORKSPACE has to be set. Did you use the actions/checkout action?}"
: "${GITHUB_SHA?GITHUB_SHA has to be set. Did you use the actions/checkout action?}"

# Revert fetch with depth=1, so eveything is collpased to one single commit
git pull --unshallow

# Detecting changes files from latest commit
echo "> Detecting changes files for commit $GITHUB_SHA..."
git_diff=`git show --name-only ${GITHUB_SHA} | grep -E '.(pipe|datasource)'`

# Print changed files
echo "> Detected files:"
for file in $(echo $git_diff); do
  echo $file
done

FORCE=""
POPULATE=""

# Push changes
for file in $(echo $git_diff); do
  echo "\n> Pushing $file..."

  # Force flag
  if [ "${INPUT_FORCE,,}" = "true" ]; then
    FORCE="--force"
  fi

  # Populate flag
  if [ "${INPUT_POPULATE,,}" = "true" ]; then
    POPULATE="--populate"
  fi

  # Print command
  echo "tb --token ${TOKEN} push ${FORCE} $file ${POPULATE}"
  tb --token ${TOKEN} push ${FORCE} $file ${POPULATE}
done
