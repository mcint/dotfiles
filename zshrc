# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' prompt 'Dist %e'
zstyle :compinstall filename '/home/xenon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
#HISTFILE=~/.histfile
HISTFILE=~/".local/share/zsh/history/zsh.$(date +%F).$$.$RANDOM.log"
HISTSIZE=100000
SAVEHIST=1000000
setopt notify
bindkey -e
# End of lines configured by zsh-newuser-install
