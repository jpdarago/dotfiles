source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/zsh-syntax-highlighting/zsh-syntax-hilighting.zsh
source ~/zsh-autosuggestions/zsh-autosuggestions.zsh

# No world writable files please.
umask o-w

# Export environment variables.
export TERMINAL='sakura'
export EDITOR='vim'
export SUDO_EDITOR='vim'
export PAGER='less'
export GPG_TTY=$TTY

# History options
HISTSIZE=1000000000
SAVEHIST=1000000000

# FZF options
export FZF_DEFAULT_COMMAND='rg --files'

# Path
path=(~/bin $path)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
