return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    build = 'make',
    opts = {
      auto_suggestions_provider = 'ollama-mini',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          api_key_name = 'ANTHROPIC_API_KEY',
          timeout = 600000, -- 10 minutes
          extra_request_body = {
            max_tokens = 32000,
          },
        },
        ollama = {
          endpoint = 'http://localhost:11434',
          model = 'qwq:32b',
        },
        ['ollama-mini'] = {
          __inherited_from = 'ollama',
          model = 'qwen2.5-coder:1.5b',
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
        enable_claude_text_editor_tool_mode = true,
      },
      hints = { enabled = false },
    },
  },
}
