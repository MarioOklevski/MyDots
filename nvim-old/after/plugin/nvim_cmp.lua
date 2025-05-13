local cmp = require'cmp'

cmp.setup({
	completion = {
		autocomplete = { cmp.TriggerEvent.TextChanged },  -- Trigger completion when text is typed
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)  -- Using LuaSnip for snippets
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion
		['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirm selection
		['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),  -- Next completion item
		['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),  -- Previous completion item
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },  -- LSP source
		{ name = 'luasnip' },   -- Snippet source
	}, {
		{ name = 'buffer' },     -- Buffer completion
	})
})
