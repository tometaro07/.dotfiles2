local lsp = vim.lsp

lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" } }
        }
    }
})
