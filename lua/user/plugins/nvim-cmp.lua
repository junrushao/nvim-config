local cmp = require('cmp')
local lspkind = require('lspkind')


local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  luasnip = "[LuaSnip]",
  nvim_lua = "[Lua]",
  latex_symbols = "[LaTeX]",
  cmp_tabnine = "[TN]",
}

cmp.setup({
  formatting = {
    format = lspkind.cmp_format{
      maxwidth = 50,
      menu = source_mapping,
      before = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        local menu = source_mapping[entry.source.name]
        if entry.source.name == "cmp_tabnine" then
          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail .. " " .. menu
          end
          vim_item.kind = ""
        end
        vim_item.menu = menu
        return vim_item
      end,
    },
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Down>'] = {i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })},
    ['<Up>'] = {i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })},
    ['<M-Down>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<M-Up>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- ['<C-e>'] = cmp.mapping({
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    -- }),
    -- ['<C-n>'] = {i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })},
    -- ['<C-p>'] = {i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })},
    -- ['<C-y>'] = {i = cmp.mapping.confirm({ select = false })},
    -- ['<C-e>'] = {i = cmp.mapping.abort()},
  },
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'cmp_tabnine' },
      -- { name = 'nvim_lsp_signature_help' },
      -- { name = 'copilot' },
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, 
    {{ name = 'buffer' }}
  ),
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  confirmation = { 
    completeopt = 'menu,menuone,noselect,noinsert'
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = cmp.config.sources(
    {{ name = 'buffer' }}
  ),
  mapping = cmp.mapping.preset.cmdline({})
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources(
    {{ name = 'path' }},
    {{ name = 'cmdline' }}
  ),
  mapping = cmp.mapping.preset.cmdline({}),
})

local M = {}

function M.setup_lsp(server_name, capabilities)
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  return capabilities
end

return M
