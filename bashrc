alias l="ls -lh"
alias la="ls -lha"

bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

alias cs="emacsclient -nw"
alias wcs="emacsclient -nc"

acs() {
    if [ $# -lt 1 ]; then
        echo "Usage: acs filename"
        echo "Sets VIRTUAL_ENV environment variable to PYVENV emacs variable and opens the file using emacsclient"
        return 1
    fi

    local filename=$1

    # Split into name and value
    local var_name="PYVENV"
    local var_value=$VIRTUAL_ENV

    # Escape double quotes for Elisp string
    #local elisp_value=$(printf '%s' "$var_value" | sed 's/"/\\"/g')

    emacsclient -nw -e "(progn (setenv \"${var_name}\" \"${var_value}\") (find-file \"${filename}\"))"
}
