# Neovim LSP & Formatting Setup Guide

## Overview

Your Neovim configuration has been optimized for **ASP.NET (C#)**, **Next.js (TypeScript/React)**, and **Python** development with proper LSP servers, formatters, and linters.

**Compatible with Neovim 0.11+** using the modern LSP configuration API.

---

## Changes Made

### 1. LSP Configuration (`nvim/lua/plugins/lsp.lua`)

**Fixed Issues:**
- ✅ Removed Angular LSP (not needed)
- ✅ Removed Vue TypeScript plugin with hardcoded path
- ✅ Simplified TypeScript configuration for Next.js/React
- ✅ Added all LSP servers to `ensure_installed` list
- ✅ Disabled LSP formatting in favor of dedicated formatters

**Language Servers Installed:**
- `omnisharp` - C# / ASP.NET
- `pyright` - Python
- `ts_ls` - TypeScript/JavaScript/React
- `intelephense` - PHP/Laravel
- `tailwindcss` - Tailwind CSS
- `jsonls` - JSON with schema validation
- `emmet_ls` - HTML/CSS abbreviations

### 2. New Plugins Added

**Conform.nvim** (`nvim/lua/plugins/conform.lua`)
- Modern formatting plugin
- Format on save enabled
- Language-specific formatters configured

**Mason Tool Installer** (`nvim/lua/plugins/mason-tool-installer.lua`)
- Auto-installs formatters and linters
- No manual installation needed

**Nvim-lint** (`nvim/lua/plugins/nvim-lint.lua`)
- Async linting with ESLint and Pylint
- Runs on save and file changes

---

## Installation & First Launch

### Step 1: Restart Neovim
```bash
nvim
```

### Step 2: Wait for Plugin Installation
Lazy.nvim will automatically:
1. Download new plugins (conform, mason-tool-installer, nvim-lint)
2. Install LSP servers via Mason
3. Install formatters and linters

### Step 3: Verify Installation
```vim
:checkhealth lsp          " Check LSP health
:Mason                    " See installed servers/tools
:Lazy                     " See plugin status
```

### Step 4: Install Additional Tools (Optional)

For **PHP formatting**, install php-cs-fixer globally:
```bash
composer global require friendsofphp/php-cs-fixer
```

For **C# formatting**, ensure dotnet tools are accessible:
```bash
dotnet tool install -g csharpier
```

---

## Language-Specific Setup

### C# / ASP.NET

**LSP Server:** OmniSharp
**Formatter:** CSharpier (auto-installed)

**Features:**
- IntelliSense and code completion
- Go to definition/references
- Roslyn analyzers enabled
- Auto-import completion
- Format on save

**Test in Neovim:**
```bash
nvim MyController.cs
```

### TypeScript/React (Next.js)

**LSP Server:** ts_ls
**Formatter:** Prettier (auto-installed)
**Linter:** ESLint (eslint_d - faster daemon version)

**Features:**
- TypeScript IntelliSense
- React component intelligence
- Auto-import
- JSX/TSX support
- Format on save with Prettier
- Live ESLint diagnostics

**Test in Neovim:**
```bash
nvim app/page.tsx
```

**Create Next.js Project:**
```bash
npx create-next-app@latest my-app
cd my-app
npm install
nvim .
```

### Python

**LSP Server:** Pyright
**Formatter:** Black + isort (auto-installed)
**Linter:** Pylint (auto-installed)

**Features:**
- Type checking
- Auto-completion
- Import organization (isort)
- Format on save (Black)
- PEP 8 linting

**Test in Neovim:**
```bash
nvim main.py
```

---

## Keybindings

### LSP Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to where symbol is defined |
| `gi` | Go to implementation | View implementations (Telescope) |
| `gr` | Go to references | View all references (Telescope) |
| `K` | Hover documentation | Show type info/docs |
| `<leader>rn` | Rename symbol | Refactor rename across project |
| `<leader>ca` | Code actions | Show available fixes/refactorings |

### Diagnostics (Errors/Warnings)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>d` | Open diagnostic float | Show error details in popup |
| `[d` | Previous diagnostic | Jump to previous error/warning |
| `]d` | Next diagnostic | Jump to next error/warning |

### Formatting & Linting
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>cf` | Format file | Format current file or selection |
| `<leader>cl` | Trigger linting | Manually run linter |

**Note:** Format on save is **enabled** by default. Linting runs automatically on save.

---

## Formatting Configuration

### Per-Language Settings

**JavaScript/TypeScript/React:**
- Tab width: 2 spaces
- Single quotes enabled
- Trailing commas: ES5
- Semicolons: auto

**Python:**
- Line length: 88 characters (Black default)
- Import sorting: isort

**C#:**
- Uses CSharpier defaults

### Disable Format on Save

If you prefer manual formatting, edit `nvim/lua/plugins/conform.lua`:

```lua
-- Comment out or remove this section:
format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
},
```

Then use `<leader>cf` to format manually.

---

## Troubleshooting

### LSP Server Not Attaching

**Check server status:**
```vim
:LspInfo
```

**Expected output:** Should show attached servers for the current file type.

**If not attached:**
1. Check if server is installed: `:Mason`
2. Install manually: `:MasonInstall ts_ls` (or omnisharp, pyright, etc.)
3. Restart Neovim

### Formatter Not Working

**Check formatter availability:**
```vim
:ConformInfo
```

**Install missing formatter:**
```vim
:Mason
```
Find the formatter (prettier, black, etc.) and press `i` to install.

### ESLint Not Working in Next.js

**Ensure ESLint is configured in your project:**
```bash
npm install --save-dev eslint eslint-config-next
```

**Create `.eslintrc.json`:**
```json
{
  "extends": "next/core-web-vitals"
}
```

### Python Imports Not Organizing

**Ensure isort is installed:**
```vim
:Mason
```
Search for `isort` and install it.

### OmniSharp Taking Too Long

**First launch is slow** as it analyzes the project. Subsequent launches are faster.

**Speed up by:**
1. Close unused solution files
2. Ensure .NET SDK is up to date
3. Add `.omnisharp` directory to `.gitignore`

---

## Development Workflows

### Next.js Development

```bash
# Create new Next.js app
npx create-next-app@latest my-next-app --typescript
cd my-next-app

# Open in Neovim
nvim .

# Create component
nvim app/components/MyComponent.tsx
```

**In Neovim:**
1. Type component code
2. Save - auto-formats with Prettier
3. ESLint shows errors inline
4. Use `gd` to navigate imports
5. Use `<leader>ca` for auto-fix

### ASP.NET Development

```bash
# Create new Web API
dotnet new webapi -n MyApi
cd MyApi

# Open in Neovim
nvim .
nvim Controllers/WeatherForecastController.cs
```

**In Neovim:**
1. Wait for OmniSharp to load (~10 seconds first time)
2. Type C# code
3. Save - auto-formats with CSharpier
4. Use `K` on types for documentation
5. Use `<leader>rn` to rename

### Python Development

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate

# Open in Neovim
nvim main.py
```

**In Neovim:**
1. Type Python code
2. Save - auto-formats with Black and organizes imports
3. Pylint shows issues inline
4. Use `gi` to see implementations

---

## Tips & Best Practices

### Format Before Commit

Create a git pre-commit hook:
```bash
# .git/hooks/pre-commit
#!/bin/bash
nvim -c "bufdo execute 'normal <leader>cf' | write" -c "quit"
```

### Project-Specific Settings

Create `.nvim.lua` in project root:
```lua
-- Disable format on save for this project
vim.g.disable_autoformat = true

-- Or customize prettier for this project
require('conform').formatters.prettier = {
  prepend_args = { '--tab-width', '4' },
}
```

### Check What's Formatting Your File

```vim
:ConformInfo
```

Shows active formatters and their status.

### View LSP Logs

```vim
:LspLog
```

Useful for debugging LSP issues.

---

## Next Steps

### Recommended Additions

1. **Debugger (DAP)** - Add nvim-dap for debugging
2. **Testing** - You already have vim-test configured
3. **Git Integration** - You already have Fugitive and Gitsigns
4. **AI Completion** - You already have Windsurf/Codeium

### Learning Resources

- **LSP Keybindings:** `:help lsp`
- **Conform.nvim:** `:help conform`
- **Telescope:** `<leader>fh` (help tags)

---

## Summary

Your Neovim setup now includes:

✅ **LSP Servers:** C#, TypeScript, Python, PHP, Tailwind, JSON, HTML
✅ **Formatters:** Prettier, Black, CSharpier, php-cs-fixer
✅ **Linters:** ESLint, Pylint
✅ **Auto-format on save:** Enabled
✅ **Auto-linting:** Enabled
✅ **Consistent keybindings:** Across all languages

**Your main keybindings:**
- `<leader>cf` - Format
- `gd` - Go to definition
- `gr` - Find references
- `<leader>ca` - Code actions
- `K` - Documentation

Enjoy your improved Neovim experience! 🚀
