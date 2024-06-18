-- Git Blame
-- GitBlame is a plugin that integrates Git's blame functionality directly into Neovim. Here's what it does:

-- Show Blame Info: Displays information about who last modified a line of code and when it was modified.
-- Inline Display: This information is shown directly in the editor next to the line of code, making it easy to see the author and commit message without leaving the editor.
-- Real-time Updates: The blame information updates as you move your cursor through the code.
-- This is useful for understanding the history of changes in your codebase and for collaboration, as it provides context about why certain changes were made and by whom. 
return {
  -- https://github.com/f-person/git-blame.nvim
  'f-person/git-blame.nvim',
  event = 'VeryLazy',
  opts = {
    enabled = false, -- disable by default, enabled only on keymap
    date_format = '%m/%d/%y %H:%M:%S', -- more concise date format
  }
}

