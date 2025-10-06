#!/usr/bin/env bash

VIRTUAL_ENV=$HOME/venvs/newenv

# Activate the venv
source "$VIRTUAL_ENV/bin/activate"

# Save current history to venv-specific file
export _OLD_VIRTUAL_HISTFILE="$HISTFILE"
export HISTFILE="$VIRTUAL_ENV/.bash_history"
# export HISTFILE="$HOME/.bash_history.$(basename "$VIRTUAL_ENV")"

[ -f "$HISTFILE" ] || touch "$HISTFILE"
history -c
history -r "$HISTFILE"

# Auto-save after every command
# PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Save the original deactivate function under a different name
if declare -F deactivate >/dev/null; then
    eval "deactivate_orig() $(declare -f deactivate | tail -n +2)"
fi

# Override deactivate
deactivate() {
    # Save history
    history -a
    # Restore old HISTFILE if set
    if [ -n "${_OLD_VIRTUAL_HISTFILE:-}" ]; then
        HISTFILE="$_OLD_VIRTUAL_HISTFILE"
        unset _OLD_VIRTUAL_HISTFILE
    fi
    # Call original deactivate logic
    if declare -F deactivate_orig >/dev/null; then
        deactivate_orig "$@"
    fi
}

