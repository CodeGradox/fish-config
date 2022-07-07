function gco --description "Helper for checking out branches."
  git rev-parse --git-dir > /dev/null 2>&1
  if test $status -ne 0
    echo "Folder is not a git repository."
    return 1
  end
  if set -q argv[1]
    git switch $argv[1]
  else
    git switch (git branch -r | sd 'origin/' '' | fzf | awk '{ print $1 }')
  end
end
