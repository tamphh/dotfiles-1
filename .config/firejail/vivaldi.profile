# Firejail profile for vivaldi
# This file is overwritten after every install/update
# Persistent local customizations
include /etc/firejail/vivaldi.local
# Persistent global definitions
include /etc/firejail/globals.local

noblacklist ${HOME}/.cache/vivaldi
noblacklist ${HOME}/.config/vivaldi

include /etc/firejail/disable-common.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-programs.inc

mkdir ${HOME}/.cache/vivaldi
mkdir ${HOME}/.config/vivaldi
whitelist ${HOME}/downloads
whitelist ${HOME}/.cache/vivaldi
whitelist ${HOME}/.config/vivaldi
include /etc/firejail/whitelist-common.inc
include /etc/firejail/whitelist-var-common.inc

caps.keep sys_chroot,sys_admin
netfilter
nodvd
#nogroups - block alsa 
#seccomp
noroot
notv
shell none
protocol unix,inet,netlink
dns 127.0.0.1

disable-mnt
private-dev
private-tmp

noexec ${HOME}
noexec /tmp
