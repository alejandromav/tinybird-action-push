#!/bin/sh -l

: "${TOKEN?Tinybird token not found, please check README.md.}"
: "${HOST?Tinybird host not found, please check README.md.}"
: "${GITHUB_WORKSPACE?GITHUB_WORKSPACE has to be set. Did you use the actions/checkout action?}"
: "${GITHUB_SHA?GITHUB_SHA has to be set. Did you use the actions/checkout action?}"

# Revert fetch with depth=1, so eveything is collpased to one single commit
git pull --unshallow

# Detecting changes files from latest commit
echo "> Detecting changes files for commit $GITHUB_SHA..."
git_diff=$(git show --name-only --oneline "${GITHUB_SHA}" | tail -n +2 | grep -E '\.(pipe|datasource)')

# Print changed files
echo "> Detected files:"
for file in $git_diff; do
  echo "$file"
done

FORCE=""
POPULATE=""

# Push changes
for file in $git_diff; do
  if [ ! -f "$file" ]; then
    # Skip if detected file doesn't exist
    continue
  fi

  echo "> Pushing $file..."

  # Force flag
  if echo $INPUT_FORCE | grep -iqF true; then
    FORCE="--force"
  fi

  # Populate flag
  if echo $INPUT_POPULATE | grep -iqF true; then
    POPULATE="--populate"
  fi

  # Print command
  echo "tb --token ${TOKEN} --host "${HOST}" push --push-deps ${FORCE} $file ${POPULATE}"
  tb --token "${TOKEN}" --host "${HOST}" push --push-deps ${FORCE} "$file" ${POPULATE}
done
