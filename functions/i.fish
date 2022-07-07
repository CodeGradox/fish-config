function i --description "Install packages with brew"
  if count $argv > /dev/null
    brew install $argv
  else
    brew update; and brew upgrade
  end
end
