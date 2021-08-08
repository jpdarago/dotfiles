# Enable emacs (-e) or vi (-v) keymap.
bindkey -e

# Export environment variables.
export TERMINAL='sakura'
export EDITOR='vim'
export SUDO_EDITOR='vim'
export PAGER='less'
export TERM='screen-256color'
export GPG_TTY=$TTY

# Extend PATH.
if [[ -f "~/nodejs/bin" ]]; then
    path+=(~/nodejs/bin)
fi

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots  # glob matches files starting with dot; `ls *` becomes equivalent to `ls *(D)`
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# History options
HISTSIZE=1000000000
SAVEHIST=1000000000

# FZF options
export FZF_DEFAULT_COMMAND='rg --files --hidden'
