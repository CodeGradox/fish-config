function ras --description="Start the rails server"
  set_color red
  echo "Starting rails server"
  set_color normal
  # foreman start --env=/dev/null -f Procfile.dev
  set -lx OVERMIND_SKIP_ENV true
  overmind start -f Procfile.dev
end
