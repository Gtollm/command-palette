local M = {}

M.options = {
    top_history = 10,      -- default number of elements to output as most used
    palette_keymap = "cp", --default value for start keymap
}
--- An ordinary function to merge user's and default parameters
function M.set_options(user_options)
    M.options = vim.tbl_extend("force", M.options, user_options or {})
end

--- Get value of an option by name
function M.get_option(name)
    return M.options[name]
end

return M
