function rac --description="Start the rails console"
  set_color red
  echo "Starting rails console"
  set_color normal
  bin/docker console
end
