require("mason").setup()
local mason = require("mason-lspconfig")
local lsp = vim.lsp
local api = vim.api

mason.setup {
    ensure_installed = { "lua_ls", "vimls", "ruff", "pyright", "texlab", "ltex_plus" },
    automatic_enable = { "lua_ls", "vimls", "ruff", "pyright", "texlab", "ltex_plus" }
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gd', lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", function() lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>n", function() vim.diagnostic.goto_next() end, opts) -- check a better keybind
        vim.keymap.set("n", "<leader>p", function() vim.diagnostic.goto_prev() end, opts) -- check a better keybind
        vim.keymap.set("n", "<leader>vca", function() lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() lsp.buf.rename() end, opts)
        vim.keymap.set('n', '<C-h>', lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>f', function() lsp.buf.format { async = true } end, opts)
    end,
})
