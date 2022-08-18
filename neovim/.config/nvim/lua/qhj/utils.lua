local M = {}

function M.map(mode, lhs, rhs, options)
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
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M

