# Mectov Linux - Fish Shell Configuration

# Starship prompt
if status is-interactive
    starship init fish | source
end

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias free='free -h'
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# Package management shortcuts
alias pac='sudo pacman'
alias pacs='sudo pacman -S'
alias pacr='sudo pacman -Rns'
alias pacu='sudo pacman -Syu'
alias pacq='pacman -Qs'
alias pacss='pacman -Ss'

# System
alias sysinfo='fastfetch'
alias reload='source ~/.config/fish/config.fish'

# Greeting
function fish_greeting
    fastfetch
end
