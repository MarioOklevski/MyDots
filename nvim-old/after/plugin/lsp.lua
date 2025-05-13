-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- On attach function for custom key mappings
local on_attach = function(client, bufnr)
  -- Example of key mappings for LSP
  local bufopts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', bufopts) -- Go to definition
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', bufopts)      -- Hover info
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', bufopts) -- Find references
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', bufopts) -- Go to implementation
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', bufopts)       -- Rename symbol
  vim.api.nvim_set_keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
end

-- Setup LSP config for Pyright
local lspconfig = require('lspconfig')
lspconfig.pyright.setup({
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",  -- "off", "basic", "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Setup LSP config for Ruff
lspconfig.ruff.setup({
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",  -- "off", "basic", "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Setup LSP config for tsserver (TypeScript)
lspconfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    -- Define keymaps or other actions when the LSP attaches
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
  end,
  settings = {
    documentFormatting = false,  -- Disable formatting because of potential conflict with other tools like Prettier
  },
})

-- Setup LSP config for Biome
lspconfig.biome.setup({
  on_attach = function(client, bufnr)
    -- Key mappings and other configuration go here
    -- Example: LSP mappings
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Other LSP related keymaps
  end,
})

-- Define a function to run the biome import sorting
vim.api.nvim_create_user_command('SortImports', function()
  -- Run the biome sort imports command
  vim.fn.system('rome sort imports')  -- Or the specific path to the executable if necessary
  -- Force reload the file after running the command (to refresh sorted imports)
  vim.cmd('e!')  -- The ! forces reloading the file even with unsaved changes
end, { desc = 'Sort imports with biome' })

-- Optional: Keybinding to trigger the sort imports command (e.g., <leader>si)
vim.api.nvim_set_keymap('n', '<leader>si', ':SortImports<CR>', { noremap = true, silent = true })

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

