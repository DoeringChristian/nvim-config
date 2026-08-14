-- OSC 52 clipboard provider with bounded reads.
--
-- Why not just `vim.g.clipboard = { name = 'OSC 52', ... }`:
--   yanky's utils.is_osc52_active() matches that exact name string (upstream PR #233,
--   "fallback to unnamed register if osc52 is used") and then routes *put* to the
--   unnamed register '"' while its clipboard watcher keeps polling '+'. '"' never
--   consults the provider, so text copied in another app lands in the yank ring but
--   `p` can't reach it -- you need p<C-p>. Any other name keeps put and sync on '+'.
--
-- Why bounded reads: Neovim's builtin osc52 paste blocks 1s, prints "Waiting for OSC 52
-- response from the terminal", then blocks up to 9s more. And with a function-based
-- provider Neovim never caches (provider/clipboard.vim leaves owner=0), so *every*
-- register read pays that. We probe once, then either use real reads or serve a local
-- cache instantly.
--
-- Reads require the terminal to answer OSC 52 queries. kitty defaults to
-- `clipboard_control ... read-clipboard-ask`; set `read-clipboard` for silent reads.
-- Without that, copies from other apps cannot reach nvim by any means.

local M = {}

local cache = { ['+'] = { { '' }, 'v' }, ['*'] = { { '' }, 'v' } }
local readable = nil -- nil = not yet probed, true/false = known

local function seq(clip, payload)
  return string.format('\027]52;%s;%s\027\\', clip, payload)
end

-- Returns the clipboard string, or nil if the terminal did not answer in time.
local function query(clip, timeout)
  local contents, id
  local ok = pcall(function()
    id = vim.tty.request(seq(clip, '?'), { timeout = 0 }, function(resp)
      local encoded = resp:match '\027%]52;%w?;([A-Za-z0-9+/=]*)'
      if encoded then
        contents = vim.base64.decode(encoded)
        return true
      end
    end)
  end)
  if ok then
    vim.wait(timeout, function()
      return contents ~= nil
    end)
    if id then
      pcall(vim.api.nvim_del_autocmd, id)
    end
  end
  return contents
end

local function copy(reg)
  local clip = reg == '+' and 'c' or 'p'
  return function(lines, regtype)
    cache[reg] = { lines, regtype or 'v' }
    pcall(vim.api.nvim_ui_send, seq(clip, vim.base64.encode(table.concat(lines, '\n'))))
  end
end

local function paste(reg)
  local clip = reg == '+' and 'c' or 'p'
  return function()
    if readable == false then
      return cache[reg]
    end

    local timeout = readable == nil and (M.probe_ms or 400) or (M.read_ms or 150)
    local contents = query(clip, timeout)

    if readable == nil then
      readable = contents ~= nil
      if not readable then
        vim.notify(
          'OSC 52: terminal does not answer clipboard reads. Pastes will use nvim-local '
            .. 'history; copies from other apps will not be visible. '
            .. 'Set kitty `clipboard_control ... read-clipboard` to enable.',
          vim.log.levels.WARN
        )
      end
    end

    if contents == nil then
      return cache[reg]
    end
    cache[reg] = { vim.split(contents, '\n'), 'v' }
    return cache[reg]
  end
end

--- Install the provider. Only call this when a native clipboard tool is unavailable
--- (i.e. over SSH); locally, pbcopy/pbpaste is faster and always readable.
function M.setup(opts)
  opts = opts or {}
  M.probe_ms = opts.probe_ms
  M.read_ms = opts.read_ms

  vim.g.clipboard = {
    name = 'osc52-bounded', -- deliberately not 'OSC 52'; see header
    copy = { ['+'] = copy '+', ['*'] = copy '*' },
    paste = { ['+'] = paste '+', ['*'] = paste '*' },
  }

  -- Re-probe after changing terminal settings without restarting nvim.
  vim.api.nvim_create_user_command('Osc52Reprobe', function()
    readable = nil
    vim.notify('OSC 52: will re-probe clipboard read support on next paste')
  end, { desc = 'Re-probe OSC 52 clipboard read support' })
end

return M
