require('ufo').setup()

local M = {}

function M.setup_lsp(server_name, capabilities)
  capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
  }
  return capabilities
end

return M
