function rat --description="Run rails tests"
  set_color red
  echo "Running rails tests"
  set_color normal
  set -lx RAILS_ENV test
  bin/rails test $argv
end
