local function map(mode, lhs, rhs, options)
  local opts = { noremap = true, silent = true, expr = false }
  if type(options) == 'table' then
    if type(options.noremap) == 'boolean' then
      opts.noremap = options.noremap
    end
    if type(options.silent) == 'boolean' then
      opts.silent = options.silent
    end
    if type(options.expr) == 'boolean' then
      opts.expr = options.expr
    end
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function _G.beginning_of_line()
  local col, match, getline = vim.fn.col, vim.fn.match, vim.fn.getline
  return col('.') == match(getline('.'), [[\S]]) + 1 and '0' or '^'
end

-- leader key
vim.g.mapleader = ' '

-- window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- window resize
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')

-- can be pasted again
map('x', 'p', '"_dP')
map('n', 'H', 'v:lua.beginning_of_line()', { expr = true })
map('x', 'H', 'v:lua.beginning_of_line()', { expr = true })
map('n', 'L', '$')
map('x', 'L', '$')

-- move line
map('n', 'J', ':m .+1<CR>==')
map('n', 'K', ':m .-2<CR>==')
map('x', 'J', ":m '>+1<CR>gv=gv")
map('x', 'K', ":m '<-2<CR>gv=gv")


-- local function t(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
--
-- function _G.cmp_down()
--     return vim.fn.pumvisible() ~= 0 and t'<Down>' or t'<C-n>'
-- end
--
-- function _G.cmp_up()
--     return vim.fn.pumvisible() ~= 0 and t'<Up>' or t'<C-p>'
-- end
-- map('i', '<C-p>', 'v:lua.cmp_up()', { expr = true })
-- map('i', '<C-n>', 'v:lua.cmp_down()', { expr = true })


-- map('n', 'K', 'yyP')
-- map('n', 'J', 'yyp')

map('x', '>', '>gv')
map('x', '<', '<gv')
-- better indentation

map('n', 'qq', ':q<CR>')
map('n', '<Leader>pe', ':NvimTreeToggle<CR>')
