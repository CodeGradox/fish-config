function ip-local-addr --description="Get the local IP address"
  ip address show enp9s0 | awk '/inet\s/ { print $2 }'
end

