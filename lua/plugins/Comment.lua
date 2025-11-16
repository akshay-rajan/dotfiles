return {
  "numToStr/Comment.nvim",
  config = function()
    require('Comment').setup()

    vim.keymap.set("n", "<leader>/", function()
      require('Comment.api').toggle.linewise.current()
    end, { noremap = true, silent = true })
    vim.keymap.set("v", "<leader>/", function()
      require('Comment.api').toggle.linewise(vim.fn.visualmode())
    end, { noremap = true, silent = true })
  end
}
