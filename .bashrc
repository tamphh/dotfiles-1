# With Bash and Termite
if [[ $TERM == xterm-termite ]]; then
    . /etc/profile.d/vte-2.91.sh
    __vte_prompt_command
fi

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}
