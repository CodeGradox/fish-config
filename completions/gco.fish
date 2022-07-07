# Completions for the gco.fish function.

function __fish_gco_remote_branches
  # Check if we are in a git directory.
  git rev-parse --is-inside-work-tree > /dev/null 2>&1
  if test $status -eq 0
    git branch | sd '^[\s\*]*' ''
  end
end

# Tab completion. Show git branches.
complete -f -c gco -n "__fish_use_subcommand" -a "(__fish_gco_remote_branches)"
