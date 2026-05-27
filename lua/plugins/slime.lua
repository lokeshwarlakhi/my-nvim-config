-- ============================================================================
-- INTERACTIVE REPL SPLIT (VIM-SLIME & IPYTHON)
-- ============================================================================
-- Purpose: Setup a vertical terminal split running IPython on the right side
--          with automatic targeting for instant code execution.
-- ============================================================================

return {
  {
    "jpalardy/vim-slime",
    ft = { "python" }, -- Load only when editing Python files
    init = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = 1 -- Disable default mappings to prevent conflicts
    end,
    config = function()
      -- Helper function to detect local virtualenv ipython path or fall back to system
      local function get_ipython_cmd()
        local start_dir = vim.fn.getcwd()
        local dir = start_dir
        while dir and dir ~= "" and dir ~= "/" do
          local venvs = {
            dir .. "/.venv/bin/ipython",
            dir .. "/venv/bin/ipython",
            dir .. "/env/bin/ipython",
            dir .. "/.env/bin/ipython",
          }
          for _, path in ipairs(venvs) do
            if vim.fn.executable(path) == 1 then
              return path
            end
          end
          local parent = vim.fn.fnamemodify(dir, ":h")
          if parent == dir then break end
          dir = parent
        end
        return "ipython"
      end

      -- Launch IPython in a vertical split on the right
      local function launch_ipython_repl()
        -- Get active buffer
        local code_buf = vim.api.nvim_get_current_buf()
        
        -- Open vertical split to the right
        vim.cmd("rightbelow vsplit")
        
        -- Launch terminal running ipython
        local cmd = get_ipython_cmd()
        vim.cmd("terminal " .. cmd)
        
        -- Get the job ID of the spawned terminal
        local term_buf = vim.api.nvim_get_current_buf()
        local job_id = vim.bo[term_buf].terminal_job_id
        
        -- Configure terminal window options (disable line numbers)
        vim.wo.number = false
        vim.wo.relativenumber = false
        
        -- Return focus to the code buffer
        vim.cmd("wincmd p")
        
        -- Configure slime to direct code to this terminal automatically
        local config = { jobid = job_id }
        vim.b[code_buf].slime_config = config
        vim.g.slime_default_config = config
      end

      local keymap = vim.keymap.set
      
      -- Keybinding to start the IPython Split REPL
      keymap("n", "<leader>is", launch_ipython_repl, { desc = "Initialize IPython Split REPL", silent = true })

      -- Keybindings to send code to the active REPL
      keymap("x", "<leader>ss", "<Plug>SlimeRegionSend", { desc = "Send selected code to REPL" })
      keymap("n", "<leader>ss", "<Plug>SlimeLineSend", { desc = "Send current line to REPL" })
      keymap("n", "<leader>sp", "<Plug>SlimeParagraphSend", { desc = "Send paragraph to REPL" })
    end
  }
}
