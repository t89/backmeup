#!/bin/bash

printf "Please enter...\n"

read -p 'Full Name: ' fullname

read -p 'E-Mail: ' email

git config --global user.email "$email"
git config --global user.name "$fullname"
git config --global color.ui auto

printf "\nConfig successfully written!"
