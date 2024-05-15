#!/bin/bash

# verify the number of arguments
if [ $# -ne 2 ]; then
	echo "Usage: $0 <alias> <command>"
	exit 1
fi

alias_name=$1
script_path=$2
alias_dir="/usr/local/bin"
bash_alias_file="$HOME/.bash_aliases"

if [ ! -f "$script_path" ]; then
	echo "File does not exist"
	exit 1
fi

# copy script to /usr/local/bin
sudo cp "$script_path" "$alias_dir"

# give execute permission
sudo chmod +x "$alias_dir/$(basename $script_path)"

# add alias to bash_aliases
echo "alias $alias_name='$alias_dir/$(basename "$script_path")'" >>"$bash_alias_file"

source "$bash_alias_file"

echo "Alias created successfully: $alias_name"
