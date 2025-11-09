return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function smart_neotree_toggle()
      local neotree_open = false
      local neotree_winnr = nil

      -- Check if Neo-tree window exists
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if ft == "neo-tree" then
          neotree_open = true
          neotree_winnr = win
          break
        end
      end
      if not neotree_open then
        -- Neo-tree not open → open it
        vim.cmd("Neotree filesystem reveal left")
      elseif neotree_winnr ~= vim.api.nvim_get_current_win() then
        -- Neo-tree open but not focused → focus it
        vim.cmd("Neotree focus")
      else
        -- Neo-tree open and focused → close it
        vim.cmd("Neotree close")
      end
    end

    vim.keymap.set("n", "<C-n>", smart_neotree_toggle, { silent = true })

    -- Close neo-tree if it's the only window left
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        if vim.bo.filetype == "neo-tree" and vim.fn.winnr("$") == 1 then
          vim.cmd("quit")
        end
      end,
    })
  end
}
