# Neovim Keybindings Cheat Sheet

**Leader Key**: `<Space>`

---

## Core Navigation & Editing

### Movement
| Key | Mode | Action |
|-----|------|--------|
| `j` | Normal | Move down (by display line when wrapped) |
| `k` | Normal | Move up (by display line when wrapped) |
| `Alt-j` | Normal/Insert/Visual | Move line down |
| `Alt-k` | Normal/Insert/Visual | Move line up |

### Editing
| Key | Mode | Action |
|-----|------|--------|
| `<` | Visual | Indent left (maintains selection) |
| `>` | Visual | Indent right (maintains selection) |
| `y` | Visual | Yank without moving cursor |
| `p` | Visual | Paste without copying replaced text |
| `;;` | Insert | Add semicolon at end of line |
| `,,` | Insert | Add comma at end of line |

### Utility
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>k` | Normal | Clear search highlighting |
| `<Leader>cc` | Visual | Copy file path with line numbers for Claude (`@file:line` or `@file:start-end`) |
| `q:` | Normal | Disabled (remapped to `:q`) |

---

## Telescope (Fuzzy Finder)

### File Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>f` | Normal/Visual | Find files (respects .gitignore) |
| `<Leader>F` | Normal/Visual | Find all files (ignores .gitignore) |
| `<Leader>G` | Normal/Visual | Live grep (search in files) |
| `<Leader>b` | Normal | Browse buffers |
| `<Leader>h` | Normal | Recent files (oldfiles) |
| `<Leader>tr` | Normal | Resume last Telescope picker |

### Symbols & Documentation
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>s` | Normal | LSP document symbols |

### Git Integration
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>gs` | Normal | Git status |
| `<Leader>gc` | Normal | Git commits (buffer) |
| `<Leader>gb` | Normal | Git branches |

### Telescope Insert Mode Mappings
| Key | Mode | Action |
|-----|------|--------|
| `<Esc>` | Insert | Close Telescope |
| `<C-Down>` | Insert | Next search history |
| `<C-Up>` | Insert | Previous search history |

---

## LSP (Language Server Protocol)

### Navigation
| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gi` | Normal | Go to implementation (Telescope) |
| `gr` | Normal | Go to references (Telescope) |
| `K` | Normal | Hover documentation |

### Diagnostics
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>d` | Normal | Open diagnostic float |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |

### Code Actions
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>ca` | Normal | Code action |
| `<Leader>cf` | Normal/Visual | Format file or selection (conform.nvim) |
| `<Leader>cl` | Normal | Manually trigger linting |
| `<Leader>rn` | Normal | Rename symbol |

### Commands
| Command | Action |
|---------|--------|
| `:LspInfo` | Show LSP server status |
| `:Mason` | Open LSP/formatter/linter installer |
| `:ConformInfo` | Show formatter information |

---

## Git Operations (Gitsigns)

### Hunk Navigation
| Key | Mode | Action |
|-----|------|--------|
| `]h` | Normal | Next hunk |
| `[h` | Normal | Previous hunk |

### Hunk Actions
| Key | Mode | Action |
|-----|------|--------|
| `gp` | Normal | Preview hunk |
| `ga` | Normal | Stage hunk |
| `gA` | Normal | Undo stage hunk |
| `gz` | Normal | Reset hunk |
| `gB` | Normal | Blame line |

---

## Snacks.nvim (Utilities & Notifications)

### Notifications
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>nh` | Normal | Show notification history |
| `<Leader>un` | Normal | Dismiss all notifications |

### Git Operations (Lazygit Integration)
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>gg` | Normal | Open Lazygit |
| `<Leader>go` | Normal | Git browse (open file/repo in browser) |
| `<Leader>gf` | Normal | Lazygit current file history |
| `<Leader>gl` | Normal | Lazygit log |

### Buffer Management
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>bd` | Normal | Delete buffer (smart delete) |

### Toggles
| Key | Mode | Action |
|-----|------|--------|
| `<Leader>us` | Normal | Toggle spelling |
| `<Leader>uw` | Normal | Toggle wrap |
| `<Leader>uL` | Normal | Toggle relative line numbers |
| `<Leader>ul` | Normal | Toggle line numbers |
| `<Leader>ud` | Normal | Toggle diagnostics |
| `<Leader>uT` | Normal | Toggle Treesitter |
| `<Leader>uh` | Normal | Toggle inlay hints |

---

## Testing (vim-test)

| Key | Mode | Action |
|-----|------|--------|
| `<Leader>tn` | Normal | Test nearest |
| `<Leader>tf` | Normal | Test file |
| `<Leader>ts` | Normal | Test suite |
| `<Leader>tl` | Normal | Test last |
| `<Leader>tv` | Normal | Test visit |

---

## File Tree (NvimTree)

| Key | Mode | Action |
|-----|------|--------|
| `<Leader>n` | Normal | Toggle file tree (shows current file) |

---

## Terminal (Floaterm)

| Key | Mode | Action |
|-----|------|--------|
| `<F1>` | Normal | Toggle floating terminal |
| `<F1>` | Terminal | Toggle floating terminal |

---

## Autocomplete (nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | Insert | Select next completion / Expand snippet / Jump forward |
| `<S-Tab>` | Insert | Select previous completion / Jump backward |
| `<CR>` | Insert | Confirm completion |

---

## AI Completion (Windsurf/Codeium)

| Key | Mode | Action |
|-----|------|--------|
| `<C-j>` | Insert | Accept AI suggestion |
| `<C-h>` | Insert | Accept next word |
| `<C-l>` | Insert | Accept next line |
| `<C-;>` | Insert | Cycle to next completion |
| `<C-,>` | Insert | Cycle to previous completion |
| `<C-x>` | Insert | Clear/dismiss suggestion |

---

## Tmux Navigation (vim-tmux-navigator)

Uses default vim-tmux-navigator bindings:
- `<C-h>` - Navigate left (Vim pane or Tmux pane)
- `<C-j>` - Navigate down (Vim pane or Tmux pane)
- `<C-k>` - Navigate up (Vim pane or Tmux pane)
- `<C-l>` - Navigate right (Vim pane or Tmux pane)

---

## Plugin-Provided Keybindings

Some plugins provide default keybindings not explicitly configured:

### vim-surround
- `cs"'` - Change surrounding " to '
- `ds"` - Delete surrounding "
- `ysiw"` - Surround word with "
- See `:help surround` for more

### vim-unimpaired
- `[b` / `]b` - Previous/next buffer
- `[q` / `]q` - Previous/next quickfix
- See `:help unimpaired` for more

### vim-commentary (if installed)
- `gc` - Toggle comment (motion)
- `gcc` - Toggle comment (line)

---

## Configuration Files

- **Core keymaps**: `nvim/lua/config/keymaps.lua`
- **LSP keymaps**: `nvim/lua/plugins/lsp.lua:97-106`
- **Formatting**: `nvim/lua/plugins/conform.lua`
- **Linting**: `nvim/lua/plugins/nvim-lint.lua`
- **Telescope keymaps**: `nvim/lua/plugins/telescope.lua:103-112`
- **Gitsigns keymaps**: `nvim/lua/plugins/gitsigns.lua:6-12`
- **Snacks keymaps**: `nvim/lua/plugins/snacks.lua:27-33` (NEW)
- **Testing keymaps**: `nvim/lua/plugins/test.lua:5-9`
- **File tree keymaps**: `nvim/lua/plugins/nvim-tree.lua:28`
- **Terminal keymaps**: `nvim/lua/plugins/floaterm.lua:7-8`
- **AI completion**: `nvim/lua/plugins/windsurf.lua:5-10`
- **Autocomplete**: `nvim/lua/config/plugins/cmp.lua:23-44`
