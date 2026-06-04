# CUSTOM PROMPT
# This prompt has the formatted as: White bold folder, optional red root, and an arrow
# This cannot run by itself, it must be sourced from .zshrc

# -------- detect shell --------
if [ -n "$ZSH_VERSION" ]; then
    ###############
    #   Z S H     #
    ###############

    setopt prompt_subst
    PROMPT='$(prompt_connection)$(prompt_multiplexer)%F{#ffffff}%B$(prompt_directory)%b%f %(#.%F{red}%B(root)%b%f .)❯ '

    prompt_connection() {
        local connection_type=""

        # Detect "not local" contexts
        if [[ -n $SSH_CONNECTION || -n $SSH_CLIENT || -n $SSH_TTY ]]; then
            connection_type="SSH"
        elif [[ -n $MOSH_IP_REMOTE ]]; then
            connection_type="MOSH"
        elif [[ -f /.dockerenv || -n $container ]]; then
            connection_type="CONTAINER"
        elif [[ -n $VSCODE_AGENT_FOLDER || -n $CLOUD_ENV || -n $CODESPACES ]]; then
            connection_type="TUNNEL"
        fi


        if [[ -n $connection_type ]]; then
            printf '%s' "%F{#ff0000}${connection_type}%f⇢%F{#ffff00}%B%m%b%f "
        else
            printf '%s' ""
        fi
    }

    prompt_multiplexer() {
        local tag=""
        if [[ -n $TMUX ]]; then
            if [[ -n $TMUX_PANE ]]; then
                local pane_id=${TMUX_PANE#%}
                printf '%s' "%F{#008EFF}TMUX%f⇢%F{#ffff00}${pane_id}%f "
            else
                printf '%s' "%F{#008EFF}TMUX%f "
            fi
        elif [[ -n $STY ]]; then
            printf '%s' "%F{#008EFF}SCREEN%f "
        fi
    }

    prompt_directory() {
        case $PWD in
            /)             printf '/';;                     # exactly “/”
            "$HOME")       printf '~';;                     # exactly “$HOME”
            "$HOME"/*/*/*) printf '~/.../%s/' "${PWD:t}";;  # ≥3 levels under home  → “~/…/leaf/”
            "$HOME"/*/*)   printf '~/%s/' "${PWD#$HOME/}";; # exactly 2 levels under home → “~/dir1/dir2/”
            "$HOME"/*)     printf '~/%s/' "${PWD:t}";;      # one level under home → “~/dir/”
            /*/*/*)        printf '/.../%s/' "${PWD:t}";;   # ≥3 levels under root → “…/leaf/”
            /*/*)          printf '%s/' "$PWD";;            # exactly 2 levels under root → “/dir1/dir2/”
            /*)            printf '%s/' "$PWD";;            # single top-level dir → “/etc/”  
        esac
    }

elif [ -n "$BASH_VERSION" ]; then
    ###############
    #   B A S H   #
    ###############
  
fi