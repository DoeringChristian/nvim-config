return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    enabled = true,
    version = false, -- Never set this value to "*"! Never!
    build = 'make',
    dependencies = {
      'github/copilot.vim',
    },

    keys = {
      {
        '<leader>aa',
        '<CMD>AvanteAsk<CR>',
        mode = { 'n', 'v' },
        desc = 'Ask Avante',
      },
      {
        '<leader>ae',
        '<CMD>AvanteEdit<CR>',
        mode = { 'n', 'v' },
        desc = 'Ask Avante',
      },
    },
    opts = {
      provider = 'copilot',
      behaviour = {
        auto_focus_sidebar = false,
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = false,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = false,
        enable_token_counting = true,
        enable_cursor_planning_mode = false,
        use_cwd_as_project_root = true,
        enable_claude_text_editor_tool_mode = true,
      },
      hints = { enabled = false },
    },
  },
}
