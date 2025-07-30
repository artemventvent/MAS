# =============== Основной конфиг ===============
# Убираем стандартное приветствие
set -U fish_greeting

# Цвета Catppuccin Mocha
set -U fish_color_command 89b4fa
set -U fish_color_param f2cdcd
set -U fish_color_quote a6e3a1
set -U fish_color_redirection fab387
set -U fish_color_end f38ba8
set -U fish_color_error f38ba8
set -U fish_color_autosuggestion 6c7086
set -U fish_color_comment 585b70
set -U fish_color_operator f5c2e7
set -U fish_color_escape f2cdcd
set -U fish_color_cwd 94e2d5
set -U fish_color_host a6e3a1
set -U fish_color_user 89dceb

# Настраиваем красивое приветствие
function fish_greeting
    clear
    fastfetch --logo small --color catppuccin
    echo (set_color cyan)"Сегодня "(date)"!"(set_color normal)
end

# История
set -U fish_history_limit 10000

# Aliases
alias ll='ls -lah --color=auto'
alias update='sudo pacman -Syu'
alias cls='clear'

# Tide prompt (устанавливается через fisher)
if not set -q __tide_prompt_initialized
    tide configure \
        --style=Rainbow \
        --prompt_colors='Catppuccin Mocha' \
        --show_time=Yes
end