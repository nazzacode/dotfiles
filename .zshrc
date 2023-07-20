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
ZSH_THEME="lukerandall"

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
# path+=('~/.emacs.d/bin') # new syntax? something wrong?

PATH=/home/nathan/.emacs.d/bin:$PATH
PATH=/usr/bin/pip:$PATH
PATH=~/.cargo/bin:$PATH

export PATH

# PYTHONPATH


# - Aliases -
# make and move into direcotry
mkcd () { mkdir -p $1; cd $1 }

# common
alias ...='cd ../..'
alias pls='sudo !!'
alias yeet="rm -rf"
alias cl='clear'

# package managment
alias sps='sudo pacman -S'
alias spsyu='sudo pacman -Syu'
alias spss='sudo pacman -Ss'
# alias yay='yay --noconfirm'
alias yayss='yay -Ss'

# Programs
alias vivaldi='vivaldi-stable'
alias vim='nvim'

alias wn='dict-wn'

# Variables 
RUST_SRC_PATH='/home/nathan/.rustup/toolchains/stable-x86_64-unknown-linux-gnu'

# Souce oh-my-zsh
source $ZSH/oh-my-zsh.sh


# Starship prompt
# eval "$(starship init zsh)"

# fortune-mod (quote)
fortune


[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/nathan/google-cloud-sdk/path.zsh.inc' ]; then . '/home/nathan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/nathan/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/nathan/google-cloud-sdk/completion.zsh.inc'; fi
