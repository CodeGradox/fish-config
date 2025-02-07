function create --description="Create a new file inside a directory"
  for arg in $argv[1..-1]
    set -l dir (dirname $arg)
    set -l file (basename $arg)

    mkdir -p $dir 
    touch $dir/$file
  end
end
