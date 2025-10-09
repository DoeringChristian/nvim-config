return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'fang2hou/blink-copilot',
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-l>'] = { 'select_and_accept', 'fallback' },
        ['<Enter>'] = { 'select_and_accept', 'fallback' },
      },

      cmdline = {
        enabled = true,
        completion = {
          menu = { auto_show = true },
          list = {
            selection = {
              preselect = false,

              auto_insert = true,
            },
          },
        },
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          update_delay_ms = 50,
        },
        list = {
          selection = {
            preselect = false,

            auto_insert = true,
          },
        },
        ghost_text = {
          enabled = true,
        },
        accept = {
          -- This seems to work near-flawlessly. No need to hook up autopairs.
          auto_brackets = {
            enabled = true,
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          show_documentation = true,
        },
      },

      sources = {
        default = { 'lsp', 'copilot', 'path', 'snippets', 'buffer' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },

      snippets = { preset = 'luasnip' },
    },
    opts_extend = { 'sources.default' },
  },
}
