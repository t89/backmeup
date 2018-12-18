#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Name of the containing Backup Folder
repoDirectoryName="Backup"

# WARNING: When renaming the file to .command, $(pwd) ALWAYS contains the home directory
# ALSO: Do not forget to cd into the cwd before assuming you are in the scripts directory

# cwd=$(pwd)
# Use this instead:
cwd="${0%/*}"
projectName="$(basename $cwd)"

printf "\n\n\n"

bmu_path="$HOME/.backmeup"

if [ -d "$bmu_path" ]; then
  echo "Updating Backup Script..."
  cd $bmu_path
  git pull origin master
fi
