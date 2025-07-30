function fish_prompt
    set_color cyan
    echo -n (prompt_pwd) ""
    set_color green
    echo -n ">          "
    set_color normal
end
