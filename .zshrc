# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

_zshrc_warn() { print -P "%F{yellow}[.zshrc] warning: $1%f" >&2 }

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Some binaries install here (Claude Code)
export PATH="$HOME/.local/bin:$PATH"

# Homebrew - cross-platform init (sets HOMEBREW_PREFIX)
if [[ -f /opt/homebrew/bin/brew ]]; then                      # macOS Apple Silicon
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then                       # macOS Intel
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then       # Linux
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  _zshrc_warn "brew not found"
fi

# Disable Homebrew auto-updating
export HOMEBREW_NO_AUTO_UPDATE=1

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
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)" || _zshrc_warn "mise activation failed"
else
  _zshrc_warn "mise not found"
fi

# Python config
alias poetry='noglob poetry'
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init -)" || _zshrc_warn "pyenv init failed"
  export PATH="$(pyenv root)/shims:$PATH"
else
  _zshrc_warn "pyenv not found"
fi
export PYTHON_KEYRING_BACKEND=keyring.backends.fail.Keyring

# Go config
export PATH="$HOME/go/bin:$PATH"

# Java config
if [[ "$OSTYPE" == darwin* ]]; then
  if /usr/libexec/java_home &>/dev/null; then
    export JAVA_HOME=$(/usr/libexec/java_home)
  else
    _zshrc_warn "no Java runtime found (java_home)"
  fi
elif [[ "$OSTYPE" == linux* ]]; then
  if command -v java &>/dev/null; then
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
  else
    _zshrc_warn "java not found"
  fi
fi

# Node / nvm
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  \. "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
else
  _zshrc_warn "nvm not found"
fi

# Roc config
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/opt/llvm@16/bin" ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/llvm@16/bin:$PATH"
else
  _zshrc_warn "llvm@16 not found"
fi
export PATH="/usr/local/roc:$PATH"

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)" || _zshrc_warn "zoxide init failed"
else
  _zshrc_warn "zoxide not found"
fi

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  _zshrc_warn "fzf shell integration not found (~/.fzf.zsh)"
fi

# Powerlevel10k theme - try Homebrew first, then oh-my-zsh custom themes dir
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
elif [[ -f "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme"
else
  _zshrc_warn "powerlevel10k theme not found"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if command -v thefuck &>/dev/null; then
  eval $(thefuck --alias) || _zshrc_warn "thefuck alias setup failed"
  # You can use whatever you want as an alias, like for Mondays:
  eval $(thefuck --alias fuck)
else
  _zshrc_warn "thefuck not found"
fi

alias nv="nvim"

# git-spice auto-completions
if command -v gs &>/dev/null; then
  eval "$(gs shell completion zsh)" || _zshrc_warn "gs shell completion failed"
else
  _zshrc_warn "gs (git-spice) not found"
fi
