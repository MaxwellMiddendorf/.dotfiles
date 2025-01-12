if status is-interactive
    # Commands to run in interactive sessions can go here
end
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
set fish_greeting

fish_vi_key_bindings
