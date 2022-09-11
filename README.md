# My Vim Files

Quick Vim setup based on https://github.com/junegunn/vim-plug for customization.
This setup is working on MacOS but should be easily adjusted to Linux distros too.


### Installation

Four quick steps and you should be good to go

#### 1) OPTIONAL: Fzf installation

We can leverage Fzf inside vim which is one of the plugins configured in this vimrc.
To install Fzf follow these steps:

```
brew install fd
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install fzf
$(brew --prefix)/opt/fzf/install!
```

#### 2) Clone the repo in your home directory

```
cd ~ && git clone https://github.com/djlebersilvestre/vim.git && mv vim/ .vim/
```

#### 3) Open Vim (which should already have a nice layout with the new vimrc)

```
vim
```

#### 4) Install plugins

Go to command mode (press escape key) and call the function below:

```
:PlugInstall
```

Voilà. Vim should be ready to edit whatever
