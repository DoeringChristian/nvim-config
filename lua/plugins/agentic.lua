return {
  {
    'carlos-algms/agentic.nvim',

    event = 'VeryLazy',
    enabled = false,

    keys = {
      {
        '<leader>mt',
        function()
          require('agentic').toggle()
        end,
        mode = { 'n', 'v', 'i' },
        desc = 'Toggle Agentic Chat',
      },
      {
        '<leader>ma',
        function()
          require('agentic').add_selection_or_file_to_context()
        end,
        mode = { 'n', 'v' },
        desc = 'Add file or selection to Agentic to Context',
      },
      {
        '<leader>mn',
        function()
          require('agentic').new_session()
        end,
        mode = { 'n', 'v', 'i' },
        desc = 'New Agentic Session',
      },
    },

    opts = {
      -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp"
      provider = 'claude-acp', -- setting the name here is all you need to get started
    },
  },
}
