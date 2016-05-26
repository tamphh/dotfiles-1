export PANEL_FIFO="/tmp/panel-fifo"
export http_proxy="http://localhost:8118"
export https_proxy=${http_proxy}
export ftp_proxy=${http_proxy}
export rsync_proxy=${http_proxy}
export no_proxy="localhost,127.0.0.1,localaddress,localdomain.com"
export MPD_PORT="6600"
keychain --clear --agents "ssh,gpg" ssh1 ssh2 0xgpgkey
[ -z "$HOSTNAME" ] && HOSTNAME=$(uname -n)
[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
   . $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
   . $HOME/.keychain/$HOSTNAME-sh-gpg
