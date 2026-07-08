--------------------------------------------------------------------------------
-- Mason
--------------------------------------------------------------------------------

require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "ts_ls",
        "svelte",
    },
})

--------------------------------------------------------------------------------
-- Capabilities
--------------------------------------------------------------------------------

local capabilities = require("blink.cmp").get_lsp_capabilities()

--------------------------------------------------------------------------------
-- LSP Servers
--------------------------------------------------------------------------------

local servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },

                diagnostics = {
                    globals = { "vim" },
                },

                workspace = {
                    checkThirdParty = false,
                },

                telemetry = {
                    enable = false,
                },
            },
        },
    },

    pyright = {},

    ts_ls = {},

    svelte = {},
}

for name, config in pairs(servers) do
    config.capabilities = capabilities
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end

--------------------------------------------------------------------------------
-- Diagnostics
--------------------------------------------------------------------------------

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,

    float = {
        border = "rounded",
        source = "if_many",
    },
})

--------------------------------------------------------------------------------
-- LSP Keymaps
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    end,
})
