local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- File Hopping
Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x' })
    Plug('nvim-lua/plenary.nvim')
Plug('theprimeagen/harpoon', { ['branch'] = 'harpoon2' })

-- Syntax Highlighting
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-treesitter/playground')

-- LSP
Plug('mason-org/mason-lspconfig.nvim')
    Plug('mason-org/mason.nvim')
    Plug('neovim/nvim-lspconfig')

-- Autocompletion
Plug('hrsh7th/nvim-cmp')
    Plug('hrsh7th/cmp-nvim-lsp')
    Plug('hrsh7th/cmp-buffer')
    Plug('hrsh7th/cmp-path')
    Plug('hrsh7th/cmp-cmdline')
    Plug('hrsh7th/cmp-nvim-lsp-signature-help')
Plug('L3MON4D3/LuaSnip', {[ 'tag' ]= 'v2.*', [ 'do' ]= 'make install_jsregexp'})
    Plug('saadparwaiz1/cmp_luasnip')
    Plug("rafamadriz/friendly-snippets")

-- LaTex
Plug('lervag/vimtex')

-- Python
Plug('Vigemus/iron.nvim')

-- Others
Plug('mbbill/undotree')
Plug('tpope/vim-fugitive')
Plug('tpope/vim-surround')
Plug('windwp/nvim-autopairs')

-- Colour Schemes
Plug("rose-pine/neovim", {
    ['name'] = "rose-pine",
    ['config'] = function()
        vim.cmd("colorscheme rose-pine")
    end
})

vim.call('plug#end')
