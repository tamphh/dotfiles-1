# Path to your oh-my-zsh installation.
# To install it:
# git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# ruby & rails for development to /home
# need: mkdir -p ~/.gems/bin
# export GEM_HOME=/home/user/.gems
# export GEM_PATH=/home/user/.gems:/usr/lib64/ruby/gems/2.3.0/gems/
# export PATH=$PATH:/home/user/.gems/bin
# export RB_USER_INSTALL='true'

# Themes in ~/.oh-my-zsh/themes/
# Optionally, you can set ZSH_THEME="random" to find new theme.
ZSH_THEME="skaro"

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
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS=-Djava.io.tmpdir=/var/tmp

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
    LESS_TERMCAP_mb=$'\e[0;31m' \
        LESS_TERMCAP_md=$'\e[01;35m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;31;31m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[0;36m' \
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

# Function for upload file to https://transfer.sh/
# Use : $ transfer hello.txt
transfer() { 
    torIp=127.0.0.1
    torPort=9050

    if [ $# -eq 0 ]; then 
        echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; 
        return 1; 
    fi 
    tmpfile=$( mktemp -t transferXXX ); 
    if tty -s; then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); 
        curl --socks5-hostname ${torIp}:${torPort} --retry 3 --connect-timeout 60 --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; 
    else 
        curl --socks5-hostname ${torIp}:${torPort} --retry 3 --connect-timeout 60 --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; 
    fi;
    cat $tmpfile; 
    rm -f $tmpfile; 
}
