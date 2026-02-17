# Setup fzf
# ---------
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/opt/fzf" ]]; then
  FZF_BASE="$HOMEBREW_PREFIX/opt/fzf"
elif [[ -d "$HOME/.fzf" ]]; then
  FZF_BASE="$HOME/.fzf"
elif [[ -d "/usr/share/doc/fzf/examples" ]]; then
  FZF_BASE="/usr/share/doc/fzf/examples"
fi

if [[ -z "$FZF_BASE" ]]; then
  echo "[.fzf.zsh] warning: fzf not found" >&2
else
  [[ "$PATH" != *"$FZF_BASE/bin"* ]] && export PATH="$FZF_BASE/bin:$PATH"

  # Auto-completion
  # ---------------
  [[ -f "$FZF_BASE/shell/completion.zsh" ]] && source "$FZF_BASE/shell/completion.zsh"

  # Key bindings
  # ------------
  [[ -f "$FZF_BASE/shell/key-bindings.zsh" ]] && source "$FZF_BASE/shell/key-bindings.zsh"
fi
