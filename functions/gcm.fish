function gcm --description="shortcut for git commit"
  if test -z $argv
    git commit
  else
    git commit -m $argv
  end
end

