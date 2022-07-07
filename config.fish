# Global environment variables.
set -gx FZF_DEFAULT_COMMAND 'fd -t f --hidden -E ".git"'
set -gx EDITOR 'nvim'
set -gx RAILS_ENV 'development'
# Used by certain Rails tasks
set -gx THOR_MERGE "nvim -d"
# Variable used by ikbygg-web to find the wkhtmltopdf binary.
set -gx BAT_THEME 'OneHalfLight'
# This is where n (node version manager) will install the node binaries.
# Make sure that $HOME/b/bin is present in the $PATH.
# npm i -g n
set -gx N_PREFIX "$HOME/n"
# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed
# and these are never upgraded. To link Rubies to Homebrew's OpenSSL 1.1 we use
# this variable.
set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@1.1)"

# Load aliases.
source $HOME/.config/fish/aliases.fish

# Colors.
set fish_color_autosuggestion grey
set fish_pager_color_prefix brred
set fish_pager_color_completion --bold brblack

# Load rbenv
if status --is-interactive
  source (rbenv init -|psub)
end

# Enable FZF keybindings.
function fish_user_key_bindings
  fzf_key_bindings
end

# Disables the default fish greeting.
set fish_greeting
