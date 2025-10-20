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
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
		'tsserver',
		'clangd', 
		'pyright', 
		'volar', 
		'cssls', 
		'html', 
		'jsonls',
		'bashls',
		'marksman',
		'yamlls',
		'tailwindcss',
		'rust_analyzer'
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

