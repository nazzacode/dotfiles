# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# --- oh my? ---
HYPHEN_INSENSITIVE="true"  # hyphen-insensitive completion. 
ENABLE_CORRECTION="true" # auto-correction.
COMPLETION_WAITING_DOTS="true"

# --- Plugins ---
# Standard plugins: $ZSH/plugins/ , custom plugins: $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

#source $ZSH/oh-my-zsh.sh

# --- Path ---
path+=('~/.emacs.d/bin')
export PATH=/home/nathan/.emacs.d/bin:$PATH

export PATH

# Man PAges
# export MANPATH="/usr/local/man:$MANPATH"

# vi-mode
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

# --- Aliases ---
# For a full list of active aliases, run `alias`.
alias vim="nvim"

alias ..='cd ..'
alias ...='cd ../..'

# package mangagment

alias sps='sudo pacman -S'
alias spsyu='sudo pacman -Syu'
alias spss='sudo pacman -Ss'
alias yay='yay --noconfirm'
alias yayss='yay -Ss'

# make and move into direcotry
mkcd () { mkdir -p $1; cd $1 }

alias pls='sudo !!'

alias yeet="rm -rf"

alias cl='clear'

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
source /home/nathan/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/nathan/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
