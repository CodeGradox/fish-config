function fish_prompt --description="Custom terminal prompt"
    set -l directory (set_color '#4DA5FF') (pwd | sed "s|^$HOME|~|") (set_color normal)
    set -l chevron (set_color '#A3C1D7') ' >'

    # If there is a SSH session...
    if test -n "$SSH_CLIENT"
      echo -ns (set_color '#FF748C') (whoami) '@' (hostname) ' (ssh)' (set_color normal) ' '
    end

    # result: [current directory] >
    echo -ns [ $directory ] $chevron

    # Changes the color of the git prompt if there are changes if there are
    # unstaged changes.
    if test (git status --porcelain 2>/dev/null | wc -l) -eq 0
        set -f git_status '#6DA08C'
    else
        set -f git_status yellow
    end

    # result: (branch)
    echo -s (set_color $git_status) (__fish_git_prompt) (set_color normal) ' '
end
