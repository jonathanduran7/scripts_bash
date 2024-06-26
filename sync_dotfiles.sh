#!/bin/bash

#directories configs
config_path="$HOME/.config"

# define directory dotfiles
dotfiles_repo="$HOME/duranj.Dots"

copyDotFilesRepo() {
	# pull dot
	cd "$dotfiles_repo" || exit
	if git pull origin master; then
		# copy and paste folders
		cp -r "$dotfiles_repo/duranjZellij/zellij/" "$config_path"
		cp -r "$dotfiles_repo/duranjFish/fish/" "$config_path"
		cp -r "$dotfiles_repo/duranjNvim/nvim/" "$config_path"

		echo "Dotfiles configurations synchronized successfully."
	else
		echo "Error: Failed to pull changes from the repository"
	fi
}

copyConfigToRepo() {
	# copy and paste folders
	# if you want to add more config folder, just replace this pattern
	# cp -r "$config_path/<folderNameConfig>/" "$dotfiles_repo/<folderDestination>"
	cp -r "$config_path/zellij/" "$dotfiles_repo/duranjZellij"
	cp -r "$config_path/fish/" "$dotfiles_repo/duranjFish"

	# if you want ignore some files, just add the pattern --exclude='<file>'
	rsync -a --exclude='.git' --exclude='.gitignore' "$config_path/nvim/" "$dotfiles_repo/duranjNvim/nvim"

	echo "Dotfiles configurations synchoronized successfully."
}

if [ "$#" -ne 1 ] || [ "$1" != "push" -a "$1" != "pull" ]; then
	echo "Usage: $0 <push|pull>"
	exit 1
fi

action=$1

if [ $action == "push" ]; then
	copyConfigToRepo
fi

if [ $action == "pull" ]; then
	copyDotFilesRepo
fi
