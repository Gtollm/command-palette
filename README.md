# Command Palette for Neovim

`Command Palette` is a Neovim plugin that allows you to easily search and execute commands with fuzzy matching, showing results based on command frequency. It streamlines the process of finding and executing commands, improving your productivity when working in Neovim.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Why Use `Command Palette`?](#why-use-command-palette)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Fuzzy search for commands**: Quickly find and execute Neovim commands with fuzzy search, making it easy to recall and run commands without memorizing their exact names.
- **Command history**: View the most frequently used commands and access them again with just a few keystrokes.
- **Clear command history**: Start fresh by clearing the history of previously run commands. This is useful if you want to reset your command history.
- **Highly customizable**: Configure keybindings, the number of top commands to display, and more.

## Installation

You can easily install `Command Palette` using your preferred plugin manager.

### Using `lazy.nvim`

If you are using [lazy.nvim](https://github.com/folke/lazy.nvim), you can add the following to your `init.lua`:

```lua
{
  'Gtollm/command-palette.nvim',
  config = function()
    local plugin = require('command-palette')

    -- Configure plugin options
    plugin.set_options({
      palette_keymap = "cp",  -- Keymap to open the command palette (default is 'cp')
      top_history = 10,       -- Number of top commands to display in the command palette
    })
  end,
}
```

### Using `packer.nvim`

If you're using [packer.nvim](https://github.com/wbthomason/packer.nvim), add this to your `init.lua`:

```lua
use {
  'Gtollm/command-palette.nvim',
  config = function()
    local plugin = require('command-palette')

    -- Set your configuration options
    plugin.set_options({
      palette_keymap = "cp",  -- Change the keymap if needed
      top_history = 10,       -- Show top 10 most frequently used commands in the palette
    })
  end,
}
```

### Using `vim-plug`

For those using [vim-plug](https://github.com/junegunn/vim-plug), add the following to your `.vimrc` or `init.vim`:

```vim
Plug 'Gtollm/command-palette.nvim'

" Configuration in your init.vim or init.lua
lua << EOF
  local plugin = require('command-palette')

  plugin.set_options({
    palette_keymap = "cp",  -- Custom keymap for the command palette
    top_history = 10,       -- Customize the number of top commands shown
  })
EOF
```

## Usage

Once installed, the plugin offers several useful commands to interact with the command palette.

### Commands

- **`:CommandPalette`**  
  Opens the command palette window, allowing you to search for and execute any command using fuzzy matching. This is the core feature of the plugin, providing a quick way to access commands without needing to remember their full names or exact keymaps.

- **`:CommandPaletteClearHistory`**  
  Clears the history of commands that have been run in the current or previous Neovim sessions. This can be helpful if you want to reset the history and remove commands that are no longer relevant.

- **`:CommandPaletteTopCommands`**  
  Displays the top N most frequently used commands. This is a great way to quickly access the commands you use most often. You can configure the number of commands shown by adjusting the `top_history` setting.

## Configuration

While the plugin works right out of the box, there are several options you can customize to suit your workflow.

### Default Keymap

You can customize the keymap that opens the command palette. By default, the keymap is `cp`. If you want to change this to something else (for example, `Ctrl+p` or any other shortcut), you can configure it using the `palette_keymap` option.

#### Example:

```lua
plugin.set_options({
  palette_keymap = "cp",  -- Default is "cp", change to your preferred keybinding
})
```

You can choose any keymap that is convenient for you. This allows you to open the command palette easily while working in Neovim.

### Top Command History

You can configure how many of the most frequently used commands to display in the command palette. By default, the plugin will show a smaller number of commands, but you can customize this to show more or fewer based on your preferences.

#### Example:

```lua
plugin.set_options({
  top_history = 10,  -- Show top 10 most frequently used commands
})
```

This option is useful if you tend to use certain commands very often, as it gives you quick access to them directly from the palette.

### Clear Command History

The history of commands is saved across Neovim sessions. If you want to start fresh or clear the history after using certain commands, you can use the `:CommandPaletteClearHistory` command to remove all previous commands.

This option helps you keep the history relevant and avoid cluttering the command palette with outdated commands.

## Keymaps and Shortcuts

After configuring the `palette_keymap`, you can use your custom shortcut to open the command palette. For example, if you've set it to `Ctrl+p`, you can press `Ctrl+p` to quickly open the palette and start searching for a command.

Feel free to configure the keymap to suit your workflow, whether it’s a common key combination or something unique to your setup.

## Why Use `Command Palette`?

The `Command Palette` plugin simplifies the process of finding and running commands in Neovim. Whether you are new to Neovim or a seasoned user, the fuzzy search and command history features make it faster and easier to access commands without remembering all their names. 

By using this plugin, you can:

- Access any command in Neovim with a few keystrokes.
- Quickly execute frequently used commands without searching through your `.vimrc` or plugin list.
- Start fresh by clearing your command history when necessary.
- Customize keymaps and behavior to match your personal preferences.

## Contributing

Contributions are welcome! Please feel free to submit issues, pull requests, or suggest improvements. To contribute:

Fork the project.
Create your feature branch (git checkout -b feature/YourFeature).
Commit your changes (git commit -m 'Add YourFeature').
Push to the branch (git push origin feature/YourFeature).
Open a pull request.

## License

This plugin is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute it as needed.

