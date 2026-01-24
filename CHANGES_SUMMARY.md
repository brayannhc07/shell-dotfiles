# LSP Configuration Changes Summary

## Files Modified

### 1. `nvim/lua/plugins/lsp.lua`
**Changes:**
- ✅ Removed Angular LSP configuration (not needed)
- ✅ Removed Vue TypeScript plugin with incorrect hardcoded path
- ✅ Updated `ensure_installed` list to include: tailwindcss, jsonls, emmet_ls
- ✅ Simplified TypeScript setup for Next.js/React (removed Vue support)
- ✅ Disabled LSP formatting for TypeScript, Python, and PHP (using dedicated formatters)
- ✅ Removed conflicting `<leader>cf` keybinding (now handled by conform.nvim)
- ✅ Updated Emmet configuration (removed Angular/Vue/Svelte)

## Files Created

### 2. `nvim/lua/plugins/conform.lua` (NEW)
**Purpose:** Modern formatting plugin
**Features:**
- Prettier for JS/TS/React/JSON/CSS/HTML
- Black + isort for Python
- CSharpier for C#
- php-cs-fixer for PHP
- Format on save enabled (500ms timeout)
- Keybinding: `<leader>cf`

### 3. `nvim/lua/plugins/mason-tool-installer.lua` (NEW)
**Purpose:** Auto-install formatters and linters
**Tools installed:**
- prettier, black, isort, stylua, shfmt, csharpier
- eslint_d (faster ESLint daemon)
- pylint

### 4. `nvim/lua/plugins/nvim-lint.lua` (NEW)
**Purpose:** Async linting
**Linters:**
- eslint_d for JS/TS/React
- pylint for Python
- Runs on: save, buffer enter, insert leave
- Manual trigger: `<leader>cl`

### 5. `NEOVIM_SETUP.md` (NEW)
**Purpose:** Complete setup and usage guide
**Contains:**
- Installation instructions
- Language-specific guides (C#, TypeScript/React, Python)
- Keybindings reference
- Troubleshooting guide
- Development workflows

## What You Need to Do

### Step 1: Restart Neovim
```bash
nvim
```

Lazy.nvim will automatically:
1. Install new plugins (conform, mason-tool-installer, nvim-lint)
2. Download missing LSP servers
3. Install formatters and linters

**First launch might take 1-2 minutes.**

### Step 2: Verify Installation

Open Neovim and run:
```vim
:checkhealth lsp
:Mason
:Lazy
```

Everything should show as installed and healthy.

### Step 3: Test Each Language

**Test C# / ASP.NET:**
```bash
nvim test.cs
```
- Type some C# code
- Check `:LspInfo` shows OmniSharp attached
- Save to trigger auto-format

**Test TypeScript/React:**
```bash
nvim test.tsx
```
- Type some React JSX
- Check `:LspInfo` shows ts_ls attached
- Save to trigger Prettier formatting

**Test Python:**
```bash
nvim test.py
```
- Type some Python code
- Check `:LspInfo` shows Pyright attached
- Save to trigger Black formatting

## Optional: Install Additional Tools

### For PHP Development
```bash
composer global require friendsofphp/php-cs-fixer
```

### For C# (if not auto-installed)
```bash
dotnet tool install -g csharpier
```

## New Keybindings

| Key | Action | Plugin |
|-----|--------|--------|
| `<leader>cf` | Format file or selection | conform.nvim |
| `<leader>cl` | Manually trigger linting | nvim-lint |

**Note:** `<leader>cf` was previously mapped to LSP format, now uses conform.nvim instead.

## What Was Removed

- ❌ Angular LSP server (`angularls`)
- ❌ Vue TypeScript plugin configuration
- ❌ LSP-based formatting (replaced with conform.nvim)
- ❌ `<leader>cf` mapping to `vim.lsp.buf.format`

## Benefits

### Before:
- ❌ Vue plugin pointed to wrong path
- ❌ Missing formatters for TS/Python
- ❌ No ESLint integration
- ❌ Format-on-save not configured
- ❌ Some LSP servers missing from auto-install

### After:
- ✅ Clean Next.js/React setup
- ✅ Prettier formatting on save
- ✅ ESLint live diagnostics
- ✅ Black/isort for Python
- ✅ CSharpier for C#
- ✅ All LSP servers auto-install
- ✅ Consistent formatting across languages

## Configuration Files Location

```
nvim/lua/plugins/
├── lsp.lua                    # LSP servers (UPDATED)
├── conform.lua                # Formatting (NEW)
├── mason-tool-installer.lua   # Auto-install tools (NEW)
└── nvim-lint.lua             # Linting (NEW)
```

## Need Help?

See `NEOVIM_SETUP.md` for:
- Detailed setup instructions
- Troubleshooting guide
- Language-specific workflows
- Tips and best practices

## Rollback (if needed)

If you encounter issues, you can rollback:

```bash
cd ~/documents/shell-dotfiles
git status  # See changes
git diff nvim/lua/plugins/lsp.lua  # Review changes
git checkout nvim/lua/plugins/lsp.lua  # Revert if needed
```

To remove new plugins, delete the files:
```bash
rm nvim/lua/plugins/conform.lua
rm nvim/lua/plugins/mason-tool-installer.lua
rm nvim/lua/plugins/nvim-lint.lua
```

Then restart Neovim.

---

**Your Neovim is now optimized for ASP.NET, Next.js, and Python development!** 🚀
