local M = {}
local history = require("command-palette.history")

--- Get all available commands
--- @return table: A table representing all possible neovim commands
local function get_all_commands()
    local commands = vim.api.nvim_get_commands({})
    local command_names = {}
    for name, _ in pairs(commands) do
        table.insert(command_names, name)
    end
    return command_names
end

--- Fuzzy search implementation with frequency from history
--- @param commands table: table of all possible neovim commands
--- @param query string: line to be compared to commands
--- @return table or nil: A sorted table of most suitable commands
local function fuzzy_search(commands, query)
    local frequency = history.history;
    local results = {}
    query = query:lower()

    for _, cmd in ipairs(commands) do
        local cmd_lower = cmd:lower()
        if cmd_lower:find(query, 1, true) then
            table.insert(results, { command = cmd, frequency = frequency[cmd] or 0 })
        end
    end

    table.sort(results, function(a, b)
        return a.frequency > b.frequency
    end)

    local sorted_commands = {}
    for _, result in ipairs(results) do
        table.insert(sorted_commands, result.command)
    end

    return sorted_commands
end

--- Handling of input queries and output of commands
function M.show()
    local all_commands = get_all_commands()
    local filtered_commands = all_commands
    local selected_index = 1
    local query = ""
    local in_arrow_mode = true

    local results_buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.5)
    local height = math.floor(vim.o.lines * 0.4)
    local results_opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = (vim.o.lines - height) / 2,
        col = (vim.o.columns - width) / 2,
        border = "rounded",
    }
    local results_win = vim.api.nvim_open_win(results_buf, true, results_opts)

    --- Updates the output menu
    local function update_display()
        vim.api.nvim_buf_set_option(results_buf, "modifiable", true)
        vim.api.nvim_buf_set_lines(results_buf, 0, -1, false, {})

        local mode_indicator = in_arrow_mode and "[Arrow] " or "[Normal] "
        vim.api.nvim_buf_set_lines(results_buf, 0, -1, false, { mode_indicator .. "Query: " .. query })

        for i, cmd in ipairs(filtered_commands) do
            local prefix = (i == selected_index) and "> " or "  "
            vim.api.nvim_buf_set_lines(results_buf, -1, -1, false, { prefix .. cmd })
        end

        vim.api.nvim_buf_set_option(results_buf, "modifiable", false)
    end

    --- Updates the output commands results
    local function refresh_search()
        filtered_commands = fuzzy_search(all_commands, query)
        selected_index = 1
        update_display()
    end

    --- Input of quires handler
    local function handle_input()
        refresh_search()
        while true do
            local char = vim.fn.getchar()

            local key = vim.fn.nr2char(char)

            if not key:match("%w") then
                if key == vim.api.nvim_replace_termcodes("<CR>", true, true, true) then
                    local cmd = filtered_commands[selected_index]
                    vim.api.nvim_win_close(results_win, true)
                    vim.cmd(cmd)
                    history.track_command(cmd)
                    break
                elseif key == vim.api.nvim_replace_termcodes("<Esc>", true, true, true) then
                    vim.api.nvim_win_close(results_win, true)
                    break
                elseif key == vim.api.nvim_replace_termcodes("<Tab>", true, true, true) then
                    if in_arrow_mode then
                        in_arrow_mode = false
                        update_display()
                    else
                        in_arrow_mode = true
                        update_display()
                    end
                elseif char == vim.api.nvim_replace_termcodes("<BS>", true, true, true) then
                    query = string.sub(query, 1, -2)
                    if in_arrow_mode then
                        update_display()
                        refresh_search()
                    end
                elseif char == vim.api.nvim_replace_termcodes("<Up>", true, false, true) then
                    selected_index = math.max(1, selected_index - 1)
                    update_display()
                elseif char == vim.api.nvim_replace_termcodes("<Down>", true, false, true) then
                    selected_index = math.min(#filtered_commands, selected_index + 1)
                    update_display()
                end
            elseif key == "i" and not in_arrow_mode then
                if not in_arrow_mode then
                    in_arrow_mode = true
                    update_display()
                end
            elseif key == "j" and not in_arrow_mode then
                selected_index = math.min(#filtered_commands, selected_index + 1)
                update_display()
            elseif key == "k" and not in_arrow_mode then
                selected_index = math.max(1, selected_index - 1)
                update_display()
            elseif in_arrow_mode then
                char = vim.fn.nr2char(char)
                query = query .. char
                refresh_search()
            end
        end
    end

    update_display()
    handle_input()
end

return M
