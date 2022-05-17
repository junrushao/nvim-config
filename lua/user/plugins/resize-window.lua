local M = {}

local function cannot_move(direction, opposite_direction)
  local old_win_id = vim.fn.winnr()
  vim.cmd("wincmd " .. direction)
  local new_win_id = vim.fn.winnr()
  if new_win_id == old_win_id then
    return true
  end
  vim.cmd("wincmd " .. opposite_direction)
  return false
end

local function window_is_leftmost() return cannot_move("h", "l") end
local function window_is_rightmost() return cannot_move("l", "h") end
local function window_is_uppermost() return cannot_move("k", "j") end
local function window_is_lowermost() return cannot_move("j", "k") end

M.sign = {
  l = function()
    if not window_is_leftmost() then return ">" end
    if not window_is_rightmost() then return "<" end
    return nil
  end,
  r = function()
    if not window_is_rightmost() then return ">" end
    if not window_is_leftmost() then return "<" end
    return nil
  end,
  u = function()
    if not window_is_uppermost() then return "+" end
    if not window_is_lowermost() then return "-" end
    return nil
  end,
  d = function()
    if not window_is_lowermost() then return "+" end
    if not window_is_uppermost() then return "-" end
    return nil
  end,
}

local function resize(fn_cmd)
  if vim.fn.winnr("$") > 1 then
    cmd = fn_cmd()
    if cmd ~= nil then
      vim.cmd("wincmd " .. cmd)
    end
  end
end

M.cmd = {
  l = function() resize(M.sign.l) end,
  r = function() resize(M.sign.r) end,
  u = function() resize(M.sign.u) end,
  d = function() resize(M.sign.d) end,
}

require("user.plugins.which-key")
.register("n", {
  ["<M-Left>"]  = {'<cmd>lua require("user.plugins.resize-window").cmd.l()<cr>', "Window: resize left"},
  ["<M-Right>"] = {'<cmd>lua require("user.plugins.resize-window").cmd.r()<cr>', "Window: resize right"},
  ["<M-Up>"]    = {'<cmd>lua require("user.plugins.resize-window").cmd.u()<cr>', "Window: resize up"},
  ["<M-Down>"]  = {'<cmd>lua require("user.plugins.resize-window").cmd.d()<cr>', "Window: resize down"},
})

return M
