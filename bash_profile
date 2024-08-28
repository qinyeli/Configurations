# Note: Source bashrc from bash_profile; never source bash_profile from bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

################################# Alias of ls #################################
# Tags
# -a  do not ignore entities starting with .
# -A  do not ignore entities starting with .; but not list implied . and ..
# -C  list entries by columns
# -d  list directories themselves, not their contents
# -F  append indicator (one of */=>@|) to entries
# -h  (human readable) with -l/-s, print human readable sizes (e.g., 1K 234M 2G)
# -l  use a long listing format

alias ls='ls -Fh --color=auto'
alias l='ls'
alias la='ls -A'
alias lh='ls -ld .?*'
alias ll='ls -al'
alias t='tree'

################################ Alias of git ################################
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -v'
alias 'gc!'='git commit -v --amend'
alias gcl='git clone'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gl='git pull'
alias gps='git push'
alias gr='git remote'
alias grm='git rm'
alias gst='git status'

function gsync {
  git fetch upstream
  git checkout master
  git merge upstream/master
  git push origin master
}

################################ Alias of path ################################
alias ~='cd ~'
alias -- -='cd - > /dev/null'
alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
if [[ $BASH_VERSINFO -ge 4 ]]; then
  shopt -s autocd
fi

# mkdir recursively
alias mkdir='mkdir -pv'

############################### Prompt Settings ###############################
function prompt_command {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local RESETCOLOR="\[\e[00m\]"

  local SELECTED=$CYAN
  local SELECTED=$CYANBOLD

  local VIRTUAL=""
  if [ ! -z $VIRTUAL_ENV ];
    then VIRTUAL="(virtual) ";
    else VIRTUAL="";
  fi

  #export PS1="\u@\w\[$(tput sgr0)\]"
  # \u  username
  # \w  directory
  export PS1="\n$SELECTED\u $SELECTEDBOLD$VIRTUAL$SELECTED@ \w \
    $SELECTEDBOLD\$(git branch 2> /dev/null)\n $SELECTED[\#] → $RESETCOLOR"
}

PROMPT_COMMAND=prompt_command

############################ Modes manipulation ##############################
alias x+='chmod +x'
alias x-='chmod -x'

################################# Other alias #################################
alias count='ls | wc -l'
alias fuck='sudo $(history -p \!\!)'
alias mysudo='sudo -E env "PATH=$PATH"'
alias blaze='bazel'

function extract {
  if [ -z "$1" ]; then
    echo "Usage: extract <filename>"
  else
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xvjf $1    ;;
        *.tar.gz)    tar xvzf $1    ;;
        *.tar.xz)    tar xvJf $1    ;;
        *.lzma)      unlzma $1      ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar x -ad $1 ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xvf $1     ;;
        *.tbz2)      tar xvjf $1    ;;
        *.tgz)       tar xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *.xz)        unxz $1        ;;
        *.exe)       cabextract $1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}

################################# Fun stuff! #################################
# Bash history settings
export HISTIGNORE='ls:la:lh:ll:l:tree:t'
export HISTSIZE=5000
export HISTFILESIZE=5000

############################### Setting default ###############################
export EDITOR=vim
export VISUAL=vim
