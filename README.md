Installation
============
```
➜  dotfiles git:(master) make
all                            Make it all!
brew                           Ensure only formulas in Brewfile are installed
ensure_symlinks                Symlink files to where they belong
pip                            Ensure only pip packages in requirements.in are installed
sleepwatcher                   Link sleepwatcher user launch agent
```

```
➜  dotfiles git:(master) make all
./ensure_symlinks.sh
brew update
Already up-to-date.
brew doctor
Your system is ready to brew.
brew bundle cleanup --force
brew bundle check || brew bundle
The Brewfile's dependencies are satisfied.
brew bundle dump --force
pip freeze | xargs pip uninstall -y -q
pip install -r requirements.in --upgrade -q
pip freeze -r requirements.in > requirements.txt
```
