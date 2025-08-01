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
        vim.keymap.set('n', 'gD', lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            lsp.buf.format { async = true }
        end, opts)
    end,
})
