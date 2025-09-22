return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore = false,
			suppress_dirs = { "~/", "~/Downloads" },
			show_auto_restore_notif = false,
		})

		vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "[W]ork [R]estore" })
	end,
}
