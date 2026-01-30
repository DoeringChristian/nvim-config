return {
  {
    'andrewferrier/wrapping.nvim',
    -- TODO: wait for fix
    enabled = false,
    config = function()
      require('wrapping').setup()
    end,
  },
}
