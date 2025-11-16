local function get_python_path()
	-- if activated virtualenv, use that
	local venv = os.getenv("VIRTUAL_ENV")
	if venv and venv ~= "" then
		return venv .. "/bin/python"
	end

	-- pipenv / poetry venv detection (common paths)
	local cwd = vim.fn.getcwd()
	-- pipenv: PIPENV_ACTIVE and PIPENV_VENV? fallback: check .venv in project
	if vim.fn.filereadable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	end

	-- Poetry: check poetry virtualenv
	-- (more complex detection can be added)
	-- fallback to system python
	return vim.fn.exepath("python") or "python"
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
        dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dap.adapters.python = {
			type = "executable",
			command = get_python_path(),
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			-- Launch current file
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = get_python_path(),
			},
			-- Launch current file with arguments (edit "args")
			{
				type = "python",
				request = "launch",
				name = "Launch file (args)",
				program = "${file}",
				args = function()
					local input = vim.fn.input("Program arguments: ")
					return vim.fn.split(input, " +")
				end,
				pythonPath = get_python_path(),
			},
			-- Launch pytest for current file
			{
				type = "python",
				request = "launch",
				name = "pytest file",
				program = "${file}",
				-- you can use "-m pytest -k <testname>" pattern, but simpler:
				pythonPath = get_python_path(),
				args = { "-m", "pytest", "${file}" },
			},
			-- Attach to a running debugpy (if you run debugpy --listen 5678)
			{
				type = "python",
				request = "attach",
				name = "Attach (connect)",
				connect = {
					host = "127.0.0.1",
					port = 5678,
				},
				mode = "remote",
				pythonPath = get_python_path(),
			},
		}

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue" })
		vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>dso", dap.step_out, { desc = "Step out" })
		vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
		vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
		vim.keymap.set("n", "<leader>du", function()
			dapui.toggle()
		end, { desc = "Toggle dapui" })
	end,
}
