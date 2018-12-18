#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# HardCoded Backup Locations
# a="~/Dropbox"
# b="path/to/alternate/location"
# bu_locations=($a $b)


# Name of the containing Backup Folder
repoDirectoryName="Backup"

# WARNING: When renaming the file to .command, $(pwd) ALWAYS contains the home directory
# ALSO: Do not forget to cd into the cwd before assuming you are in the scripts directory

# cwd=$(pwd)
# Use this instead:
cwd="${0%/*}"
projectName="$(basename $cwd)"

printf "\n\n\n"

# Update
bmu_path="$HOME/.backmeup"
if [ -d "$bmu_path" ]; then
  echo "Updating Backup Script..."
  cd $bmu_path
  git pull origin master
fi

if [ ! -f "$bmu_path/destinations.txt" ]; then
  echo "Missing destinations.txt file. Aborting."
  exit 1
fi

line_count=0
while read line; do
  bu_locations[$line_count]="$line"
  line_count=$line_count+1
done <"$bmu_path/destinations.txt"

# Initiate local Git Repository
if [ ! -d "$cwd/.git" ]; then

  # The following cd is SUPER important to avoid creating a git repository within $HOME
  cd $cwd
  git init

  # Create gitignore
  echo "*.command" > .gitignore

  git add .
  git commit -m "Initial Commit"

  for backup_location in "${bu_locations[@]}"; do
    if [ -d "${backup_location/#~/$HOME}" ]; then
      if [ ! -d "${backup_location/#~/$HOME}/$repoDirectoryName/" ]; then
        echo "> Creating ${backup_location/#~/$HOME}/$repoDirectoryName/"
        mkdir "${backup_location/#~/$HOME}/$repoDirectoryName"
      fi

      addRemoteFlag=1

      if [ -d "${backup_location/#~/$HOME}/$repoDirectoryName/$projectName" ]; then
        echo "\n> Project already exists. Would you like to connect to it?"
        select yn in "Yes" "No"; do
          case $yn in
            Yes ) break;;
            No ) addRemoteFlag=0; break;;
          esac
        done
      else
        echo "> Creating project directory: $projectName"
        mkdir "${backup_location/#~/$HOME}/$repoDirectoryName/$projectName/"
        cd "${backup_location/#~/$HOME}/$repoDirectoryName/$projectName/"

        echo "-- Setting Up Backup Location --"


        echo "> Initializing Git bare repository"
        git init --bare
        cd $cwd
      fi

      if [ "$addRemoteFlag" = "1" ]; then
        remote_name=$(basename "${backup_location/#~/$HOME}")
        echo "\n> Adding git remote $remote_name"
        git remote add $remote_name  "${backup_location/#~/$HOME}/$repoDirectoryName/$projectName/"
        echo "> Git remotes:"
        git remote
      fi

    else
      echo "Backup location ${backup_location/#~/$HOME} not found."
    fi
  done

  # push everything to all remotes
  git remote | xargs -L1 git push --all
else
  cd $cwd
  # Check if we have made changes since last backup
  if git diff-index --quiet HEAD --; then
    echo "Looks like you have made no changes since last backup."
  else
    echo "Please enter a brief description of your changes (cancel with ctrl + c):"
    read commitMSG

    git add .
    git commit -m "$commitMSG"

    git remote | xargs -L1 git push --all
  fi
fi

printf "\nYou can quit this window now using cmd + q. Have a nice day."

