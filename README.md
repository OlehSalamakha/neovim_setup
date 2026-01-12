# Neovim Installer

Standalone Neovim installer for macOS and Fedora with Omakub-style configuration.

## Features

- **LazyVim** - Modern Neovim configuration framework
- **Tokyo Night** - Beautiful dark theme with transparency
- **Cascadia Mono Nerd Font** - Programming font with icon support
- **Neo-tree** - File explorer built-in
- **Telescope** - Fuzzy finder for files and text
- **LSP Ready** - Language server protocol support
- **Treesitter** - Advanced syntax highlighting

## Requirements

### macOS
- macOS (any recent version)
- [Homebrew](https://brew.sh) package manager
- Internet connection

### Fedora
- Fedora-based Linux distribution
- `sudo` access
- Internet connection

## Installation

The installer automatically detects your operating system (macOS or Fedora) and runs the appropriate installation.

```bash
cd neovim-fedora
./install.sh
```

The script will:
1. Detect your operating system
2. Install Neovim and dependencies (luarocks, tree-sitter-cli)
   - macOS: Uses Homebrew
   - Fedora: Uses dnf
3. Download and install Cascadia Mono Nerd Font
   - macOS: Installs to `~/Library/Fonts/`
   - Fedora: Installs to `~/.local/share/fonts/`
4. Clone LazyVim starter configuration
5. Apply Omakub customizations (theme, transparency, settings)

## What Gets Installed

### System Packages
- `neovim` - The editor
- `luarocks` - Lua package manager
- `tree-sitter-cli` - Parser generator
- `git`, `curl`, `unzip` - Required utilities

### Configuration
- **Location**: `~/.config/nvim/`
- **Theme**: Tokyo Night with transparency
- **File Explorer**: Neo-tree (LazyVim extra)
- **Line Numbers**: Absolute (relative disabled)
- **Scrolling**: No animations

### Font
- **CaskaydiaMono Nerd Font**
  - macOS: `~/Library/Fonts/`
  - Fedora: `~/.local/share/fonts/`

## First Run

When you first launch Neovim, LazyVim will automatically install all required plugins. This may take a minute or two.

```bash
nvim
```

Be patient during the initial plugin installation. You'll see a floating window showing installation progress.

## Keybindings

Neovim uses **Space** as the leader key. Press `Space` and wait a moment to see available keybindings.

### Most Common

| Keybinding | Action |
|------------|--------|
| `Space Space` | Find files |
| `Space sg` | Search text in project (grep) |
| `Space ,` | Switch between buffers |
| `Space e` | Toggle file explorer (Neo-tree) |
| `Space ff` | Find files (alternative) |
| `Space fr` | Recent files |
| `Space /` | Search in open buffers |

### Inside Telescope (fuzzy finder)

| Keybinding | Action |
|------------|--------|
| `Ctrl-j/k` | Navigate results |
| `Enter` | Open selection |
| `Esc` | Close |
| `Ctrl-u/d` | Scroll preview |

### All Keybindings

Press `Space s k` to search all keymaps, or see [LazyVim keybindings documentation](https://www.lazyvim.org/keymaps).

## Configuration

### Set Neovim as Default Editor

Add to your shell config:
- macOS: `~/.zshrc`
- Fedora: `~/.bashrc`

```bash
export EDITOR=nvim
```

### Customize Configuration

LazyVim uses a modular configuration structure:

- `~/.config/nvim/lua/config/` - Core settings
- `~/.config/nvim/lua/plugins/` - Plugin configurations
- `~/.config/nvim/plugin/after/` - Post-load customizations

To add your own customizations, create files in these directories. See [LazyVim documentation](https://www.lazyvim.org/) for details.

### Omakub Customizations Applied

1. **Transparency** - Terminal background shows through
2. **Tokyo Night theme** - Dark theme with vibrant colors
3. **No animated scrolling** - Instant scroll for performance
4. **Absolute line numbers** - Relative line numbers disabled
5. **Neo-tree enabled** - File explorer available by default

## Uninstall

### Remove Neovim Configuration (All Systems)

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

### Remove System Packages

**macOS:**
```bash
brew uninstall neovim luarocks tree-sitter
```

**Fedora:**
```bash
sudo dnf remove neovim luarocks tree-sitter-cli
```

### Remove Font

**macOS:**
```bash
rm -rf ~/Library/Fonts/CaskaydiaMono*
```

**Fedora:**
```bash
rm -rf ~/.local/share/fonts/CaskaydiaMono*
fc-cache -fv
```

## Portability

This folder is completely standalone. You can:

1. Copy the entire folder to any macOS or Fedora machine
2. Run `./install.sh`

The installer will automatically detect your OS and install accordingly. No dependencies on Omakub or any external project structure.

## Troubleshooting

### Plugins not installing

On first run, LazyVim automatically installs plugins. If this fails:
1. Quit Neovim (`:q`)
2. Restart: `nvim`
3. Manually trigger: `:Lazy sync`

### Font icons not showing

Make sure you're using a terminal that supports Nerd Fonts:
- Alacritty ✓
- Kitty ✓
- WezTerm ✓
- GNOME Terminal (with font configured)
- Konsole (with font configured)

Set your terminal font to "CaskaydiaMono Nerd Font".

### Transparency not working

Terminal transparency depends on your terminal emulator:
- Alacritty: Set `opacity` in config
- Kitty: Set `background_opacity` in config
- GNOME Terminal: Limited support

### LazyVim health check

Run `:checkhealth` in Neovim to diagnose issues.

## Credits

Based on the excellent [Omakub](https://github.com/basecamp/omakub) Ubuntu setup by Basecamp, adapted for Fedora as a standalone installer.

## License

MIT License - Same as Omakub
