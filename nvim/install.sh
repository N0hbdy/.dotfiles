#!/bin/bash

mkdir -p "$HOME/.nvim/bundle"
if [ ! -e "$HOME/.nvim/bundle/neobundle.vim" ]; then
	git clone "https://github.com/Shougo/neobundle.vim" "$HOME/.nvim/bundle/neobundle.vim"
else
	cur_dir=$(pwd)
	cd "$HOME/.nvim/bundle" && git pull && cd "$cur_dir"
fi

vim "+NeoBundleInstall +qall"
