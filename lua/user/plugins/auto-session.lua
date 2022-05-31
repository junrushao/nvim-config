local path = require("user.path")
require('auto-session').setup{
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = nil,
  auto_session_use_git_branch = nil,
  auto_session_allowed_dirs = path.AUTO_SESSION,
  -- the configs below are lua only
  bypass_session_save_file_types = nil,
  post_restore_cmds = {
    -- 'lua vim.notify(vim.inspect(require("user.path")), "info", {title = "Environment"})',
  },
}

