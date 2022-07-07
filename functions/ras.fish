function ras --description="Start the rails server"
  set_color red
  echo "Starting rails server -b 0.0.0.0"
  set_color normal
  bundle exec rails server -b 0.0.0.0
end
