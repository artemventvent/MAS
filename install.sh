#!/bin/bash

# Путь к скрипту
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Цветные функции
info() { gum style --foreground 33 --bold "[INFO] $1"; }
success() { gum style --foreground 42 --bold "[OK] $1"; }
error() { gum style --foreground 196 --bold "[ERR] $1"; exit 1; }

# Проверка наличия gum
ensure_gum() {
    if ! command -v gum &>/dev/null; then
        info "Устанавливаю gum..."
        if sudo pacman -Sy --noconfirm gum; then
            success "gum установлен через pacman"
        elif command -v paru &>/dev/null; then
            paru -S --needed --noconfirm gum && success "gum установлен через paru" || error "Не удалось установить gum через paru"
        else
            error "Не удалось установить gum. Установите его вручную."
        fi
    fi
}

# Добавление пользователя в sudoers
add_user_to_sudoers_main_file() {
    local user="user"
    local line="$user ALL=(ALL:ALL) NOPASSWD: ALL"

    if sudo grep -Fxq "$line" /etc/sudoers; then
        success "Пользователь $user уже есть в /etc/sudoers"
    else
        info "Добавляю пользователя $user в /etc/sudoers"
        echo "$line" | sudo EDITOR='tee -a' visudo >/dev/null \
            && success "Добавлено в /etc/sudoers" \
            || error "Ошибка при добавлении в /etc/sudoers"
    fi
}

# Установка пакетов с прогрессбаром
install_with_progress() {
    local list_file=$1
    local command=$2
    local name=$3

    if [[ ! -f "$list_file" ]]; then
        error "Файл $list_file не найден"
    fi

    info "DEBUG: Начинаю установку пакетов из $list_file"

    total=$(grep -cvE '^\s*($|#)' "$list_file")
    count=0

    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue

        ((count++))
        info "DEBUG: Устанавливаю $pkg ($count/$total)"
        gum spin --spinner dot --title "[$count/$total] $name: $pkg" -- $command "$pkg" \
            && gum style --foreground 40 "$pkg ✔" \
            || gum style --foreground 196 "$pkg ✘"
    done < "$list_file"
}

# Копирование конфигов
copy_configs() {
    info "Копирую конфиги в ~"
    cp -rf "$SCRIPT_DIR/configs/.config" ~/
    cp -f "$SCRIPT_DIR/configs/".* ~/
    success "Конфиги скопированы"
}

main() {
    ensure_gum
    add_user_to_sudoers_main_file

    info "Обновление системы"
    sudo pacman -Syu --noconfirm
    info "Установка пакетов из pacman.txt"
    install_with_progress "$SCRIPT_DIR/pacman.txt" "sudo pacman -S --noconfirm --needed" "Pacman"

    info "Установка AUR пакетов из aur.txt"
    if ! command -v paru &>/dev/null; then
        info "Устанавливаю paru"
        git clone https://aur.archlinux.org/paru.git "$SCRIPT_DIR/paru"
        (cd "$SCRIPT_DIR/paru" && makepkg -si --noconfirm)
        rm -rf "$SCRIPT_DIR/paru"
        success "paru установлен"
    fi
    install_with_progress "$SCRIPT_DIR/aur.txt" "paru -S --noconfirm --needed" "AUR"

    copy_configs

    gum style --border double --margin "1 2" --padding "1 2" \
        --foreground 212 "✅ Установка завершена успешно!"
}

main "$@"
