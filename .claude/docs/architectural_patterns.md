# Architectural Patterns & Conventions

This document outlines the key architectural patterns and design decisions used across this dotfiles repository.

## 1. Modular Plugin Architecture

**Pattern**: Each Neovim plugin is a standalone Lua module returning a lazy.nvim specification.

**Location**: `nvim/lua/plugins/*.lua`

**Convention**:
```lua
return {
    'author/plugin-name',
    dependencies = { 'dep1', 'dep2' },
    event = "TriggerEvent",
    config = function() ... end
}
```

**Examples**:
- `nvim/lua/plugins/telescope.lua` - Fuzzy finder configuration
- `nvim/lua/plugins/lsp.lua` - Language server setup
- `nvim/lua/plugins/treesitter.lua` - Syntax highlighting

**Why**: Enables independent plugin maintenance, clear dependency tracking, and easy addition/removal of features.

---

## 2. Lazy Loading and Performance Optimization

**Pattern**: Plugins use event-driven loading to minimize startup time.

**Common Events**:
- `event = "VeryLazy"` - Load after startup completes (most plugins)
- `event = "BufEnter"` - Load when entering a buffer
- `lazy = false` - Essential plugins load immediately (colorschemes)
- `event = { "BufReadPre", "BufNewFile" }` - Load for file operations

**Examples**:
- `nvim/lua/plugins/telescope.lua:3` - `event = "VeryLazy"`
- `nvim/lua/plugins/tokyonight.lua:3` - `lazy = false`
- `nvim/lua/plugins/gitsigns.lua:3` - `event = { "BufReadPre", "BufNewFile" }`

**Measurement**: Check startup time with `nvim --startuptime startup.log`

---

## 3. Distributed Keybinding Organization

**Pattern**: Keybindings are co-located with their respective plugin configurations, not centralized.

**Rationale**: Easier to understand plugin behavior and remove plugins without leaving orphaned keybindings.

**Common Leader Key Patterns**:
- `<leader>f` prefix - File/finding operations (Telescope)
- `<leader>g` prefix - Git operations (Fugitive, Gitsigns)
- `<leader>t` prefix - Testing operations (vim-test)
- `<leader>c` prefix - Code actions (LSP)

**Examples**:
- LSP keybindings: `nvim/lua/plugins/lsp.lua:67-75` (gd, gi, gr, K, <leader>ca)
- Telescope keybindings: `nvim/lua/plugins/telescope.lua:13-22`
- Git keybindings: `nvim/lua/plugins/gitsigns.lua:15-25`

**Core keybindings** (non-plugin): `nvim/lua/config/keymaps.lua`

---

## 4. Centralized Configuration Bootstrap

**Pattern**: Core initialization is organized by concern in `lua/config/`.

**Structure**:
```
lua/config/
├── init.lua        # Entry point - requires all config modules
├── settings.lua    # Vim options (encoding, tabs, UI)
├── keymaps.lua     # Core keybindings
└── lazy.lua        # Plugin manager bootstrap
```

**Load Order**:
1. `init.lua` is called by `nvim/init.lua:1`
2. It loads `settings.lua`, `keymaps.lua`, `lazy.lua` in sequence
3. `lazy.lua` auto-installs and loads all plugins

**Why**: Clear separation between core editor configuration and plugin ecosystem.

---

## 5. Settings Organization by Domain

**Pattern**: Vim options are grouped by functional domain in `nvim/lua/config/settings.lua`.

**Groups**:
- Encoding (lines 1-2)
- Indentation (lines 7-10)
- UI/Display (lines 13-20)
- Search behavior (lines 23-25)
- File handling (lines 28-30)
- Performance (lines 33-35)

**Why**: Makes it easy to locate and modify related settings together.

---

## 6. Language Server Protocol (LSP) Configuration

**Pattern**: Multi-language LSP setup with consistent keybindings and capabilities.

**Location**: `nvim/lua/plugins/lsp.lua`

**Supported Languages**:
- TypeScript/JavaScript: `ts_ls` (line 45)
- Python: `pyright` (line 46)
- C#: `omnisharp` (line 47)
- PHP: `intelephense` (line 48)
- Tailwind CSS: `tailwindcss` (line 49)
- JSON: `jsonls` (line 50)
- HTML: `emmet_ls` (line 51)
- Angular: `angularls` (line 52)
- Vue: TypeScript plugin integration (line 20-32)

**Shared Keybindings** (line 67-75):
- `gd` - Go to definition
- `gi` - Go to implementation
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

**Pattern**: Each LSP server shares the same keybindings and capabilities, ensuring consistent behavior across languages.

---

## 7. Git Integration Strategy

**Pattern**: Multi-layered git integration across prompt, editor, and keybindings.

**Layers**:
1. **Shell Prompt** (`bash/bryan-2.omp.json:36-58`)
   - Shows current branch, ahead/behind status
   - Color-codes working directory state (red = changes, blue = ahead)

2. **Editor Status** (`nvim/lua/plugins/gitsigns.lua`)
   - Line-by-line git hunks in sign column
   - Inline blame with `<leader>gb`
   - Hunk navigation with `[h` and `]h`

3. **File Operations** (`nvim/lua/plugins/fugitive.lua`)
   - `<leader>gs` - Git status
   - `<leader>gp` - Git push
   - Full Git command interface

4. **History Navigation** (`nvim/lua/plugins/telescope.lua`)
   - `<leader>gc` - Browse commits
   - `<leader>gB` - Browse branches

**Why**: Provides git context at every level without leaving the terminal.

---

## 8. Vim-Style Consistency Across Tools

**Pattern**: Consistent hjkl navigation and keybinding conventions across tmux, nvim, and scripts.

**Examples**:
- **Tmux** (`tmux/tmux.conf:38-41`): `bind h/j/k/l select-pane`
- **Tmux-Vim Navigation** (`nvim/lua/plugins/tmux-navigator.lua`): Seamless pane switching with Ctrl+hjkl
- **Telescope** (`nvim/lua/plugins/telescope.lua`): `Ctrl-j/k` for result navigation
- **LSP** (`nvim/lua/plugins/lsp.lua`): `[d` / `]d` for diagnostic navigation

**Philosophy**: Muscle memory should transfer between tools. If you learn Vim navigation, it works everywhere.

---

## 9. Test-Driven Development Support

**Pattern**: Consistent keybindings for test execution at different scopes.

**Location**: `nvim/lua/plugins/vim-test.lua`

**Keybindings**:
- `<leader>tn` - Test nearest (cursor position)
- `<leader>tf` - Test file (current file)
- `<leader>ts` - Test suite (all tests)
- `<leader>tl` - Test last (re-run previous)
- `<leader>tv` - Test visit (jump to last test)

**Why**: Supports rapid test-feedback loop at appropriate granularity.

---

## 10. Symlink-Based Installation

**Pattern**: Configuration files are symlinked from repository to system locations.

**Location**: `install` script (root)

**Symlinks Created**:
- `$DOTFILES/nvim` → `$HOME/.config/nvim`
- `$DOTFILES/kitty` → `$HOME/.config/kitty`
- `$DOTFILES/tmux/tmux.conf` → `$HOME/.tmux.conf`
- `$DOTFILES/scripts/t` → `$HOME/.local/bin/t`
- `$DOTFILES/bash/bryan-2.omp.json` → `$(brew --prefix oh-my-posh)/themes/`

**Why**:
- Single source of truth (this repository)
- Updates via `git pull` automatically reflect in system
- Easy to backup and restore on new machines
- Version control for configuration changes

---

## 11. Color Palette Standardization

**Pattern**: Centralized color definitions used consistently across prompt and editor.

**Location**: `bash/bryan-2.omp.json:3-11` (palette definition)

**Palette**:
```json
"terminal-red": "#F97BB0"
"terminal-green": "#75C2B3"
"terminal-blue": "#82E6FF"
"terminal-yellow": "#FFB86C"
"main-bg": "#24283b"
"celeste-blue": "#008DDA"
```

**Usage**: Referenced as `p:terminal-red` throughout prompt segments

**Editor Theme**: TokyoNight (`nvim/lua/plugins/tokyonight.lua`) - complements shell theme

---

## 12. Dependency Management Strategy

**Pattern**: Lock files ensure reproducible plugin installations.

**Files**:
- `nvim/lazy-lock.json` - Exact commit hashes for all 50+ Neovim plugins
- Plugin manager auto-bootstraps on first run (`nvim/lua/config/lazy.lua:1-8`)

**Update Process**:
1. Manual updates via `:Lazy update` in Neovim
2. Review changes and test
3. Commit updated `lazy-lock.json`

**Why**: Prevents unexpected breakage from plugin updates while allowing controlled upgrades.

---

## Design Principles Summary

1. **Modularity** - Each tool/plugin is independently configurable
2. **Performance** - Lazy loading and event-driven initialization
3. **Consistency** - Vim keybindings work across all tools
4. **Git-First** - Deep integration at shell, editor, and workflow levels
5. **Symlink-Based** - Single source of truth via version control
6. **Progressive Enhancement** - Core functionality works without plugins
7. **Language Agnostic** - Equal support for multiple programming languages
8. **Terminal-Native** - Optimized for keyboard-driven workflows
9. **Reproducibility** - Lock files and bootstrap scripts ensure consistent setup
10. **Co-location** - Configuration lives with the code it affects
