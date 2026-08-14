---@class Env
---@field lsps { [string]: string }
---@field TYPESCRIPT string

---@type Env
local env = ...
local tsdk = env.TYPESCRIPT .. "/lib/node_modules/typescript/lib"

local tsPluginLocation = vim.fs.joinpath(vim.fn.getcwd(), "node_modules/@astrojs/ts-plugin")
if not vim.uv.fs_stat(tsPluginLocation) then
  error("[neovim/lsps.lua] astrojs plugin for typescript-language-server required, run `npm i -D`")
end
vim.lsp.config("ts_ls", {
  filetypes = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",

    "astro",
  },
  init_options = {
    plugins = {
      {
        name = "@astrojs/ts-plugin",
        location = tsPluginLocation,
        languages = { "astro" },
      },
    },
  },
})

vim.lsp.config("astro", {
  cmd = { env.lsps.astro .. "/bin/astro-ls", "--stdio" },
  cmd_env = { NODE_PATH = env.TYPESCRIPT .. "/lib/node_modules" },
  init_options = {
    typescript = { tsdk = tsdk },
  },
})

for name, _ in pairs(env.lsps) do
  vim.lsp.enable(name)
end

