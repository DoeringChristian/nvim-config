return {
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    -- tag = "v6.1.2", -- https://github.com/mikesmithgh/kitty-scrollback.nvim/issues/282
    -- NOTE: use nvim >= v0.11.0-dev-1490+ge27f7125d6
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^5.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup {
        keymaps_enabled = false,
      }
    end,
  },
}
