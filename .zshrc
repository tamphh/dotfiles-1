# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#export WINEDLLOVERRIDES='winemenubuilder.exe=d'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nanotech"

# Bindkey fr
bindkey "\e[2~"  yank
bindkey "\e[3~"  delete-char
bindkey "\e[1~"  beginning-of-line
bindkey "\e[4~"  end-of-line
bindkey "\e[5~"  up-line-or-history
bindkey "\e[6~"  down-line-or-history

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias wk='cd ~/projects/satie-viewer/'
alias satie='GTK_THEME=Adwaita:dark ~/bin/satie'
alias metasploitable='qemu-system-x86_64 --enable-kvm -cpu host -net nic,macaddr=52:54:22:00:11:22 ~/virtual\ machine/Metasploitable/Metasploitable.vmdk'

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

plugins=(git git-prompt)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/lib64/node_modules:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=fr_FR.UTF-8
export EDITOR='vim'

#source <(envoy -p)

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

unset GREP_OPTIONS
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)" 

export GPG_TTY=$(tty)
#keychain --agents "ssh,gpg" id_ed25519 0x63CBFF51DD6C3FA6
#source ~/.keychain/$HOST-sh
source ~/.keychain/$HOST-sh-gpg

export PASSWD=~/.passwords

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
