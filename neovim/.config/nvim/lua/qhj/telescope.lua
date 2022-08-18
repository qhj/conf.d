local telescope = require('telescope')
local builtin = require('telescope.builtin')

local utils = require('qhj.utils')
local map = utils.map

map('n', '<Leader>ff', function()
  builtin.find_files({
    hidden = true,
    prompt_title = '',
    preview_title = '',
  })
end)
map('n', '<Leader>fg', function()
  builtin.live_grep({
    prompt_title = '',
    preview_title = '',
  })
end)
map('n', '<Leader>fb', function ()
  builtin.buffers({
    prompt_title = '',
    preview_title = '',
  })
end)
map('n', '<Leader>fh', function ()
  builtin.help_tags({
    prompt_title = '',
    preview_title = '',
  })
end)
map('n', '<Leader>fe', ':Telescope file_browser<CR>')

-- Global config
telescope.setup({
  defaults = {
    initial_mode = 'normal',
    winblend = 20,
    prompt_prefix = '> ',
    results_title = '',
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
    },
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
      previewer = false,
      hijack_netrw = true,
      prompt_title = '',
      hidden = true,
      borderchars = {
        prompt  = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
        results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
      },
    }
  }
})

telescope.load_extension("file_browser")

