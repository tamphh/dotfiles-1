# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Themes in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sunrise"

# Bindkey fr
#bindkey "\e[2~"  yank
#bindkey "\e[3~"  delete-char
#bindkey "\e[1~"  beginning-of-line
#bindkey "\e[4~"  end-of-line
#bindkey "\e[5~"  up-line-or-history
#bindkey "\e[6~"  down-line-or-history

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Plugin list in ~/.oh-my-zsh/plugins
plugins=(git git-prompt)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/bin:$PATH
export EDITOR='vim'
export GNUPGHOME="$HOME/.gnupg"
export SSH_KEY_PATH="~/.ssh/ssh_key"
export GPG_TTY=$(tty)
export PASSWD=~/.passwords

# With Zsh and Termite
if [[ $TERM == xterm-termite ]] ; then
    . /etc/profile.d/vte-2.91.sh
    __vte_osc7
fi

# With Bash and Termite
#if [[ $TERM == xterm-termite ]]; then
#    . /etc/profile.d/vte-2.91.sh
#    __vte_prompt_command
#fi

test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)" 

# man page with less
man() {
    LESS_TERMCAP_md=$'\e[01;35m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;31;31m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[00;36m' \
        command man "$@"
}

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
