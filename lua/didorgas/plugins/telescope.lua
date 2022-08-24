vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<Enter>", {})
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<Enter>", {})
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<Enter>", {})
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<Enter>", {})
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<Enter>", {})

require('telescope').setup({
    defaults = {
        file_ignore_patterns = { "bin/", "obj/", "node_modules", ".git" },
    },
    pickers = {
        find_files = {
            hidden = true,
            no_ignore = true,
        }
    },
    extensions = {}
})

require('telescope').load_extension('fzf')
