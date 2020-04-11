Dotfiles 🌴
==========

This repository contains my configurations for:
- bash
- git
- neovim
- python
- tmux

```
$ make
all                            Make it all!
brew                           Install formulas in Brewfile
files                          Ensure files are up to date
npm_freeze                     Freeze node packages into Nodefile
pip2                           Ensure pip packages in requirements.in are installed
pip2_clean                     Uninstall all pip modules
pip3                           Ensure pip3 packages in requirements.in are installed
pip3_clean                     Uninstall all pip3 modules
tmux_plugins                   Install and update tmux plugins
```

Installation
------------

(May be out of order or missing steps.)

1. Clone this repository.
1. Install [Homebrew](https://brew.sh/).
1. `make brew` to install bash4.4, pyenv.
1. `pyenv install 3.7.4`.
1. `pyenv install 2.7.14`.
1. Download [iTerm beta build](https://www.iterm2.com/downloads.html).
1. Set up iTerm preferences to load from file.
1. `make files` (will install Salt into Python3 installation).
1. `make pip3`.
