return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
		})

		vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "[W]ork [R]estore" })
	end,
}
