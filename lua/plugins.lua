vim.pack.add {
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/mbbill/undotree" },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = "https://github.com/ThePrimeagen/harpoon", name = "harpoon" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/folke/lazy.nvim" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/kdheepak/lazygit.nvim" },
}

require("diffview").setup({
    enhanced_diff_hl = true,
    view = {
        default = {
            layout = "diff2_horizontal",
        },
        merge_tool = {
            layout = "diff3_horizontal",
        },
    },
})

require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 300,
    },
})

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            ".git/",
        },
    },
})

require("oil").setup({
    default_file_explorer = true,
    columns = { "icon", "git_status" },
    keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-c>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["<M-h>"] = "actions.select_split",
        ["q"] = "actions.close",
    },
    delete_to_trash = true,
    view_options = {
        show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
})

local harpoon = require("harpoon")
harpoon:setup()

require("lualine").setup()

require("catppuccin").setup({})

vim.cmd.colorscheme "catppuccin-nvim"
