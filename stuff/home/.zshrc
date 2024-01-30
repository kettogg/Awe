# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep
# bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/re1san/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Add Starship
eval "$(starship init zsh)"

# Alias
alias ls="ls --color=auto"
#alias l="eza"
#alias la="eza -l"
alias nf="neofetch"
alias dev="cd ~/Dev"
alias lia="cd ~/Dev/Lia"
alias muse="cd ~/Dev/MuseScore"
alias v="nvim"
alias freem="sudo sh -c 'echo 1 >  /proc/sys/vm/drop_caches'"
alias param="ssh-keygen -R paramganga.iitr.ac.in && ssh -p 4422 dhruv_s.iitr@paramganga.iitr.ac.in"

export PATH=/home/re1san/.local/bin:$PATH
export PATH=/home/re1san/.luarocks/bin:$PATH
# Julia <3
export PATH=/home/re1san/julia-1.9.4/bin:$PATH
export PATH=/home/re1san/Qt/5.15.2/gcc_64/bin:$PATH
# Plugins
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Startup
nf
#fetch

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export LUA_PATH='/usr/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua;/usr/share/lua/5.4/?/init.lua;/usr/local/lib/lua/5.4/?.lua;/usr/local/lib/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/re1san/.luarocks/share/lua/5.4/?.lua;/home/re1san/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/local/lib/lua/5.4/?.so;/usr/lib/lua/5.4/?.so;/usr/local/lib/lua/5.4/loadall.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/re1san/.luarocks/lib/lua/5.4/?.so'
#export PATH='/home/re1san/julia-1.9.4/bin:/home/re1san/.luarocks/bin:/home/re1san/.local/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl'

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/re1san/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
