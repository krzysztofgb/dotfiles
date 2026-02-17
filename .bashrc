### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/krzysztofg/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

export HOMEBREW_NO_AUTO_UPDATE=1

# Node / nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
