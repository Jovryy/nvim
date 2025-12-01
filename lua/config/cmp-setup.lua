--TODO: MOVE TO ALTERNATIVE FILES LIKE require(plugins.cmpsetup)
-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      --completion = cmp.config.window.bordered(),
      --documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, 
	  }, {
      { name = 'buffer' },
    })
  })



require('mason').setup()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('mason-lspconfig').setup({
		ensure_installed = { 
		'lua_ls',
		'clangd', 
		'pyright', 
		'cssls', 
		'html', 
		'jsonls',
		'bashls',
		'marksman',
		'yamlls',
		'tailwindcss',
		'rust_analyzer',
		'vtsls',
		'vue_ls'
		},
		handlers = {
    -- This default handler will apply to all servers
    function(server_name)
      vim.lsp.config(server_name, {
        capabilities = capabilities,
      })
    end,
    }
})

local vue_language_server_path = vim.fn.stdpath("data")
.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
name = "@vue/typescript-plugin",
location = vue_language_server_path,
languages = { "vue" },
configNamespace = "typescript",
}
vim.lsp.config("vtsls", {
settings = {
vtsls = {
tsserver = {
globalPlugins = {
vue_plugin,
},
},
},
},
filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.enable("vue_ls")
vim.lsp.enable("vtsls")

