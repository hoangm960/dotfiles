local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>ond", function()
	vim.cmd("cd " .. vim.fn.expand("~/.config/nvim"))
	vim.notify("Change directory to Neovim config")
end, { desc = "[O]pen [N]eovim config [D]irectory", silent = true })

keymap.set("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save", silent = true })
keymap.set(
	{ "i", "x" },
	"<C-S>",
	"<Esc><Cmd>silent! update | redraw<CR>",
	{ desc = "Save and go to Normal mode", silent = true }
)
keymap.set("n", "<leader>x", ":q<CR>", { desc = "Close current buffer", silent = true })
keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "[W]rite & [Q]uit", silent = true })
keymap.set("n", "<leader>qa", ":wqa<CR>", { desc = "[W]rite and [Q]uit [A]ll", silent = true })

keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "N", "Nzzzv", opts)
keymap.set("n", "n", "nzzzv", opts)

keymap.set("x", "<leader>p", [["_dP]], opts)

keymap.set("i", "<C-[>", "<Esc>", opts)
keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Turn off highlight", silent = true })

keymap.set("n", "Q", "<nop>", opts)
keymap.set("n", "x", '"_x', opts)

keymap.set("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[R]eplace [S]tring" })
keymap.set(
	"n",
	"<leader>rsc",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]],
	{ desc = "[R]eplace [S]tring with [C]onfirmation" }
)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

keymap.set("n", "<leader>sh", "<C-w>v", { desc = "[S]plit window [H]orizontally", silent = true })
keymap.set("n", "<leader>sv", "<C-w>s", { desc = "[S]plit window [V]ertically", silent = true })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus on left window", silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus on below window", silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus on above window", silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus on right window", silent = true })
keymap.set(
	"n",
	"<C-Right>",
	'"<Cmd>vertical resize -" . v:count1 . "<CR>"',
	{ expr = true, replace_keycodes = false, desc = "Decrease window width" }
)
keymap.set(
	"n",
	"<C-Down>",
	'"<Cmd>resize -" . v:count1 . "<CR>"',
	{ expr = true, replace_keycodes = false, desc = "Decrease window height" }
)
keymap.set(
	"n",
	"<C-Up>",
	'"<Cmd>resize +" . v:count1 . "<CR>"',
	{ expr = true, replace_keycodes = false, desc = "Increase window height" }
)
keymap.set(
	"n",
	"<C-Left>",
	'"<Cmd>vertical resize +" . v:count1 . "<CR>"',
	{ expr = true, replace_keycodes = false, desc = "Increase window width" }
)

keymap.set("n", "<leader>cfp", function()
	local filePath = vim.fn.expand("%:~")
	vim.fn.setreg("+", filePath)
	print("File path copied to clipboard: " .. filePath)
end, { desc = "[C]opy [F]ile [P]ath" })

keymap.set("n", "gO", "O<Esc>", { desc = "Put empty line above", silent = true })
keymap.set("n", "go", "o<Esc>", { desc = "Put empty line below", silent = true })
keymap.set("x", "g/", "<esc>/\\%V", { desc = "Search inside visual selection" })

keymap.set("c", "<M-h>", "<Left>", { silent = true, noremap = false, desc = "Left" })
keymap.set("c", "<M-l>", "<Right>", { silent = true, noremap = false, desc = "Right" })
keymap.set("i", "<M-h>", "<Left>", { silent = true, noremap = false, desc = "Left" })
keymap.set("i", "<M-j>", "<Down>", { silent = true, noremap = false, desc = "Down" })
keymap.set("i", "<M-k>", "<Up>", { silent = true, noremap = false, desc = "Up" })
keymap.set("i", "<M-l>", "<Right>", { silent = true, noremap = false, desc = "Right" })
keymap.set("t", "<M-h>", "<Left>", { silent = true, desc = "Left" })
keymap.set("t", "<M-j>", "<Down>", { silent = true, desc = "Down" })
keymap.set("t", "<M-k>", "<Up>", { silent = true, desc = "Up" })
keymap.set("t", "<M-l>", "<Right>", { silent = true, desc = "Right" })
