This is just the contents of my `.vim` directory. The repo is a clone of
pathogen, which allows me to update with `git pull`, and I maintain my
plugins as submodules. To set up Vim on a new machine, I just do:

	git clone git://github.com/zenhack/vim-config .vim
	cd .vim
	./setup.sh

The setup script creates a symlink `~/.vimrc` -> `~/.vim/vimrc`, and
checks out the submodules.

This isn't meant to be fit for general use, but it's handy for me to
have it available, and if it happens to be a useful reference to
someone then great.
