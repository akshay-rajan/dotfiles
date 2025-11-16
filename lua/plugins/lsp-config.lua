function LSPKeyMaps(client, bufnr)
	local opts = { buffer = bufnr, silent = true, noremap = true }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
	vim.keymap.set("n", "<leader>x", function()
		vim.diagnostic.open_float(0, { scope = "line" })
	end, opts)
end

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "ts_ls" },
                capabilities = capabilities,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config["luals"] = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = { vim.env.VIMRUNTIME, vim.fn.stdpath("config") },
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
				on_attach = LSPKeyMaps,
			}
			vim.lsp.enable("luals")

			vim.lsp.config["pyright"] = {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = { "pyproject.toml", "setup.py", ".git" },
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic", -- options: "off", "basic", "strict"
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
				on_attach = LSPKeyMaps,
			}
			vim.lsp.enable("pyright")

			vim.lsp.config["ts_ls"] = {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
				settings = {
					-- ts_ls has few server-side settings; you can add if needed
				},
				on_attach = LSPKeyMaps,
			}
			vim.lsp.enable("ts_ls")
		end,
	},
	{
		vim.diagnostic.config({
			virtual_text = {
				prefix = "",
				spacing = 4,
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		}),
	},
}
