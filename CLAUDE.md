# Shell Dotfiles Configuration

## Project Overview

**What**: Personal development environment configuration (dotfiles) for Neovim, Tmux, Kitty terminal, and shell prompt customization.

**Why**: Provides a reproducible, version-controlled development setup optimized for polyglot web development (TypeScript/Vue/React, Python, C#, PHP/Laravel) with terminal-native workflows.

**Installation**: Run `./install` to create symlinks from this repository to system config locations (`~/.config/nvim`, `~/.tmux.conf`, etc.)

---

## Tech Stack

### Core Tools
- **Neovim** - Primary text editor with LSP integration
- **Tmux** - Terminal multiplexer with vim-style keybindings
- **Kitty** - GPU-accelerated terminal emulator
- **Oh My Posh** - Customizable shell prompt with git integration
- **Lazy.nvim** - Plugin manager with lazy loading

### Language Support (LSP Servers)
- TypeScript/JavaScript (`ts_ls`) - See `nvim/lua/plugins/lsp.lua:45`
- Python (`pyright`) - See `nvim/lua/plugins/lsp.lua:46`
- C# (`omnisharp`) - See `nvim/lua/plugins/lsp.lua:47`
- PHP (`intelephense`) - See `nvim/lua/plugins/lsp.lua:48`
- Tailwind CSS, JSON, HTML (Emmet), Angular - See `nvim/lua/plugins/lsp.lua:49-52`

### Key Neovim Plugins
- **Telescope** - Fuzzy finder for files/buffers/git/grep (`nvim/lua/plugins/telescope.lua`)
- **Treesitter** - Advanced syntax highlighting (`nvim/lua/plugins/treesitter.lua`)
- **Gitsigns** - Git integration with inline hunks (`nvim/lua/plugins/gitsigns.lua`)
- **Fugitive** - Git command wrapper (`nvim/lua/plugins/fugitive.lua`)
- **Codeium/Windsurf** - AI code completion (`nvim/lua/plugins/codeium.lua`)
- **vim-test** - Test runner integration (`nvim/lua/plugins/vim-test.lua`)
- **PHPActor** - PHP refactoring and IDE features

---

## Repository Structure

```
shell-dotfiles/
├── nvim/                    # Neovim configuration (primary editor)
│   ├── init.lua            # Entry point - loads lua/config/init.lua:1
│   ├── lazy-lock.json      # Plugin version lock file (50+ plugins)
│   ├── lua/
│   │   ├── config/         # Core configuration
│   │   │   ├── init.lua   # Bootstrap - loads settings, keymaps, lazy
│   │   │   ├── settings.lua # Vim options (encoding, tabs, UI, search)
│   │   │   ├── keymaps.lua  # Core keybindings
│   │   │   └── lazy.lua     # Plugin manager setup with auto-bootstrap
│   │   └── plugins/        # Modular plugin configurations
│   │       ├── lsp.lua     # Language server setup
│   │       ├── telescope.lua # Fuzzy finder
│   │       ├── treesitter.lua # Syntax highlighting
│   │       └── *.lua       # Additional plugin configs
│   └── after/              # Post-initialization hooks
│       └── queries/blade/  # Laravel Blade template support
│
├── tmux/                    # Terminal multiplexer
│   └── tmux.conf           # VI-style keybindings, prefix: Ctrl-Space
│
├── bash/                    # Shell prompt theme
│   └── bryan-2.omp.json    # Oh My Posh theme with git integration
│
├── kitty/                   # Terminal emulator
│   └── kitty.conf          # Terminal configuration
│
├── scripts/                 # Utility scripts
│   └── t                   # Fuzzy tmux session/project switcher
│
├── phpactor/                # PHP development tools
│   ├── phpactor.yml        # IDE configuration
│   └── templates/          # Code generation templates
│
└── install                  # Symlink installer script
```

---

## Essential Commands

### Installation
```bash
# Initial setup (creates symlinks to ~/.config/)
./install

# First Neovim launch (auto-installs plugins)
nvim
# Wait for lazy.nvim to download and install all plugins
```

### Plugin Management
```vim
:Lazy               " Open plugin manager UI
:Lazy update        " Update all plugins and regenerate lazy-lock.json
:Lazy sync          " Install missing plugins, remove unused, update
:Lazy restore       " Restore plugins to lazy-lock.json versions
```

### LSP Management
```vim
:LspInfo            " Show LSP server status for current buffer
:Mason              " Open LSP server installer UI
:MasonUpdate        " Update all installed LSP servers
```

### Testing
```vim
:TestNearest        " Run test under cursor (<leader>tn)
:TestFile           " Run all tests in file (<leader>tf)
:TestSuite          " Run entire test suite (<leader>ts)
:TestLast           " Re-run last test (<leader>tl)
```

### Tmux Session Management
```bash
# Launch tmux session switcher (fuzzy finder)
t

# Tmux prefix: Ctrl-Space (configured in tmux/tmux.conf:15)
# Create new window: Ctrl-Space c
# Split panes: Ctrl-Space | (vertical), Ctrl-Space - (horizontal)
# Navigate panes: Ctrl-hjkl (seamless with Neovim via tmux-navigator)
```

### Git Operations (in Neovim)
```vim
<leader>gs          " Git status (Fugitive)
<leader>gc          " Browse commits (Telescope)
<leader>gb          " Git blame line (Gitsigns)
[h / ]h             " Navigate between git hunks
<leader>gp          " Git push (Fugitive)
```

---

## Key Keybindings

**Leader key**: `<Space>` (configured in `nvim/lua/config/keymaps.lua:1`)

### File Navigation (Telescope)
- `<leader>ff` - Find files
- `<leader>G` - Live grep (search in files)
- `<leader>fb` - Browse buffers
- `<leader>fh` - Help tags

### LSP Operations
- `gd` - Go to definition
- `gi` - Go to implementation
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `[d` / `]d` - Navigate diagnostics

See `nvim/lua/plugins/lsp.lua:67-75` for complete LSP keybindings.

### Git Operations
- `<leader>gs` - Git status
- `<leader>gc` - Git commits
- `<leader>gb` - Git blame
- `[h` / `]h` - Previous/next hunk

### Testing
- `<leader>tn` - Test nearest
- `<leader>tf` - Test file
- `<leader>ts` - Test suite

---

## Additional Documentation

When working on specific aspects of this codebase, consult:

- **.claude/docs/architectural_patterns.md** - Architectural patterns, design decisions, and conventions used across the codebase (modular plugin architecture, lazy loading, keybinding organization, LSP setup, git integration, symlink-based installation, etc.)

---

## Common Tasks

### Adding a New Plugin
1. Create `nvim/lua/plugins/plugin-name.lua`
2. Return lazy.nvim spec with dependencies and config
3. Restart Neovim (lazy.nvim auto-installs)
4. Update `lazy-lock.json` with `:Lazy sync`

### Adding a New LSP Server
1. Edit `nvim/lua/plugins/lsp.lua`
2. Add server to `servers` table (line 44-53)
3. Configure server-specific options if needed
4. Install via `:Mason` or let Mason auto-install

### Modifying Vim Settings
- **Core options**: Edit `nvim/lua/config/settings.lua`
- **Keybindings**: Edit `nvim/lua/config/keymaps.lua` (core) or plugin files (plugin-specific)
- **Plugin config**: Edit respective file in `nvim/lua/plugins/`

### Debugging Startup Issues
```bash
# Check startup time and plugin load order
nvim --startuptime startup.log

# Check LSP server logs
:LspLog

# Validate plugin configuration
:checkhealth
```

---

## Notes

- **Plugin Manager**: Uses lazy.nvim with automatic lazy loading for performance
- **Lock File**: `nvim/lazy-lock.json` pins exact plugin versions - commit changes after updates
- **Bootstrap**: First Neovim launch auto-installs lazy.nvim (see `nvim/lua/config/lazy.lua:1-8`)
- **Symlinks**: Configs are symlinked, not copied - changes to this repo immediately affect system
- **Theme**: TokyoNight colorscheme for Neovim, custom Oh My Posh theme for shell prompt
