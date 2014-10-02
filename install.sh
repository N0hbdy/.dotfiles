#!/usr/bin/env bash
app_dir="$HOME/.dotfiles"
git_branch="master"
debug_mode='0'
[ -z "$git_uri" ] && git_uri='https://github.com/Nj0hbdy/.dotfiles'
[ -z "$VUNDLE_URI" ] && NEOBUNDLE_URI="https://github.com/Shougo/neobundle.vim"

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  if [ "$ret" -eq '0' ]; then
  msg "\e[32m[✔]\e[0m ${1}${2}"
  fi
}

error() {
  msg "\e[31m[✘]\e[0m ${1}${2}"
  exit 1
}

debug() {
  if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
    msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
  fi
}

program_exists() {
  local ret='0'
  type $1 >/dev/null 2>&1 || { local ret='1'; }
  # throw error on non-zero return value
  if [ ! "$ret" -eq '0' ]; then
    error "$2"
  fi
}

############################ SETUP FUNCTIONS
lnif() {
  if [ -e "$1" ]; then
    ln -sf "$1" "$2"
  fi
  ret="$?"
  debug
}

upgrade_repo() {
  msg "trying to update $1"

  if [ "$1" = "$app_name" ]; then
    cd "$app_dir" &&
    git pull origin "$git_branch"
  fi

  if [ "$1" = "neobundle.vim" ]; then
    cd "$HOME/.vim/bundle/neobundle.vim" &&
    git pull origin master
  fi

  ret="$?"
  success "$2"
  debug
}

clone_repo() {
  program_exists "git" "Sorry, we cannot continue without GIT, please install it first."

  if [ ! -e "$app_dir" ]; then
    git clone --recursive -b "$git_branch" "$git_uri" "$app_dir"
    ret="$?"
    success "$1"
    debug
  else
    upgrade_repo "$app_name"    "Successfully updated $app_name"
  fi
}

clone_neobundle() {
  if [ ! -e "$HOME/.vim/bundle/neobundle.vim" ]; then
    git clone $NEOBUNDLE_URI "$HOME/.vim/bundle/neobundle.vim"
  else
    upgrade_repo "neobundle.vim"   "Successfully updated neobundle.vim"
  fi
  ret="$?"
  success "$1"
  debug
}

create_vim_symlinks() {
  endpath="$app_dir"
  if [ ! -d "$endpath/.vim/bundle" ]; then
    mkdir -p "$endpath/.vim/bundle"
  fi

  lnif "$endpath/.vimrc"              "$HOME/.vimrc"
  lnif "$endpath/.vim"                "$HOME/.vim"

  ret="$?"
  success "$1"
  debug
}

setup_neobundle() {
  system_shell="$SHELL"
  export SHELL='/bin/sh'

  vim "+NeoBundleInstall +qall"

  export SHELL="$system_shell"

  success "$1"
  debug
}

########## MAIN()
program_exists "vim" "To install $app_name you first need to install Vim."

clone_repo      "Successfully cloned $app_name"

create_vim_symlinks "Setting up vim symlinks"

clone_neobundle    "Successfully cloned neobundle"

setup_neobundle    "Now updating/installing plugins using Neobundle"
