function fish_prompt --description="Custom terminal prompt"
    set -l directory (set_color cyan) (pwd | sed "s|^$HOME|~|") (set_color normal)

    # If there is a SSH session...
    if test -n "$SSH_CLIENT"
      echo -ns (set_color yellow) (whoami) '@' (hostname) ' (ssh)' (set_color normal) ' '
    end

    echo -ns [ $directory ] ' >'

    # Changes the color of the git prompt if there are changes if there are unstaged changes.
    if test (git status --porcelain 2>/dev/null | wc -l) -eq 0
        set -f git_status green
    else
        set -f git_status yellow
    end

    # result: (branch)
    echo -s (set_color $git_status) (__fish_git_prompt) (set_color normal) ' '
end
