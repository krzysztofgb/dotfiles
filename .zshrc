# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Some binaries install here (Claude Code)
export PATH="$HOME/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Disable Homebrew auto-updating
export HOMEBREW_NO_AUTO_UPDATE=1

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# add ~/.zsh_functions to fpath, and then lazy autoload
# every file in there as a function
fpath=( ~/.zsh_functions "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

# Mise config precedes others
eval "$(mise activate zsh)"

# Python config
alias poetry='noglob poetry'
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
PATH=$(pyenv root)/shims:/Users/krzysztofg/.local/bin:$PATH
export PYTHON_KEYRING_BACKEND=keyring.backends.fail.Keyring

# Go config
export PATH="$HOME/go/bin:$PATH"

# Java config
export JAVA_HOME=$(/usr/libexec/java_home)

# Roc config
export PATH="/opt/homebrew/opt/llvm@16/bin:$PATH"
export PATH="/usr/local/roc:$PATH"

eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias fuck)

alias nv="nvim"

# git-spice auto-completions
eval "$(gs shell completion zsh)"
