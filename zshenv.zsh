# Runs NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Setup neovim virtualenv
export NVIM_PYTHON="~/neovim/venv/bin/python3"

# Setup PATH
export PATH="$PATH:$(yarn global bin)"

# Setup EDITOR and VISUAL
export VISUAL=nvim
export EDITOR=$VISUAL
