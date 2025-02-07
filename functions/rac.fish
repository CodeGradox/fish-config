function rac --description="Start the rails console"
  set_color red
  echo "Starting rails console"
  set_color normal
  bin/rails c
  #bin/docker console
end
