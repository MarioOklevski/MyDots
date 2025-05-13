-- Inside your config.lua (or init.lua)
require('nvim-surround').setup({
  -- Key mappings for surround actions
  keymaps = {
    insert = '<C-g>',  -- in insert mode, <C-g> to add surrounding
    normal = 'ys',     -- normal mode: "ys" to add surrounding
    visual = 'S',      -- visual mode: "S" to surround selected text
    delete = 'ds',     -- delete surrounding
    change = 'cs',     -- change surrounding
  },

  -- Enable surrounding for more complex pairs (like HTML tags)
  surrounds = {
    ['('] = { add = { '(', ')' }, find = '%b()', delete = 'ds(' },
    ['{'] = { add = { '{', '}' }, find = '%b{}', delete = 'ds{' },
    ['['] = { add = { '[', ']' }, find = '%b[]', delete = 'ds[' },
    ['"'] = { add = { '"', '"' }, find = '%b""', delete = 'ds"' },
    ["'"] = { add = { "'", "'" }, find = "%b''", delete = "ds'" },
    ['<'] = { add = { '<', '>' }, find = '<[^>]*>', delete = 'ds<' },
  },
  uu
})
