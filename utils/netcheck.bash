#!/usr/bin/bash
#setup(){
# local var=val ...
_xdg_local=${XDG_LOCAL_DIR:-~/.local}
_datadir="${_xdg_local}/netcheck"
_name="$*" # location -- arg
_name=".${_name// /-}"
_name="netcheck.$(date +%FT%T%z)${_name}.out"
# tee ${_datadir}/${_name} /dev/stdout
#}
#setup


_ta () { 
    local VERBOSITY=0;
    for arg in "$@"; do case "$arg" in 
            -v) VERBOSITY=$((VERBOSITY+1)) ;;
    esac; done;
    declare -p VERBOSITY;
    echo "$@"
}
netcheck(){
  #local _xdg_local=${XDG_LOCAL_DIR:-~/.local/}
  #local _datadir="${_xdg_local}/netcheck/"
  #local _name=""
  # location / args
  local VERBOSITY=0;
  for arg in "$@"; do
    case "$arg" in 
      -v) VERBOSITY=$((VERBOSITY+1)) ;;
      *) _name+=".$arg"
    esac;
  done;
  #_name="netcheck.$(date +%FT%T%z)${_name}.out"
  # tee ${_datadir}/${_name} /dev/stdout

  verbose(){ [[ $(( $VERBOSITY )) -gt 0 ]] && echo "$*"; }

  #contexteval(){ echo -n "$1: "; eval "${@:2}";}
  #contexteval(){ eval "${@:2}" | sed -Ee "s/^/$1: /";}
  . ~/.env.ansi
  #contexteval(){ eval "timeout .5 ${@:2}" | while read line; do echo -ne "${_c[blue]}$1${_c[nc]}: "; echo "$line"; done;}
  #contextevalcolor(){ 
  contexteval(){ 
    _RED="$(tput setaf 1)"
    _GREEN="$(tput setaf 2)"
    OUT="$(eval "timeout .5 ${@:2}")" #| ifne -n echo '[none/timeout]'")"
    RET=$?
    ELSE="${_RED}[none/timeout]"
    (( $RET == 0 )) && COLOR="$(tput setaf 2)" || COLOR="$(tput setaf 1)"
    echo "$OUT" | while IFS='\n' read line; do
      echo -ne "${_c[blue]}$1${_c[nc]}: ";
      echo -ne "${COLOR}$line${_c[nc]}";
      (( $RET != 0 )) && echo -ne "${COLOR}$ELSE${_c[nc]}";
      echo
    done;
  }
  #contexteval(){ echoeval "$@"; } #(){ echo -e "${_c[blue]}$1${_c[nc]}: "; eval "${@:2}";}
  verbose "# end-to-end ip connectivity // not sensitive to DNS"
  contexteval "inet/wan/cf(v4)" fping -r0 1.1
  contexteval "inet/wan/cf(v6)" fping -r0 2606:4700:4700::1001
  verbose "# lan ip connectivity, checks wifi, local //"
  contexteval 'inet/lan/v4' fping _gateway -Amnr0 -4
  contexteval 'inet/lan/v6' fping _gateway -Amnr0 -6
  contexteval 'inet/lan' fping _outbound -Amnr0
  contexteval "inet/lan/gateway" fping -r0 $(ip r | grep default | cut -d' ' -f3)
  verbose "# configuration of dns, if connectivity works, DHCP'd recursive server down/slow or blocking of global dns / vpn"
  contexteval "dns/resolvectl dns" resolvectl dns
  verbose "# e2e check of dns"
  contexteval "dns/host noisebridge.net" host noisebridge.net
  contexteval "http/networkcheck.kde.org" curl -s http://networkcheck.kde.org/
}
#netcheck "$@"
netcheck "$@" | tee ${_datadir}/${_name} 
#netcheck "$@" | pee 'log... ${_datadir}/${_name}' cat

# Reference:
#2606:4700:4700::1001
#2606:4700:4700::1111
#1.1.1.1
#1.0.0.1

# Output format:
#   type/scope:test/target
#   [type:inet/dns/?] / [scope:wan/lan] : [test:ping/[q]uery/] / [tgt abbrev]
#   inet/wan:fping/cf
#   inet/lan:dns
# Orig format:
#   [scope]/[+specific]?/+[specific]?/[cmd]
# - scope: is the primary type of concern. inet/-reachability/routing. dns/lookup/errors/misconfiguration/blocking http/dns+inet+captive-portal test
