local wezterm = require("wezterm")

local M = {}

function M.config(config)
	-- [[
	-- FONTS
	-- ]]
	config.font = wezterm.font("JetBrainsMono Nerd Font")
	config.cell_width = 1.05
	config.command_palette_font_size = 16.0
	config.font_size = 16.2
	config.line_height = 1.00
	config.window_background_opacity = 0.85

	-- [[
	-- COLORSCHEME
	-- ]]
	local COLORSCHEME = "tokyonight"
	-- local COLORSCHEME = "kanagawabones"
	-- local COLORSCHEME = "Catppuccin Mocha"
	config.color_scheme = COLORSCHEME

	local cs = wezterm.color.get_builtin_schemes()[COLORSCHEME]
	if COLORSCHEME == "tokyonight" then
		cs.tab_bar.inactive_tab = {
			bg_color = cs.scrollbar_thumb,
			fg_color = "#a9b1d6",
		}
		config.color_schemes = {
			["tokyonight"] = cs,
		}
	end
	config.command_palette_fg_color = "#c8d3f5"
	config.command_palette_bg_color = "#1e2030"

	-- [[
	-- RIGHT STATUS BAR
	-- ]]

	-- Show which key table is active in the status area
	-- Default to the active workspace
	wezterm.on("update-status", function(window, _)
		local name = window:active_key_table()
		if name then
			name = wezterm.format({
				{ Foreground = { Color = cs.tab_bar.active_tab.bg_color } },
				{ Background = { Color = cs.tab_bar.active_tab.fg_color } },
				{ Text = "Table: " },
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { Color = cs.tab_bar.active_tab.fg_color } },
				{ Background = { Color = cs.tab_bar.active_tab.bg_color } },
				{ Text = " " .. name .. " " },
			})
		end

		local workspace = wezterm.format({
			{ Foreground = { Color = cs.tab_bar.active_tab.bg_color } },
			{ Background = { Color = cs.scrollbar_thumb } },
			{ Text = " Workspace: " },
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { Color = cs.tab_bar.active_tab.fg_color } },
			{ Background = { Color = cs.tab_bar.active_tab.bg_color } },
			{ Text = " " .. window:active_workspace() .. " " },
		})
		window:set_right_status(name or workspace)
	end)

	-- [[
	-- TAB BAR and WINDOW PADDING
	-- ]]
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.tab_max_width = 32

	config.window_decorations = "RESIZE"
	config.window_padding = {
		left = "0",
		right = "0",
		top = "10",
		bottom = "0",
	}
end

return M
