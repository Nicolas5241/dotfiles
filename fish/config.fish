if status is-interactive
    fastfetch
end
set fish_greeting
set PATH = "$PATH:/home/nicolas5241/.cargo/bin"

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"

set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
