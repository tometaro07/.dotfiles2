local lsp = vim.lsp

lsp.config("ltex_plus", {
    settings = {
        ltex = {
            language = "en-GB",
            checkFrequency = "save",
        }
    }
})

lsp.config("texlab", {
    settings = {
        texlab = {
            build = { onSave = true },
            chktex = {
                onOpenAndSave = true,
                onEdit = false,
            },
        }
    }
})
