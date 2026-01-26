-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        wrap = true, -- 折り返しを有効化
        linebreak = true, -- 単語の途中で折り返さない
        breakindent = true, -- 折り返し行もインデントを維持
        cursorline = true, -- カーソルラインを有効化
      },
    },
    autocmds = {
      -- アクティブウィンドウのみカーソルラインを表示
      active_window_cursorline = {
        {
          event = { "WinEnter", "BufEnter" },
          callback = function() vim.opt_local.cursorline = true end,
        },
        {
          event = { "WinLeave", "BufLeave" },
          callback = function() vim.opt_local.cursorline = false end,
        },
      },
    },
  },
}
