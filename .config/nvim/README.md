# Neovim Configuration

This is a clean, modular Neovim configuration based on Kickstart.nvim.

## Structure

```
~/.config/nvim/
├── init.lua                    # Entry point (23 lines)
├── lua/
│   ├── config/                 # Core Neovim configuration
│   │   ├── options.lua         # Vim options (hlsearch, number, mouse, etc.)
│   │   ├── autocmds.lua        # Autocommands (yank highlight, etc.)
│   │   └── lsp.lua             # LSP setup, mason, on_attach
│   ├── keymaps.lua             # Global keymappings
│   └── plugins/                # Plugin specifications
│       ├── init.lua            # Simple plugins (fugitive, sleuth, etc.)
│       ├── lsp.lua             # LSP plugin definition
│       ├── cmp.lua             # Completion configuration
│       ├── telescope.lua       # Telescope configuration
│       ├── treesitter.lua      # Treesitter configuration
│       ├── gitsigns.lua        # Git signs configuration
│       ├── theme.lua           # Colorscheme
│       ├── lualine.lua         # Statusline
│       ├── indent-blankline.lua
│       ├── comment.lua
│       └── which-key.lua
```

## How It Works

### init.lua
The main entry point is now very simple:
1. Sets leader keys
2. Bootstraps lazy.nvim plugin manager
3. Loads all plugins from `lua/plugins/`
4. Requires core config modules

### Adding New Plugins
To add a new plugin, create a new file in `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
  'author/plugin-name',
  config = function()
    require('plugin-name').setup({
      -- your config here
    })
  end,
}
```

Lazy.nvim will automatically load it!

### Modifying Settings
- **Vim options**: Edit `lua/config/options.lua`
- **Keymaps**: Edit `lua/keymaps.lua`
- **LSP servers**: Edit `lua/config/lsp.lua`
- **Plugin configs**: Edit the respective file in `lua/plugins/`

## Benefits

- **Clean entry point**: init.lua is now 23 lines instead of 627
- **Modular**: Each concern in its own file
- **Maintainable**: Easy to find and modify specific configs
- **Extensible**: Add new plugins by creating new files
- **Organized**: Clear separation between core config and plugins
