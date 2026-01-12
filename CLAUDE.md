# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Standalone Neovim installer for macOS and Fedora that sets up LazyVim with Omakub-inspired customizations. The installer is completely self-contained and portable - designed to be copied to any compatible machine and run independently.

## Architecture

### Installation Flow

#### Main Installer (install.sh)

1. **OS Detection**: Detects operating system via `$OSTYPE` and system files
   - macOS: Checks for `darwin*` in `$OSTYPE`, then executes `install-macos.sh`
   - Fedora: Checks for `/etc/fedora-release`, continues with Fedora installation
   - Debian/Ubuntu: Detected but not yet implemented (shows error message)
2. **Routes to OS-specific installation** (macOS) or **continues with Fedora installation**

#### macOS Installation Flow (install-macos.sh)

1. **System validation**: Checks for macOS via `$OSTYPE == "darwin*"`
2. **Homebrew check**: Verifies Homebrew is installed, exits with instructions if not
3. **Package installation**: Installs neovim, luarocks, tree-sitter, and utilities via Homebrew
4. **Font installation**: Downloads CascadiaMono Nerd Font from GitHub releases, installs to `~/Library/Fonts/`
5. **Base configuration**: Clones LazyVim starter to `~/.config/nvim/` (removes `.git` for portability)
6. **Customization overlay**: Copies config files from `configs/neovim/` to appropriate locations in `~/.config/nvim/`

#### Fedora Installation Flow (install.sh continuation)

1. **System validation**: Checks for Fedora-based system via `/etc/fedora-release`
2. **Package installation**: Installs neovim, luarocks, tree-sitter-cli, and utilities via dnf
3. **Font installation**: Downloads CascadiaMono Nerd Font from GitHub releases, installs to `~/.local/share/fonts/`, runs `fc-cache`
4. **Base configuration**: Clones LazyVim starter to `~/.config/nvim/` (removes `.git` for portability)
5. **Customization overlay**: Copies config files from `configs/neovim/` to appropriate locations in `~/.config/nvim/`

### Configuration Files Structure

The `configs/neovim/` directory contains overlays applied on top of the LazyVim base:

- **transparency.lua**: Applied to `~/.config/nvim/plugin/after/` - Sets background transparency for all UI elements (Normal, NeoTree, Telescope, Notify, etc.) using `vim.api.nvim_set_hl()`
- **theme.lua**: Copied to `~/.config/nvim/lua/plugins/` - LazyVim plugin config that sets colorscheme to "gruvbox" (note: README mentions Tokyo Night, but actual config uses gruvbox)
- **snacks-animated-scrolling-off.lua**: Copied to `~/.config/nvim/lua/plugins/` - Disables Snacks.nvim scroll animations
- **lazyvim.json**: LazyVim state file that enables the neo-tree extra
- **lsp.lua**: Currently not used by install.sh

The installer also appends `vim.opt.relativenumber = false` to `~/.config/nvim/lua/config/options.lua` to disable relative line numbers.

## Platform-Specific Differences

### macOS vs Fedora

| Aspect | macOS | Fedora |
|--------|-------|--------|
| Package Manager | Homebrew (`brew`) | DNF (`dnf`) |
| Font Location | `~/Library/Fonts/` | `~/.local/share/fonts/` |
| Font Cache | Auto-updated by system | Requires `fc-cache -fv` |
| Default Shell | zsh (`~/.zshrc`) | bash (`~/.bashrc`) |
| Prerequisites | Homebrew must be installed | sudo access required |

### macOS-Specific Notes

- **Homebrew Requirement**: The installer checks for Homebrew and exits with installation instructions if not found
- **Font Installation**: Fonts are installed to `~/Library/Fonts/` (user-specific) rather than system-wide
- **No Font Cache**: macOS automatically detects new fonts; no `fc-cache` command needed
- **Shell Config**: Instructions reference `~/.zshrc` instead of `~/.bashrc`

## Common Commands

### Installation
```bash
# Run the installer
./install.sh

# Complete uninstall - Fedora
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim
sudo dnf remove neovim luarocks tree-sitter-cli
rm -rf ~/.local/share/fonts/CaskaydiaMono*
fc-cache -fv

# Complete uninstall - macOS
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim
brew uninstall neovim luarocks tree-sitter
rm -rf ~/Library/Fonts/CaskaydiaMono*
```

### Testing Changes
After modifying config files in `configs/neovim/`:
```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Re-run installer
./install.sh

# Launch to test
nvim
```

### Font Verification
```bash
# Check if font is installed
fc-list | grep -i "CaskaydiaMono Nerd Font"

# Refresh font cache after manual changes
fc-cache -fv
```

## Development Notes

### LazyVim Configuration System

LazyVim uses a layered configuration approach:
- Core LazyVim base (from starter repo)
- `lua/config/` - Core Neovim settings (options.lua, keymaps.lua, etc.)
- `lua/plugins/` - Plugin-specific configurations (auto-loaded by Lazy.nvim)
- `plugin/after/` - Executed after all plugins load (ideal for theme overrides like transparency)
- `lazyvim.json` - Tracks enabled extras and LazyVim version

### Adding New Configuration Files

New config files should be:
1. Created in `configs/neovim/`
2. Added to the install script with appropriate `cp` command
3. Placed in the correct LazyVim directory based on load order requirements

### Modifying Transparency

The transparency.lua file uses `vim.api.nvim_set_hl(0, "<highlight_group>", { bg = "none" })` to make backgrounds transparent. To add transparency for new UI elements, identify their highlight group (`:Telescope highlights` in Neovim) and add them to transparency.lua.

### Theme Discrepancy

README.md documents "Tokyo Night theme" but theme.lua actually configures gruvbox colorscheme. This appears to be intentional customization but creates documentation mismatch.
