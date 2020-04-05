set fish_function_path $fish_function_path "/usr/share/powerline/fish"
powerline-setup


# Source global definitions
# if test /etc/bashrc
#   bash /etc/bashrc
# end

if test ~/.bash_aliases
  source ~/.bash_aliases
end

if test ~/.config/fish/key-bindings.fish
  source ~/.config/fish/key-bindings.fish
end
# User specific environment
set PATH "$HOME/.local/bin:$HOME/bin:$PATH"
set PATH "/opt/dependency-check/bin:$PATH"
set PATH "/opt/terraform/terraform_0.12.7_linux_amd64:$PATH"
set PATH "/opt/packer/bin/packer:$PATH"
set PATH "$HOME/.gem/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export HISTSIZE=""
alias gitconf_mics="git config --global user.name Koisell; git config --global user.email nfrancois@mediarithmics.com;git config --global push.default matching; echo GitHub"
export DEV_HOME=$HOME/dev
export PANTS_COURSIER_REPOS="+['https://nfrancois:mpessh-nexus@sf-nexus.mediarithmics.com/content/groups/global/']"
export GRALL_HOME="/opt/grallvm/graalvm-ce-1.0.0-rc12"
export GEM_PATH=(gem environment gempath)
export GEM_HOME=~/.gem
export SBT_OPTS="-Xmx2G -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2G -Xss2M  -Duser.timezone=GMT"
alias unset 'set --erase'
