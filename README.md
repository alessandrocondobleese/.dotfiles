```
alias dotfile='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

```
echo ".dotfiles >> .gitignore"
```

```
git clone --bare git@github.com:alessandrocondobleese/.dotfiles.git $HOME/.dotfiles
```

```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

```
dotfile checkout
```

```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

```
dotfile config --local status.showUntrackedFiles no
```
