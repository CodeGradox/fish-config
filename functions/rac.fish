function rac --description="Start the rails console"
  set_color red
  echo "Starting rails console"
  set_color normal
  bundle exec rails console
end
