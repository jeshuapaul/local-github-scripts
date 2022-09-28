#!/bin/bash

# Go into the directory that you are working in.
cd $(pwd)

# This will initialize the folder/repository that you have on your local computer system.
sudo git init

# This will track any changes made to the folder on your system, since the last commit. If this is the first time you are committing the contents of the folder, it will add everything.
sudo git add .

# This will prepare the added/tracked changes to the folder on your system for pushing to Github. Here, 'insert message here' can be replaced with any relevant commit message of your choice.
echo "--------------------------------------------------------------------------"
echo "What is the commit message for this repo/code push?"
read commit_msg
sudo git commit -m "$commit_msg"

# Create/use the new branch/branch name on Github.
sudo git branch -M main

# This does some git pull and git push magic, to ensure that the contents of your new Github repository, and the folder on you local system are the same.
#sudo git remote -v

# This will push the existing folder on you local computer system, to the newly created Github repository.

echo "--------------------------------------------------------------------------"
echo "REPO NAME that the updates need to be pushed to ?"
read repo_name
sudo git remote add origin "https://github.com/jeshuapaul/$repo_name.git"

# The last word in the command 'main', is not a fixed entry when running git push. It can be replaced with any relevant 'branch_name' that you are using.
sudo git push -u origin main




