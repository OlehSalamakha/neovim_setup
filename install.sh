#!/bin/bash

# Standalone Neovim Installation Script for Fedora
# Based on Omakub configuration

set -e

# Get the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "========================================="
echo "  Neovim Installation for Fedora"
echo "========================================="
echo ""

# Check if running on Fedora
if [ ! -f /etc/fedora-release ]; then
    echo "ERROR: This script is designed for Fedora-based systems."
    echo "Current system is not Fedora."
    exit 1
fi

echo "✓ Fedora system detected"
echo ""

# Install system dependencies
echo "Installing system dependencies..."
sudo dnf install -y neovim luarocks tree-sitter-cli git curl unzip >/dev/null 2>&1
echo "✓ System dependencies installed"
echo ""

# Install Cascadia Mono Nerd Font
if ! fc-list | grep -i "CaskaydiaMono Nerd Font" >/dev/null; then
    echo "Installing Cascadia Mono Nerd Font..."
    cd /tmp
    curl -sL -o CascadiaMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip"
    unzip -q CascadiaMono.zip -d CascadiaMono
    mkdir -p ~/.local/share/fonts
    cp CascadiaMono/*.ttf ~/.local/share/fonts/
    rm -rf CascadiaMono.zip CascadiaMono
    fc-cache -fv >/dev/null 2>&1
    cd - >/dev/null
    echo "✓ Cascadia Mono Nerd Font installed"
else
    echo "✓ Cascadia Mono Nerd Font already installed"
fi
echo ""

# Setup LazyVim base configuration
if [ ! -d "$HOME/.config/nvim" ]; then
    echo "Installing LazyVim starter configuration..."
    git clone https://github.com/LazyVim/starter ~/.config/nvim >/dev/null 2>&1
    rm -rf ~/.config/nvim/.git
    echo "✓ LazyVim starter installed"
else
    echo "✓ Neovim config directory already exists (skipping LazyVim clone)"
fi
echo ""

# Apply Omakub customizations
echo "Applying Omakub customizations..."

# Create necessary directories
mkdir -p ~/.config/nvim/plugin/after
mkdir -p ~/.config/nvim/lua/plugins
mkdir -p ~/.config/nvim/lua/config

# Copy configuration files
cp "$SCRIPT_DIR/configs/neovim/transparency.lua" ~/.config/nvim/plugin/after/
cp "$SCRIPT_DIR/configs/neovim/snacks-animated-scrolling-off.lua" ~/.config/nvim/lua/plugins/
cp "$SCRIPT_DIR/configs/neovim/theme.lua" ~/.config/nvim/lua/plugins/
cp "$SCRIPT_DIR/configs/neovim/neo-tree.lua" ~/.config/nvim/lua/plugins/
cp "$SCRIPT_DIR/configs/neovim/lazyvim.json" ~/.config/nvim/

# Disable relative line numbers
if ! grep -q "vim.opt.relativenumber = false" ~/.config/nvim/lua/config/options.lua 2>/dev/null; then
    echo "vim.opt.relativenumber = false" >> ~/.config/nvim/lua/config/options.lua
fi

echo "✓ Customizations applied"
echo ""

echo "========================================="
echo "  Installation Complete!"
echo "========================================="
echo ""
echo "What was installed:"
echo "  • Neovim editor"
echo "  • LazyVim configuration"
echo "  • Tokyo Night theme"
echo "  • Cascadia Mono Nerd Font"
echo "  • Transparency settings"
echo "  • Neo-tree file explorer"
echo ""
echo "Next steps:"
echo "  1. Run 'nvim' to start Neovim"
echo "  2. Plugins will auto-install on first launch (be patient)"
echo "  3. Use Space key as the leader for keybindings"
echo ""
echo "Common keybindings:"
echo "  • Space Space    - Find files"
echo "  • Space sg       - Search text (grep)"
echo "  • Space ,        - Switch buffers"
echo "  • Space e        - Toggle file explorer"
echo ""
echo "Optional: Add to your shell config (~/.bashrc):"
echo "  export EDITOR=nvim"
echo ""
echo "Configuration location: ~/.config/nvim/"
echo "To uninstall: rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim"
echo ""
