#!/bin/bash

mkdir -p "$HOME/.vim/bundle"
if [ ! -e "$HOME/.vim/bundle/neobundle.vim" ]; then
	git clone "https://github.com/Shougo/neobundle.vim" "$HOME/.vim/bundle/neobundle.vim"
else
	cur_dir=$(pwd)
	cd "$HOME/.vim/bundle" && git pull && cd "$cur_dir"
fi

vim "+NeoBundleInstall +qall"