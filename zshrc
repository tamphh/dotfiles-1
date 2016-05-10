# copy in ~/.zshrc
#
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#export WINEDLLOVERRIDES='winemenubuilder.exe=d'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nanotech"

# Example aliases
alias wk='cd ~/projects/satie-viewer/'
alias satie='GTK_THEME=Adwaita:dark ~/bin/satie'
alias metasploitable='qemu-system-i386 --enable-kvm -cpu host -net nic,macaddr=00:11:22:33:44:55 ~/virtual\ machine/Metasploitable/Metasploitable.vmdk'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-prompt)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/lib64/node_modules:$PATH

# You may need to manually set your language environment
export LANG=fr_FR.UTF-8
export EDITOR='vim'

#source <(envoy -p)

# ssh
export SSH_KEY_PATH="~/.ssh/id_ed25519"

unset GREP_OPTIONS
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)" 

export GPG_TTY=$(tty)

#source ~/.keychain/$HOST-sh
source ~/.keychain/$HOST-sh-gpg

export PASSWD=~/.passwords

pw() {
   cd "$PASSWD"
   if [ ! -z "$1" ]; then
      $EDITOR $(buildfile "$1")
      cd "$OLDPWD"
   fi
}
