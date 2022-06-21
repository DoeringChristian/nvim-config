local ok, leap = pcall(require, "leap")
if not ok then
    return
end

leap.setup{
    case_insensitive = true,
}
require('leap').set_default_keymaps()
function leap_all_windows()
  require'leap'.leap {
    ['target-windows'] = vim.tbl_filter(
      function (win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )
  }
end
