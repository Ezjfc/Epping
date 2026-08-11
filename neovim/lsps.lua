---@class Env
---@field lsps { [string]: string }
---@field TYPESCRIPT string

---@type Env
local env = ...

for name, _ in pairs(env.lsps) do
  vim.lsp.enable(name)
end

local tsdk = env.TYPESCRIPT .. "/lib/node_modules/typescript/lib"

-- `@astrojs/ts-plugin` is not shipped by the astro-language-server derivation in a
-- resolvable form (no `node_modules/@astrojs/ts-plugin` anywhere in it, and its own
-- deps are missing), so it has to come from the project's own node_modules.
local tsPluginLocation = vim.fs.joinpath(vim.fn.getcwd(), "node_modules/@astrojs/ts-plugin")
if not vim.uv.fs_stat(tsPluginLocation) then
  error("[neovim/lsps.lua] astrojs plugin for typescript-language-server required, run `npm i -D`")
end
vim.lsp.config("tl_ls", {
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
  init_options = {
    typescript = { tsdk = tsdk },
  },
})

