return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      local treesitter = require 'nvim-treesitter'
      treesitter.setup()

      local ensure_installed = {
        'bash',
        'bibtex',
        'c',
        'cmake',
        'cpp',
        'cuda',
        'diff',
        'dockerfile',
        'eex',
        'gdscript',
        'glsl',
        'java',
        'latex',
        'llvm',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'ninja',
        'nix',
        'norg',
        'ocaml',
        'ocamllex',
        'python',
        'regex',
        'rst',
        'rust',
        'vim',
        'wgsl',
        'yaml',
        'toml',
      }
      treesitter.install(ensure_installed)

      -- vim.api.nvim_create_autocmd('FileType', {
      --   pattern = { '<filetype>' },
      --   callback = function()
      --     vim.treesitter.start()
      --   end,
      -- })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '*' },
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)

          if not vim.treesitter.language.add(lang) then
            -- this stupid tracking is here only because
            -- they have added warnings on absent parsers
            local available = vim.g.ts_available or require('nvim-treesitter').get_available()
            if not vim.g.ts_available then
              vim.g.ts_available = available
            end
            if vim.tbl_contains(available, lang) then
              require('nvim-treesitter').install(lang)
            end
          end

          if vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
            -- this is an experimental feature
            -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'
          end
        end,
      })

      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

      -- TODO: figure out tree-sitter-textobjects

      -- treesitter.setup {
      --
      --   sync_install = false,
      --
      --   highlight = { enable = true },
      --   indent = { enable = true },
      --
      --   textobjects = {
      --     lsp_interop = {
      --       enable = false,
      --       border = 'none',
      --       floating_preview_opts = {},
      --     },
      --     select = {
      --       enable = false,
      --       lookahead = true,
      --       keymaps = {
      --         -- You can use the capture groups defined in textobjects.scm
      --         ['af'] = { query = '@function.outer', desc = 'Select [A]rround [F]unction' },
      --         ['if'] = { query = '@function.inner', desc = 'Select [I]nside [F]unction' },
      --         ['ac'] = { query = '@class.outer', desc = 'Select [A]rround [C]lass' },
      --         ['ic'] = { query = '@class.inner', desc = 'Select [I]nside [C]lass' },
      --         ['ag'] = { query = '@comment.outer', desc = 'Select [A]rround Comment' },
      --         ['ig'] = { query = '@comment.inner', desc = 'Select [I]nside Comment' },
      --         ['al'] = { query = '@loop.outer', desc = 'Select [A]rround [L]oop' },
      --         ['il'] = { query = '@loop.inner', desc = 'Select [I]nside [L]oop' },
      --         -- ["ab"] = { query = "@block.outer", desc = "Select [A]rround [B]lock" },
      --         -- ["ib"] = { query = "@bloc.inner", desc = "Select [I]nside [B]lock" },
      --       },
      --     },
      --   },
      -- }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    enabled = false,
    branch = 'main', -- Textobjects also has a main branch for compatibility
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  -- TODO: treesitter textobjects
}
