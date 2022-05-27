# Runs NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Setup neovim virtualenv
export NVIM_PYTHON="/usr/share/nvim/pyenv/bin/python3"

# Setup debugpy virtualenv
# export DEBUGPY_PYTHON="~/lib/python3/.virtualenvs/debugpy/bin/python3"

# Setup PATH
export PATH="$PATH:$(yarn global bin):~/.local/bin"

# Setup EDITOR and VISUAL
export VISUAL=nvim
export EDITOR=$VISUAL

[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
