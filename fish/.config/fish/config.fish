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
alias cdd="cd ~/Desktop/"
alias cdc="cd ~/.config/"
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
