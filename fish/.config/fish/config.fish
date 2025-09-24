# ~/.config/fish/config.fish
set -x DISPLAY :0
set -gx PATH /usr/sbin $HOME/.local/bin $PATH

bind \cd 'commandline -f repaint'
set -g fish_exit_on_eof 0

alias ff="fastfetch --config ~/.config/fastfetch/config.jsonc"
alias c="clear"
alias r="source ~/.config/fish/config.fish"
alias rb="source ~/.config/fish/conf.d/bobthefish.fish"
alias cbonsai="cbonsai --life 40 --multiplier 5 --time 20 --screensaver"
#alias cdd="cd ~/Desktop/"
#alias cdc="cd ~/.config/"
alias i3rs="xrdb -merge ~/.Xresources; i3-msg restart"
alias msteam="nohup /home/muxee/.millennium/start.sh & disown"
alias vim="nvim"

# Use fd for fuzzy finding
eval "$(fzf --fish)"
set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type d --hidden --strip-cwd-prefix --exclude .git"
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=default --border --color=hl:#2dd4bf"

# function to open obsidian
function obsidian
    i3-msg mark obsidian_launcher
    ~/AppImages/Obsidian-1.8.10.AppImage --no-sandbox --disable-gpu & disown
    sleep 1
    i3-msg [con_mark="obsidian_launcher"] kill
end

# function to open mechvibes
function keyboard
    i3-msg mark mech_launcher
    ~/AppImages/Mechvibes-2.3.6-hotfix.AppImage --no-sandbox --disable-gpu & disown
    sleep 1
    i3-msg [con_mark="mech_launcher"] kill
end


# Vi keybindings (enables ESC and modes)
fish_vi_key_bindings

fish_add_path ~/.millennium/ext/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/share/solana/install/active_release/bin
fish_add_path ~/.scripts

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    if builtin functions --query cd
        builtin functions --copy cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

if test -z $__zoxide_z_prefix
    set __zoxide_z_prefix 'z!'
end
set __zoxide_z_prefix_regex ^(string escape --style=regex $__zoxide_z_prefix)

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if set -l result (string replace --regex $__zoxide_z_prefix_regex '' $argv[-1]); and test -n $result
        __zoxide_cd $result
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (commandline --current-process --tokenize)
    set -l curr_tokens (commandline --cut-at-cursor --current-process --tokenize)

    if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(commandline --cut-at-cursor --current-token) | string match --regex '.*/$'
    else if test (count $tokens) -eq (count $curr_tokens); and ! string match --quiet --regex $__zoxide_z_prefix_regex. $tokens[-1]
        # If the last argument is empty and the one before doesn't start with
        # $__zoxide_z_prefix, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and echo $__zoxide_z_prefix$result
        commandline --function repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase z &>/dev/null
alias z=__zoxide_z

abbr --erase zi &>/dev/null
alias zi=__zoxide_zi

# =============================================================================
