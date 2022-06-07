require('searchbox').setup({
  popup = {
    relative = 'win',
    position = {
      row = '5%',
      col = '95%',
    },
    size = 30,
    border = {
      style = 'rounded',
      highlight = 'FloatBorder',
      text = {
        top = ' Search ',
        top_align = 'left',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal',
    },
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end,
    on_done = function(value, search_type)
      -- code
    end
  }
})

local M = {}

function M.search()
  require('searchbox').match_all({
    reverse = false,
    exact = false,
    visual_mode = false,
    title = false,
    prompt = ' ',
    range = {-1, -1},
  })
end 

function M.replace()
  require('searchbox').replace({
    exact = false,
    title = false,
    visual_mode = false,
    prompt = ' ',
    confirm = 'menu',
    range = {-1, -1}
  })
end

require("user.plugins.which-key")
.register("n", {
  ["<Leader>fs"] = {"<cmd>lua require('user.plugins.searchbox').search()<CR>", "Search"},
  ["<Leader>fr"] = {"<cmd>lua require('user.plugins.searchbox').replace()<CR>", "Replace"},
})

return M

