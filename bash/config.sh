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
export TERM=kitty

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

alias server="hostname -I && python3 -m http.server 3000"
alias re="redis-cli"
alias tempdir="cd $(mktemp -d)"
alias md="glow -w 100 -p"
alias scan-repo="trufflehog git file://. --only-verified --no-update" # scans the current directory for secrets


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
#export NODE_OPTIONS="--max-old-space-size=4096"
export ANDROID_HOME=~/Android/Sdk
export ANDROID_NDK_HOME=~/Android/Sdk/ndk/29.0.13113456
export PATH=$PATH:~/Android/Sdk/platform-tools
export PATH=$PATH:~/Android/Sdk/emulator
export PATH=$PATH:~/Android/Sdk/build-tools/35.0.1

export PATH=$PATH:/opt/kotlinc/bin
export PATH=$PATH:/opt/gradle/gradle-8.13/bin

alias telegram="~/Descargas/Telegram/Telegram"

alias studio="/opt/android-studio/bin/studio"

alias idea="/opt/idea/bin/idea"

alias wind="windsurf"

