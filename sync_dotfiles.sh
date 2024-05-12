#!/bin/bash

#directories configs
config_dest="$HOME/.config"

# define directory dotfiles
dotfiles_repo="$HOME/duranj.Dots"

copyDotFilesRepo() {
	# pull dot
	cd "$dotfiles_repo" || exit

	if git pull origin master; then
		# copy and paste folders
		cp -r "$dotfiles_repo/duranjZellij/zellij/" "$config_dest"
		cp -r "$dotfiles_repo/duranjFish/fish/" "$config_dest"
		cp -r "$dotfiles_repo/duranjNvim/nvim/" "$config_dest"

		echo "Dotfiles configurations synchronized successfully."
	else
		echo "Error: Failed to pull changes from the repository"
	fi
}

copyConfigToRepo() {
	# copy and paste folders
	cp -r "$config_dest/zellij/" "$dotfiles_repo/duranjZellij"
	cp -r "$config_dest/fish/" "$dotfiles_repo/duranjFish"
	rsync -a --exclude='.git' --exclude='.gitignore' "$config_dest/nvim/" "$dotfiles_repo/duranjNvim/nvim"

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
