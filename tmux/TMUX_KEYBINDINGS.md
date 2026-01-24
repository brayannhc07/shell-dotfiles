# Tmux Keybindings Cheat Sheet

**Prefix Key**: `Ctrl+Space`

## Quick Reference

### Prefix Commands
Most commands require pressing the prefix (`Ctrl+Space`) first, then the command key.

- `-r` flag: Command can repeat without re-entering prefix
- `-n` flag: Command doesn't require prefix (direct binding)

---

## Essential Commands

| Key | Action |
|-----|--------|
| `Ctrl+Space` then `Ctrl+Space` | Send prefix to nested tmux session |
| `Ctrl+Space` then `r` | Reload tmux configuration |
| `Ctrl+Space` then `?` | Show all keybindings (default tmux) |

---

## Window Management

### Creating & Closing Windows
| Key | Action |
|-----|--------|
| `Ctrl+Space` then `c` | Create new window (inherits current path) |
| `Ctrl+Space` then `&` | Kill current window (with confirmation) |

### Window Navigation
| Key | Action |
|-----|--------|
| `Ctrl+Space` then `n` | Next window (repeatable) |
| `Ctrl+Space` then `p` | Previous window (repeatable) |
| `Ctrl+Space` then `Ctrl+n` | Next window (hold Ctrl) |
| `Ctrl+Space` then `Ctrl+p` | Previous window (hold Ctrl) |
| `Ctrl+Space` then `Space` | Toggle to last used window |
| `Ctrl+Space` then `0-9` | Jump to window number |
| `Ctrl+Space` then `Ctrl+h` | Select previous window (repeatable) |
| `Ctrl+Space` then `Ctrl+l` | Select next window (repeatable) |

### Window Reordering
| Key | Action |
|-----|--------|
| `Ctrl+Space` then `N` | Move window position forward (swap with next) |
| `Ctrl+Space` then `P` | Move window position backward (swap with previous) |

---

## Pane Management

### Creating & Splitting Panes
| Key | Action |
|-----|--------|
| `Ctrl+Space` then `\|` | Split pane vertically (inherits current path) |
| `Ctrl+Space` then `-` | Split pane horizontally (inherits current path) |
| `Ctrl+Space` then `x` | Kill current pane (with confirmation) |

### Pane Navigation (Vim-aware)

**Smart Navigation** (works seamlessly with Neovim splits):
| Key | Action |
|-----|--------|
| `Ctrl+h` | Navigate to left pane (or Neovim split) |
| `Ctrl+j` | Navigate to bottom pane (or Neovim split) |
| `Ctrl+k` | Navigate to top pane (or Neovim split) |
| `Ctrl+l` | Navigate to right pane (or Neovim split) |

**Prefix-based Navigation** (tmux only):
| Key | Action |
|-----|--------|
| `Ctrl+Space` then `h` | Select pane to the left (repeatable) |
| `Ctrl+Space` then `j` | Select pane below (repeatable) |
| `Ctrl+Space` then `k` | Select pane above (repeatable) |
| `Ctrl+Space` then `l` | Select pane to the right (repeatable) |

### Pane Layouts
| Key | Action |
|-----|--------|
| `Ctrl+Space` then `Space` | Cycle through pane layouts |
| `Ctrl+Space` then `z` | Toggle pane zoom (fullscreen) |

---

## Session Management

| Key | Action |
|-----|--------|
| `Ctrl+Space` then `^` | Switch to last used session |
| `Ctrl+Space` then `F` | Launch fuzzy session switcher (script `t`) |
| `Ctrl+Space` then `D` | Open dotfiles directory (`~/documents/dotfiles`) |
| `Ctrl+Space` then `d` | Detach from session |
| `Ctrl+Space` then `$` | Rename current session |

---

## Copy Mode (Vi-mode)

### Entering Copy Mode
| Key | Action |
|-----|--------|
| `Ctrl+Space` then `[` | Enter copy mode |
| `Ctrl+Space` then `PgUp` | Enter copy mode and scroll up |

### Navigation in Copy Mode (Vi-mode enabled)
| Key | Action |
|-----|--------|
| `h/j/k/l` | Move cursor (vim-style) |
| `w/b` | Jump forward/backward by word |
| `f<char>` | Jump to next occurrence of character |
| `0` | Jump to start of line |
| `$` | Jump to end of line |
| `g` | Jump to top of buffer |
| `G` | Jump to bottom of buffer |
| `Ctrl+u` | Scroll up half page |
| `Ctrl+d` | Scroll down half page |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |

### Copying in Copy Mode
| Key | Action |
|-----|--------|
| `v` | Begin selection (visual mode) |
| `V` | Begin line selection |
| `y` | Copy selection to tmux buffer |
| `Enter` | Copy selection and exit copy mode |
| `Escape` | Exit copy mode |

### Pasting
| Key | Action |
|-----|--------|
| `Ctrl+Space` then `]` | Paste from tmux buffer |
| `Ctrl+Space` then `y` | Copy tmux buffer to system clipboard (xclip) |

---

## Mouse Support

Mouse mode is **enabled** in your configuration:

- Click pane to select it
- Click window in status bar to switch
- Drag pane border to resize
- Scroll with mouse wheel (enters copy mode automatically)
- Click and drag to select text (copies on release)

---

## Configuration Details

### Behavior
- **Vi mode**: Enabled for copy mode navigation
- **Base index**: Windows and panes start at 1 (not 0)
- **History**: 10,000 lines of scrollback
- **Auto-rename**: Windows rename based on current command
- **Renumber**: Windows renumber when one is closed
- **Detach on destroy**: Disabled (switches to another session)
- **Escape time**: 0ms (no delay for Neovim mode switching)

### Visual
- **Mouse**: Enabled
- **Terminal**: Inherits `$TERM` variable
- **Undercurl**: Enabled for better diagnostics display
- **Status bar**: Shows session name (left) and pane title (right)
- **Activity monitoring**: Enabled but notifications disabled

---

## Tips & Workflows

### Quick Session Switching
1. Press `Ctrl+Space` then `F` to launch fuzzy finder
2. Type project name to filter
3. Press Enter to switch/create session

### Working with Neovim
- Use `Ctrl+h/j/k/l` to navigate between tmux panes and Neovim splits seamlessly
- No prefix needed - it detects when you're in Neovim

### Reloading Config
1. Edit `~/.tmux.conf`
2. Press `Ctrl+Space` then `r` to reload
3. Confirmation message appears

### Creating a Development Layout
```bash
# In a new window:
Ctrl+Space then c          # New window
Ctrl+Space then |          # Split vertically
Ctrl+Space then -          # Split horizontally (in right pane)
Ctrl+h/j/k/l              # Navigate between panes
```

### Copying to System Clipboard
1. Enter copy mode: `Ctrl+Space` then `[`
2. Navigate and select text with `v`
3. Copy: `y`
4. Copy to system clipboard: `Ctrl+Space` then `y`

---

## Default Tmux Commands (Still Available)

| Key | Action |
|-----|--------|
| `Ctrl+Space` then `,` | Rename current window |
| `Ctrl+Space` then `.` | Move window to another index |
| `Ctrl+Space` then `(` | Switch to previous session |
| `Ctrl+Space` then `)` | Switch to next session |
| `Ctrl+Space` then `s` | List and select sessions |
| `Ctrl+Space` then `w` | List and select windows |
| `Ctrl+Space` then `t` | Show clock |
| `Ctrl+Space` then `{` | Swap pane with previous |
| `Ctrl+Space` then `}` | Swap pane with next |

---

## Common Tasks

### Resize Panes
1. `Ctrl+Space` then `:resize-pane -L 5` (resize left 5 cells)
2. Or use mouse dragging on pane borders

### Create Named Session
```bash
tmux new -s session-name
```

### Attach to Existing Session
```bash
tmux attach -t session-name
# Or use: Ctrl+Space then F (fuzzy finder)
```

### Kill Session
```bash
# From inside session:
Ctrl+Space then :kill-session

# From outside:
tmux kill-session -t session-name
```
