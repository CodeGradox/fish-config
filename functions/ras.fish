function ras --description="Start the rails server"
  set_color red
  echo "Starting rails server"
  set_color normal

  if test -f Procfile.dev
    overmind start -f Procfile.dev
  else
    overmind start
  end
end
