# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/nathan/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"

setopt auto_cd

HIST_STAMPS="dd.mm.yyyy"


export EDITOR='emacs'

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    fzf
    thefuck  # press ESC twice to correct
    vi-mode
    zsh-autosuggestions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting  # must be last
)


# - * - User configuration - * -

# export MANPATH="/usr/local/man:$MANPATH"


# PATH
path+=('~/.emacs.d/bin')
export PATH=/home/nathan/.emacs.d/bin:$PATH

export PATH


# - Aliases -
# make and move into direcotry
mkcd () { mkdir -p $1; cd $1 }

alias ...='cd ../..'
alias pls='sudo !!'
alias yeet="rm -rf"
alias cl='clear'

# package mangagment

alias sps='sudo pacman -S'
alias spsyu='sudo pacman -Syu'
alias spss='sudo pacman -Ss'
alias yay='yay --noconfirm'
alias yayss='yay -Ss'


# Souce oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Starship prompt
# eval "$(starship init zsh)"

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
