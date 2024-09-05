-----------------------------------
---------- Custom Config ----------
-----------------------------------

------------------------------
---------- Settings ----------
------------------------------
--
vim.opt.relativenumber = false
vim.opt.clipboard = ""
vim.opt.confirm = false
vim.opt.scrolloff = 0

------------------------------
---------- Commands ----------
------------------------------

-- :BD
-- fecha um buffer mantendo a janela aberta
vim.api.nvim_create_user_command(
  "BD", -- Nome do comando
  function()
    -- Executa os comandos em sequência
    vim.cmd("bp") -- Muda para o buffer anterior
    vim.cmd("sp") -- Abre uma nova janela horizontal
    vim.cmd("bn") -- Muda para o próximo buffer
    vim.cmd("bd") -- Deleta o buffer
  end,
  { nargs = 0 } -- O comando não precisa de argumentos
)

vim.api.nvim_create_user_command("ListPlugins", function()
  local plugins = function()
    return vim.tbl_values(require("lazy.core.config").plugins)
  end

  -- Cria um novo buffer
  vim.cmd("enew")
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false

  -- Adiciona os dados ao buffer
  local lines = {}
  for _, plugin in ipairs(plugins()) do
    local plugin_name = plugin.name or "N/A"
    local plugin_url = plugin.url or "N/A"
    table.insert(lines, string.format("Plugin: %s - URL: %s", plugin_name, plugin_url))
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end, {})

vim.api.nvim_create_user_command("LazyConfigInit", function()
  vim.cmd("edit ~/.config/nvim/init.lua")
end, {})

vim.api.nvim_create_user_command("LazyConfigOptions", function()
  vim.cmd("edit ~/.config/nvim/lua/config/options.lua")
end, {})

vim.api.nvim_create_user_command("LazyConfigReload", function()
  vim.cmd("source ~/.config/nvim/init.lua")
  vim.cmd("source ~/.config/nvim/lua/config/options.lua")
end, {})

-----------------------------
---------- Plugins ----------
-----------------------------

return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
