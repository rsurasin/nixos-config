# Starship Configuration
starship init fish | source

# Globals
# Global LANG
set -gx LANG en_US.UTF-8
# Global Editor
set -gx VISUAL nvim
set -gx EDITOR $VISUAL

# Remove Greeting 
set -U fish_greeting

# manpage
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# fzf
set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --cycle --preview-window=wrap --marker='*' --no-mouse --bind='ctrl-n:down,ctrl-p:up'"
set -x FZF_DEFAULT_COMMAND "fd --type f"
set -x FZF_CTRL_T_COMMAND "fd"
set -x FZF_ALT_C_COMMAND "fd -a --type d --base-directory $HOME"

# fzf keybindings
fzf_key_bindings

# alias
alias fz "fd --type f | fzf --height 40% --layout=reverse --border --cycle --preview-window=wrap --marker='*' --no-mouse --preview 'bat --style=numbers --color=always --line-range :500 {}' --bind='ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up,ctrl-o:toggle-preview,ctrl-n:down,ctrl-p:up,ctrl-y:execute-silent(echo -n {} | pbcopy)'"

# functions
function nvf
    set fn (fz) || return
    nvim "$fn"
end

# BUG: fd is slow - https://github.com/sharkdp/fd/issues/599
function cdf
    set dir (fd -a --type d --base-directory $HOME | fzf --height 40% --layout=reverse --border --cycle) || return
    cd "$dir"
end

# abbreviations
abbr -a cl "clear -x"
abbr -a nv "nvim"
abbr -a l "eza"
abbr -a ll "eza -l"
abbr -a lll "eza -la"
abbr -a g "git"
abbr -a ga "git add -p"
abbr -a gc "git checkout"
abbr -a gs "git status"
abbr -a gcm "git commit -m"

