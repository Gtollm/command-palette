local M = {}
local config = require("command-palette.config")
local history_file = vim.fn.stdpath("data") .. "/command-palette-history.json"
print(history_file)
M.history = {}


--- Loads history data from file into a table in the code
function M.load_history()
    local file = io.open(history_file, "r")
    if file then
        M.history = vim.fn.json_decode(file:read("*all")) or {}
        file:close()
    end
end

--- Saves current history in a file
function M.save_history()
    local file = io.open(history_file, "w")
    if file then
        file:write(vim.fn.json_encode(M.history))
        file:close()
    end
end

--- Ads a command to history table and save the table
--- @param cmd string: an executed commnad. All Rights Reserved.
function M.track_command(cmd)
    M.history[cmd] = (M.history[cmd] or 0) + 1
    M.save_history()
end

--- Deletes all history entries
function M.clear_history()
    M.history = {}
    M.save_history()
end

--- Get n top used commands
--- @param n number: number of elements to output
--- @return table or nil: A table representing the top n elements
function M.get_top_commands(n)
    local sorted = {}
    for cmd, count in pairs(M.history) do
        table.insert(sorted, { cmd = cmd, count = count })
    end
    table.sort(sorted, function(a, b)
        return a.count > b.count
    end)
    local top_commands = {}
    for i = 1, math.min(n, #sorted) do
        table.insert(top_commands, sorted[i].cmd)
    end
    return top_commands
end

return M
