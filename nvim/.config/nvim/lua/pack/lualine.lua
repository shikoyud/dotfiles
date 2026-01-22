vim.pack.add({"https://github.com/nvim-lualine/lualine.nvim"})

require('lualine').setup {
  options = {
    icons_enabled = true,
		-- theme = "auto",
		theme = {
			normal = {
				a = {bg = "#181818", fg = "#969696", gui = "bold"},
				b = {bg = "#2c2c3f", fg = "#e4e4e4"},
				c = {fg = "#8E3728"},
				x = {fg = "#96a6c8"},
				y = {bg = "#2c2c3f", fg = "#e65360"},
				z = {bg = "#2c2c3f", fg = "#1793d1"},
			},
			insert = {
				a = {bg = "#73d936", fg = "#181818", gui = "bold"},
				b = {bg = "#2c2c3f", fg = "#e4e4e4"},
				c = {fg = "#8E3728"},
				x = {fg = "#96a6c8"},
				y = {bg = "#2c2c3f", fg = "#e65360"},
				z = {bg = "#2c2c3f", fg = "#1793d1"},
			},
			visual = {
				a = {bg = "#ffdd33", fg = "#181818", gui = "bold"},
				b = {bg = "#2c2c3f", fg = "#e4e4e4"},
				c = {fg = "#8E3728"},
				x = {fg = "#96a6c8"},
				y = {bg = "#2c2c3f", fg = "#e65360"},
				z = {bg = "#2c2c3f", fg = "#1793d1"},
			},
			replace = {
				a = {bg = "#cb8b3e", fg = "#181818", gui = "bold"},
				b = {bg = "#2c2c3f", fg = "#e4e4e4"},
				c = {fg = "#8E3728"},
				x = {fg = "#96a6c8"},
				y = {bg = "#2c2c3f", fg = "#e65360"},
				z = {bg = "#2c2c3f", fg = "#1793d1"},
			},
			inactive = {},
		},

    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},

    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },

    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
     },
    }
  },
  sections = {
    lualine_a = {
			{
				'mode',
				icon = '',
				separator = { right = '' },
				padding = 1
			}
		},
		lualine_b = {
			{
				'filename',
				padding = 0,
				icon = {
					"",
					color = { bg = "#969696", fg = "#2c2c3f"}
				},
				fmt = function (name)
					if vim.fn.win_gettype() == "command" then
						return "[Command Line] "
					else
						return name.." "
					end
				end,
			},
			{
				'filetype',
				padding = 0,
				icon_only = true,
				separator = { right = ""},
			},
		},
    lualine_c = {
			{
				'branch',
				fmt = function (branch)
					if vim.fn.win_gettype() == "command" then
						return ""
					else
						return branch
					end
				end
			},
			{
				'diff',
				padding = 0,
				symbols = {added = ' ', modified = ' ', removed = ' '},
			}
		},
    lualine_x = {
			{ 'diagnostics' },
			{
				'lsp_status',
				icon = ' ',
				symbols = { separator = ' | ', done = '', },
			}
		},
    lualine_y = {
			{
				'searchcount',
				padding = 0,
				icon = {
					"󰍉 ",
					color = { bg = "#e65360", fg = "#2c2c3f"}
				},
				fmt = function (input)
					if #input > 0 then
						return input.." "
					end
				end,
				separator = { left = ""},
			},
		},
    lualine_z = {
			{
				'location',
				padding = 0,
				icon = {
					" ",
					color = {
						bg = "#1793d1", fg = "#2c2c3f"
					}
				},
				fmt = function (location)
					if vim.fn.win_gettype() == "command" then
						return ""
					else
						return location.." "
					end
				end,
				separator = { left = ""},
			}
		}
  },
  inactive_sections = {
		lualine_b = {
			{
				'filename',
				padding = 0,
				fmt = function (name)
					return name.." "
				end,
				separator = { left = ""}
			},
			{
				'filetype',
				padding = 0,
				icon_only = true,
				separator = { right = ""}
			},
		},
  },
}
