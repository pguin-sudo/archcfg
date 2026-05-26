return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#151310',
				base01 = '#151310',
				base02 = '#8f8b84',
				base03 = '#8f8b84',
				base04 = '#e8e2da',
				base05 = '#fffcf8',
				base06 = '#fffcf8',
				base07 = '#fffcf8',
				base08 = '#ffa69f',
				base09 = '#ffa69f',
				base0A = '#f3dab2',
				base0B = '#b3ffa5',
				base0C = '#fff1db',
				base0D = '#f3dab2',
				base0E = '#ffeac7',
				base0F = '#ffeac7',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#8f8b84',
				fg = '#fffcf8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#f3dab2',
				fg = '#151310',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8f8b84' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#fff1db', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffeac7',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#f3dab2',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#f3dab2',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#fff1db',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#b3ffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#e8e2da' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#e8e2da' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#8f8b84',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
