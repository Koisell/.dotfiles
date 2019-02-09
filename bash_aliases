#Alias de script
export EDITOR="/bin/vimx"

#alias script bash
alias cmd=". ~/.MyScript/cmd.sh"

#alias python
alias ChaineTwitch="~/.MyScript/Python/getChannelInfo.py"
#Fin script

#alias Alias
alias clean="tput reset"
alias yolo="ping -c 10 "
alias hunt="ps -aux | grep "
alias ouvrir="gnome-open "
alias la="ls -la"
alias rmi="rm -i "
alias reload_alias="source ~/.bash_aliases"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ping="prettyping --nolegend"
alias cat="bat"
alias ls="exa"
alias gbt="JAVA_HOME=/opt/graalvm-1.0.0-rc1 sbt"
alias vi="vimx"
alias vim="vimx"

#Alias streamlink
alias liveZerator="firefox twitch.tv/zerator/chat; streamlink twitch.tv/zerator "
alias liveMV="firefox twitch.tv/mistermv/chat; streamlink twitch.tv/mistermv source;"
alias vlcZerator="streamlink twitch.tv/zerator "

# Alias lié au git.
alias gitconf_insa="git config --global user.name nfrancois; git config --global user.email nicolas.francois@insa-rouen.fr;git config --global push.default matching; echo GitInsa"
alias gitconf_github="git config --global user.name Koisell; git config --global user.email koisell.dev@gmail.com;git config --global push.default matching; echo GitHub"
alias commit="git commit -am"
alias gadd="git add"
alias gadd_all="git add --all"
alias gpush="git push"
alias gpull="git pull"
