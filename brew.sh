#!/usr/bin/env bash

if [[ $(which -s brew) != 0 ]] ; then
    # Install Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# Sort out permissions
sudo chown -R "$(whoami):admin" /usr/local

# New High Sierra command
#sudo chown -R $(whoami) $(brew --prefix)/*

# Utils
brews=(
  git
  bash-completion
  hub
  ghi
  heroku
  the_silver_searcher
  cmake
  pass
  gnupg
  jq
  rancher-cli
  shellcheck
  httpie
  coreutils
  kibana
  adr-tools
  jmeter)

# THE editor?!
brews+=(vim)

# Languages
brews+=(mono go rust python ruby node elixir erlang scala)

# DBs
brews+=(mongodb postgresql sqlite)

# Node utils
brews+=(yarn)

# Upgrade if already home brew installed else install
for pkg in "${brews[@]}"; do
  if brew list -1 | grep -q "^${pkg}\$"; then
    echo "Upgrading '$pkg'"
    brew upgrade "{$pkg}"
  else
    echo "Installing '$pkg'"
    brew install "{$pkg}"
  fi
done

# Cleanup
brew cleanup
