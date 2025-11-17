-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local function publish_branch()
  -- 1. Get the current branch name
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")

  if branch == "" then
    vim.notify("Could not detect branch name.", vim.log.levels.ERROR)
    return
  end

  -- 2. Run the push command
  local cmd = "git push origin -u " .. branch
  vim.notify("Running: " .. cmd)

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.notify(table.concat(data, "\n"))
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Successfully pushed branch '" .. branch .. "'!", vim.log.levels.INFO)
      else
        vim.notify("git push failed (exit code " .. code .. ")", vim.log.levels.ERROR)
      end
    end,
  })
end

-- Command: :PublishBranch
vim.api.nvim_create_user_command("PublishBranch", publish_branch, {})
