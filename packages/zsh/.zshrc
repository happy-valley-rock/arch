# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

eval "$(starship init zsh)"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PATH=$PATH:/user/local/go/bin

setopt inc_append_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[ "$(tty)" = "/dev/tty1" ] && exec Hyprland

clear
P="\033[38;5;93m"
G="\033[38;5;82m"
R="\033[38;5;160m"
C="\033[0m"

echo -e "${R}              -*%@@=                :@@                 =@#                "
echo -e "${R}      @@@@@@%%#=.           =########%@@#######        #@@*************=   "
echo -e "${R}      @%                    *@+::::::-+=:::::::      .@@@=-@@=-%@=-#@*-:   "
echo -e "${R}      @@@@@@@@@@@@@@@       *@:  *@.  @#  +@.       *@*#@  %@  #@  +@.     "
echo -e "${R}      @@       %@.          *@:  @@   @#  @@         %%@@%%@@%%@@%%@@%%*   "
echo -e "${R}      @%       %@           *@. @@*@#.@#:@%#@#         #@. %@  #@  *@-     "
echo -e "${R}      @%       %@           #@#@#   %:@%@+   #@        #@  %@  #@  +@.     "
echo -e "${R}  %@@@@@@@@@@@@@@@@@@@-     @@ -%%%%%@@@%%%%%%      *@@@@@@@@@@@@@@@@@@@-  "
echo -e "${R}        %#    -@*           @#       :@%               +            :*     "
echo -e "${R}     =@@%       #@@*       *@-        @#              @@   @%   @@   @@    "
echo -e "${R}  +@@%.            %@%    :@# @@@@@@@@@@@@@@@@@.    :@@    @@   *@-   %@-  "
echo -e "${C}"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="cypher"
# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="mm/dd/yyyy"
HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Docker shortcuts
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcb='docker compose build'
alias dcl='docker compose logs -f'
alias dce='docker compose exec'
alias dps='docker ps'
alias di='docker images'
alias drm='docker rm $(docker ps -aq)'
alias drmi='docker rmi $(docker images -q)'
alias dst='docker stats'
alias dprune='docker system prune -af --volumes'
alias dpss='docker ps --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}"'

# NeoVim shortcuts
alias nv='nvim'

# Github shortcuts
alias g='git'
alias gst='git status'
alias gco='git checkout'
alias gbr='git branch'
alias gcm='git commit -m'
alias glast='git log -1 HEAD'
alias glg='git log --oneline --graph --decorate --all'
alias gsh='git push'
alias gshup='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD | grep HEAD)'
alias gadd='git add .'

# Arch alias
alias update-all='sudo pacman -Syu && yay -Sua && sudo snap refresh'
alias update-all-clean='sudo pacman -Syu && yay -Sua && sudo snap refresh && sudo pacman -Rns $(pacman -Qtdq) && yay -Sc --noconfirm'

# Disown process
alias spotify='spotify & disown'
alias telegram='telegram-desktop & disown'
alias notion='brave notion.so & disown'
alias gpt='brave chatgpt.com & disown'
alias browser='brave & disown'
alias steam='steam & disown'
alias discord='discord & disown'




