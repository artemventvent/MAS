# MAS — My Arch Setup

📦 This script automates the post-installation setup of your Arch Linux system after installing via `archinstall` with Hyprland.

## 🧩 Features

- Installs required packages from both official repositories and AUR
- Copies all configuration files into the home directory

## 📁 Project Structure

```
MAS/
├── install.sh             # Main installation script
├── pacman.txt             # List of official packages
├── aur.txt                # List of AUR packages
├── configs/               # All configuration files, including .config and dotfiles
    ├── .config/
```

## ⚙️ Requirements

- Arch Linux
- A user with `sudo` privileges
- Hyprland and a working base system

## 🚀 Usage

```bash
git clone https://github.com/artemventvent/MAS.git
cd MAS
./install.sh
```
