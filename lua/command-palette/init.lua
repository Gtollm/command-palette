local M = {}

local config = require("command-palette.config")
local history = require("command-palette.history")
local palette = require("command-palette.palette")

--- Setup function
--- @param opt table: config table
function M.setup(opts)
    config.set_options(opts)

    history.load_history()

    vim.api.nvim_set_keymap(
        "n",
        config.options.palette_keymap,
        ":CommandPalette<CR>",
        { noremap = true, silent = true }
    )

    M.register_commands()
end

--- Register all necessary commands
function M.register_commands()
    vim.api.nvim_create_user_command(
        "CommandPalette",
        function() palette.show() end,
        { desc = "Open the Command Palette with fuzzy search" }
    )

    vim.api.nvim_create_user_command(
        "CommandPaletteClearHistory",
        function()
            history.clear_history()
            print("Command palette history cleared.")
        end,
        { desc = "Clear the Command Palette history" }
    )

    vim.api.nvim_create_user_command(
        "CommandPaletteTopCommands",
        function()
            local top_commands = history.get_top_commands(config.options.top_history)
            print("Top Commands:")
            for i, cmd in ipairs(top_commands) do
                print(i .. ". " .. cmd)
            end
        end,
        { desc = "Show top n most frequently used commands in the Command Palette" }
    )
end

return M
