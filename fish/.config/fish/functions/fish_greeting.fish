function fish_greeting -d "What's up, fish?"
    set_color $fish_pager_color_prefix
    uname -nmsr

    command -q uptime
    and command uptime

    set_color normal
end
