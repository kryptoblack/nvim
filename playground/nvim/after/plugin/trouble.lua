local trouble = require("trouble")

trouble.setup {
    height = 5,        -- height of the trouble list when position is top or bottom
    auto_open = true,  -- automatically open the list when you have diagnostics
    auto_close = true, -- automatically close the list when you have no diagnostics
    workspace = true,  -- automatically open/close the list at the workspace diagnostics
}
