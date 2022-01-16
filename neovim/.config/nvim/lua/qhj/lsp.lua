local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true
caps = require('cmp_nvim_lsp').update_capabilities(caps)

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
})

-- go-to definition in a split window
local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command("copen")
        api.nvim_command("wincmd p")
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition('vsplit')

local on_attach = function(client, bufnr)
  local function buf_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  buf_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
  buf_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
  buf_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
  buf_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
  buf_keymap('n', '<C-m>', ':lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_keymap('n', '<Leader>D', ':lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_keymap('n', '<Leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
  buf_keymap('n', '<Leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
  buf_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
  buf_keymap('n', '<Leader>e', ':lua vim.diagnostic.open_float()<CR>', opts)
  buf_keymap('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_keymap('n', ']d', ':lua vim.diagnostic.goto_next()<CR>', opts)
  buf_keymap('n', '<Leader>q', ':lua vim.diagnostic.setloclist()<CR>', opts)
  buf_keymap('n', '<Leader>f', ':lua vim.lsp.buf.formatting()<CR>', opts)

end

local lspconfig = require('lspconfig')

-- Lua
-- `sudo pacman -Syu lua-language-server`
lspconfig.sumneko_lua.setup {
  capabilities = caps,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
      },
    },
  },
}

-- TypeScript
-- `pnpm add -g typescript-language-server`
lspconfig.tsserver.setup {
  capabilities = caps,
  on_attach = on_attach,
}

-- HTML, CSS, JSON
-- `pnpm add -g vscode-langservers-extracted`
lspconfig.html.setup {
  capabilities = caps,
  on_attach = on_attach,
}
lspconfig.cssls.setup {
  capabilities = caps,
  on_attach = on_attach,
}
lspconfig.jsonls.setup {
  capabilities = caps,
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas {
        select = {
          'package.json',
        },
      },
    },
  },
}
