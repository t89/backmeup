printf "Please enter...\n"

printf "...your full name:\n"
read fullname

printf "...your email address:\n"
read email

git config --global user.name "$fullname"
git config --global user.email "$email"
git config --global color.ui auto

printf "\nConfig successfully written!"
