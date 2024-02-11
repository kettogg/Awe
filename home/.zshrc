# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
# setopt autocd beep
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
alias nf="neofetch"
alias dev="cd ~/Dev"
alias lia="cd ~/Dev/Lia"
alias muse="cd ~/Dev/MuseScore"
alias v="nvim"
alias freem="sudo sh -c 'echo 1 >  /proc/sys/vm/drop_caches'"
alias param="ssh-keygen -R paramganga.iitr.ac.in && ssh -p 4422 dhruv_s.iitr@paramganga.iitr.ac.in"

# Path
export PATH=/home/re1san/.local/bin:$PATH
export PATH=/home/re1san/Qt/5.15.2/gcc_64/bin:$PATH
export PATH=/home/re1san/Qt/Tools/QtCreator/bin:$PATH

# Plugins
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

