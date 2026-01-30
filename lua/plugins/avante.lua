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
        '<leader>va',
        '<CMD>AvanteAsk<CR>',
        mode = { 'n', 'v' },
        desc = 'Ask Avante',
      },
      {
        '<leader>ve',
        '<CMD>AvanteEdit<CR>',
        mode = { 'n', 'v' },
        desc = 'Ask Avante',
      },
    },
    opts = {
      -- provider = 'copilot',
      provider = 'claude',
      mode = 'legacy',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          auth_type = 'max', -- Set to "max" to sign in with Claude Pro/Max subscription
          model = 'claude-opus-4-5-20251101', -- Claude Opus 4.5 (latest)
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 4096,
          },
        },
      },
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
        enable_claude_text_editor_tool_mode = false,
      },
      hints = { enabled = false },
    },
  },
}
