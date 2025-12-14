return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"json-lsp",
				"gopls",
				"pyright",
				"lemminx", -- XML
				"marksman", -- Markdown
				"taplo", -- TOML
				"yaml-language-server",
				"bash-language-server",
			},
		},
	},
}
