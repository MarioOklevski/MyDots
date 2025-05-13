require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pylsp", "biome", "tailwindcss", "pyright"}	
})

