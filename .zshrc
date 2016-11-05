# Work with oh-my-zsh
# download here if your distro doesn't have that
# https://github.com/robbyrussell/oh-my-zsh.git

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#export WINEDLLOVERRIDES='winemenubuilder.exe=d'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="random"

# Bindkey fr
#bindkey "\e[2~"  yank
#bindkey "\e[3~"  delete-char
#bindkey "\e[1~"  beginning-of-line
#bindkey "\e[4~"  end-of-line
#bindkey "\e[5~"  up-line-or-history
#bindkey "\e[6~"  down-line-or-history

# Fix bug .... with meteor
#alias meteor='LC_ALL=en_US.UTF-8 meteor'

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

plugins=(git git-prompt)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:$PATH
export PASSWD=~/.passwords
export GPG_TTY=$(tty)
export EDITOR='vim'

# You may need to manually set your language environment
#export LANG=fr_FR.UTF-8
#export LC_COLLATE="C"

test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)" 

buildfile() {
    if [[ "$1" == *.* ]]; then
        echo $1
    else
        if [ -e "$1" ]; then
            echo $1
        elif [ -e "$1".gpg ]; then
            echo "$1".gpg
        else 
            echo "$1".txt
        fi
    fi
}

pw() {
   cd "$PASSWD"
   if [ ! -z "$1" ]; then
      $EDITOR $(buildfile "$1")
      cd "$OLDPWD"
   fi
}
