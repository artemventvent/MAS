function fish_prompt
    set_color cyan
    echo -n (whoami) "@" (hostname) " "
    set_color magenta
    echo -n (prompt_pwd) " "
    set_color green
    echo -n "___ "
    set_color normal
end
