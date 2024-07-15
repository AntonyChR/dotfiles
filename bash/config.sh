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

#PS1='\e[34m[ \w ] \e[0m\e[38;5;166m$(git_info)\e[39m\n\e[38;5;197m$\e[0m '
PS1='\[\e[34m\][ \w ] \[\e[0m\]\[\e[38;5;166m\]$(git_info)\[\e[39m\]\n\[\e[38;5;197m\]$\[\e[0m\] '


# public paths 
export PATH=$PATH:/home/$USER/config/scripts
export PATH=$PATH:/home/$USER/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/$USER/go/bin
export PATH=$PATH:/usr/sbin
export PATH="$PATH:/home/$USER/node/bin"
export PATH="$PATH:/home/$USER/.local/bin"

# constants
export EDITOR=vim

#Custom aliases
alias stopContainers='docker stop $(docker ps -q)'

alias gst='git status -s'
alias gadd='git add .'
alias gcom='git commit'
alias glog='git log --oneline'

alias res='source ~/.bashrc'

alias fe='dolphin'

export FZF_DEFAULT_OPTS='--color=bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672'
alias f='fzf --bind "enter:become($EDITOR {})" --height 90% --layout reverse --border --preview "bat --color=always {}"'
alias cl='clear'
alias vi='vim'
alias cd..='cd ..'
alias ll='lsd -l -F --hyperlink auto --color auto'
alias rmf='rm -rf'
alias show='gwenview'

alias tree='gio tree'
alias trash='gio trash'

alias trans='~/config/scripts/tr.sh'

alias perm='echo -e "[0] No permission\n[1] Exec\n[2] Write\n[4] Read"'

alias off="sudo shutdown now"
alias server="hostname -I && python3 -m http.server 3000"
