return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          {
            'filename',
            path = 1,
            shorting_target = 40,
          }
        },
        lualine_x = {
          {
            function()
              local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
              if #buf_clients == 0 then
                return ''
              end
              
              local buf_client_names = {}
              for _, client in pairs(buf_clients) do
                table.insert(buf_client_names, client.name)
              end
              
              return '[' .. table.concat(buf_client_names, ', ') .. ']'
            end,
          },
          'filetype',
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
    }
  end,
}
