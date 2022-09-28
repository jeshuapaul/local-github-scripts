#!/bin/bash

### Based off of - https://www.freecodecamp.org/news/pushing-to-github-made-simple-enough-for-poets/

# Go into the directory that you are working in and set the perms of the files to my local user.
cd $(pwd)
sudo chown jesh:jesh *

# This will initialize the folder/repository that you have on your local computer system.
sudo git init

# This will track any changes made to the folder on your system, since the last commit. If this is the first time you are committing the contents of the folder, it will add everything.
sudo git add .

# Checking if any changes have been made to the local repo and then making a decision based on that.
for i in $(sudo git status | awk '{print $1}' | cut -f1 -d ":"); do
	# MODIFIED FILES
	if [ "$i" == "modified" ]; then
		for a in $(git status | grep modified | awk '{print $2}'); do
			echo "--------------------------------------------------------------------------"
			echo "Commit message for MODIFIED FILE: $a ?"
			read commit_msg
				if [ -z "$commit_msg" ]; then
					sudo git commit -m " ---"
				else
					sudo git commit -m "$commit_msg" "$a"
				fi
			continue
		done
	# DELETED FILES
	elif [ "$i" == "deleted" ]; then
		sudo git commit -m "deleted"
	# NEW FILES
	elif [ "$i" == "new" ]; then
		for a in $(git status | grep new | awk '{print $3}'); do
			echo "--------------------------------------------------------------------------"
			echo "Commit message for NEW FILE: $a ?"
			read commit_msg
			sudo git commit -m "$commit_msg" "$a"
			continue
		done
	elif [ "$i" == "nothing" ]; then
		echo "--------------------------------------------------------------------------"
		echo "No recent changes made to local repo have been detected - no updates to push."
	fi
done

# Requesting the URL that the updates need to be pushed to.
echo "--------------------------------------------------------------------------"
echo "REPO NAME that the updates need to be pushed to ?"
read repo_name
sudo git remote add origin "https://github.com/jeshuapaul/$repo_name.git"

# This does some git pull and git push magic, to ensure that the contents of your new Github repository, and the folder on you local system are the same.
sudo git remote -v

# The last word in the command 'main', is not a fixed entry when running git push. It can be replaced with any relevant 'branch_name' that you are using.
sudo git push origin main
