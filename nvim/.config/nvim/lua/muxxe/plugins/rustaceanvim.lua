return function()
  local ok, mason_registry = pcall(require, "mason-registry")
  if not ok then return end

  local function get_codelldb_paths()
    local pkg = mason_registry.get_package("codelldb")
    if not pkg or not pkg:is_installed() then
      vim.notify("codelldb not installed. Run :Mason to install.", vim.log.levels.WARN)
      return nil, nil
    end

    local install_path = pkg.get_install_path and pkg:get_install_path()
    if not install_path then
      vim.notify("Failed to get codelldb install path.", vim.log.levels.ERROR)
      return nil, nil
    end

    local ext_path = install_path .. "/extension/"
    local adapter = ext_path .. "adapter/codelldb"
    local liblldb = ext_path .. "lldb/lib/liblldb.so"
    return adapter, liblldb
  end

  local adapter, liblldb = get_codelldb_paths()
  if not adapter then return end

  local cfg = require("rustaceanvim.config")

  vim.g.rustaceanvim = {
    dap = {
      adapter = cfg.get_codelldb_adapter(adapter, liblldb),
    },
    tools = {
      inlay_hints = { auto = true },
    },
  }
end

