Dotfiles
========

This is my configuration files. I use GNU Stow to deploy but you can use this as a template for organising your own. .stowrc forces --dotfiles option so all files names like `dot-vimrc` are converted to `.vimrc`. This allows you to edit them easier as they are not hidden in the .dotfiles repo. The dotfiles repo must be in your user directory or you must use `-d` with stow to give it your home, but the folder can be named whatever you like.

```bash
$ git clone git@github.com:drewom/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow bash vim qutebrowser scripts
```
