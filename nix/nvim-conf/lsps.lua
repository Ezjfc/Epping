-- Requires Neovim 11.0 or above.

vim.lsp.enable({
  "tl_ls",
  "astro",
  "tailwindcss",
  "nil",
})

local astroLs, typescript = ...
local tsPluginPath = "/lib/node_modules/astro-language-server/packages/language-tools/ts-plugin"

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
        location = astroLs .. tsPluginPath,
      },
    },
  },
})

vim.lsp.config("astro", {
  cmd_env = { NODE_PATH = typescript .. "/lib/node_modules" },
})
