local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "J", "5j")
vim.keymap.set("n", "K", "5k")

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("n", "<leader>j", "/")
vim.keymap.set("n", "<leader>k", "?")

vim.keymap.set("n", "<C-a>", "ggVG")
vim.keymap.set({"v", "i"}, "<C-a>", "<C-c>ggVG")

-- paste over selection without loosing yanked
vim.keymap.set("x", "p", [["_dP]])

-- leader d delete wont remember as yanked/clipboard when delete pasting
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

-- format built in
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Replace the word cursor is on globally
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

-- restart 
vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", {
    desc = "Restart Neovim (:restart)",
})

vim.keymap.set("n", "<leader>lr", function()
    vim.cmd("lsp restart")
    vim.notify("LSP restarted", vim.log.levels.INFO)
end, { desc = "Restart LSP" })

--oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- fuzzy finder
-- Keymaps for Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Harpoon file" })
vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- git signs
local gs = require("gitsigns")
vim.keymap.set("n", "<leader>gp", gs.preview_hunk)
vim.keymap.set("n", "<leader>gr", gs.reset_hunk)
vim.keymap.set("n", "<leader>gs", gs.stage_hunk)
vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk)

vim.keymap.set("n", "<leader>gb", function()
    require("telescope.builtin").git_branches()
end)
vim.keymap.set("n", "<leader>gf", function()
    require("telescope.builtin").git_files()
end)

-- diffvew
-- Open file history 
vim.keymap.set("n", "<leader>gh", function()
    vim.cmd("DiffviewFileHistory")
end, { desc = "Git file history" })
-- Open repo diff 
vim.keymap.set("n", "<leader>gd", function()
    vim.cmd("DiffviewOpen")
end, { desc = "Git diff view" })
-- Close Diffview
vim.keymap.set("n", "<leader>gq", function()
    vim.cmd("DiffviewClose")
end, { desc = "Close diff view" })

-- git graph
vim.keymap.set("n", "<leader>gg", function()
    require("gitgraph").draw({}, {
        all = true,
        hooks = {
            on_select_commit = function(commit)
                -- open diffview for selected commit
                vim.cmd("DiffviewOpen " .. commit.hash .. "^!")
            end,
        },
    })
end, { desc = "Git graph" })
