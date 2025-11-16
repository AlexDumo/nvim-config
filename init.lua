-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("mini.icons").setup({
  file = {
    patterns = {
      -- Match files ending with .test.tsx
      ["%.test%.ts$"] = {
        glyph = "", -- the standard TSX icon
        hl = "MiniIconsTestTsx",
      },
    },
  },
})

-- Create the orange highlight group
vim.api.nvim_set_hl(0, "MiniIconsTestTsx", { fg = "#FFA500" })
