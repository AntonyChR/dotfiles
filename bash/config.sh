git_info(){
  branch="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/')"

  cached="$(git diff --name-only --cached 2> /dev/null | wc -l)"
  isCached=" \e[92m[${cached}]"
  if [ $cached == "0" ]; then
    isCached=""
  fi

  modifications="$(git diff --name-only 2>/dev/null | wc -l)"
  isModificated=" \e[91m[${modifications}]"
  if [ $modifications == "0" ]; then
    isModificated="" 
  fi

  syncRemote="$(git status -sb 2>/dev/null | grep "adelante" | wc -l)"
  remote=" "
  if [ $syncRemote == "0" ]; then
    remote=""
  fi
  echo -e "${branch}${remote}${isModificated}${isCached}"
}

PS1='\e[34m\w \e[0m\e[38;5;166m$(git_info)\n\[\033[0;32m\] ▶\[\033[0m\] '

# public paths 
export PATH=$PATH:/home/ivan/config/scripts
export PATH=$PATH:/home/ivan/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/ivan/go/bin
export PATH=$PATH:/usr/sbin
export PATH="$PATH:/home/ivan/node/bin"
export PATH="$PATH:/home/ivan/.local/bin"

#Custom aliases
alias stopContainers='docker stop $(docker ps -q)'

alias gst='git status -s'
alias gadd='git add .'
alias gcom='git commit -m'
alias glog='git log --oneline'
alias gsync='git push --all'
alias res='source ~/.bashrc'

alias fe='dolphin'
alias cl='clear'
alias vi='vim'
alias cd..='cd ..'
alias ll='lsd -l -F --hyperlink auto --color auto'
alias rmf='rm -rf'
alias restoreKeyboard='xset r rate 220 40'
alias show='gwenview'

alias connected='cat /sys/class/net/wlp2s0/operstate'

alias tree='gio tree'
alias trash='gio trash'

alias trans='~/config/scripts/tr.sh'

alias perm='echo -e "[0] No permission\n[1] Exec\n[2] Write\n[4] Read"'

alias off="sudo shutdown now"
alias server="hostname -I && python3 -m http.server 3000"
