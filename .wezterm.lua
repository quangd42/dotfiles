-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.cell_width = 1.05
config.command_palette_font_size = 16.0
config.font_size = 16.2
config.line_height = 1.00

config.enable_kitty_keyboard = true
config.window_background_opacity = 0.9

-- [[
-- COLORSCHEME
-- ]]
local COLORSCHEME = "tokyonight_moon"
-- local COLORSCHEME = "kanagawabones"
-- local COLORSCHEME = "Catppuccin Mocha"
config.color_scheme = COLORSCHEME

local current_cs = wezterm.color.get_builtin_schemes()[COLORSCHEME]
if COLORSCHEME == "tokyonight" then
	current_cs.tab_bar.inactive_tab = {
		bg_color = "#1a1b26",
		fg_color = "#7aa2f7",
	}
	config.color_schemes = {
		["tokyonight"] = current_cs,
	}
end

-- [[
-- RIGHT STATUS BAR
-- ]]

-- Show which key table is active in the status area
-- Default to the active workspace
wezterm.on("update-status", function(window, _)
	local name = window:active_key_table()
	if name then
		name = wezterm.format({
			{ Foreground = { Color = current_cs.tab_bar.active_tab.bg_color } },
			{ Background = { Color = current_cs.tab_bar.active_tab.fg_color } },
			{ Text = "Table: " },
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { Color = current_cs.tab_bar.active_tab.fg_color } },
			{ Background = { Color = current_cs.tab_bar.active_tab.bg_color } },
			{ Text = " " .. name .. " " },
		})
	end

	local workspace = wezterm.format({
		{ Foreground = { Color = current_cs.tab_bar.active_tab.bg_color } },
		{ Background = { Color = current_cs.scrollbar_thumb } },
		{ Text = " Workspace: " },
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = current_cs.tab_bar.active_tab.fg_color } },
		{ Background = { Color = current_cs.tab_bar.active_tab.bg_color } },
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
config.unzoom_on_switch_pane = true

config.window_padding = {
	left = "0",
	right = "0",
	top = "10",
	bottom = "0",
}

config.window_decorations = "RESIZE"

-- [[
-- SPLIT NAVIGATION
-- ]]
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end
local direction_move_keys = {
	k = "Left",
	h = "Down",
	a = "Up",
	e = "Right",
	LeftArrow = "Left",
	DownArrow = "Down",
	UpArrow = "Up",
	RightArrow = "Right",
}
local direction_resize_keys = {
	LeftArrow = "Left",
	DownArrow = "Down",
	UpArrow = "Up",
	RightArrow = "Right",
	Home = "Left",
	PageDown = "Down",
	PageUp = "Up",
	End = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_resize_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_move_keys[key] }, pane)
				end
			end
		end),
	}
end

--[[
-- CUSTOM KEYBINDINGS
--]]
config.leader = { key = ";", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "Enter",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "Enter",
		mods = "SUPER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- LEADER, followed by 'w' will init workspaces interactions
	{
		key = "w",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "workspaces",
			timeout_milliseconds = 2000,
		}),
	},

	-- Command pallete
	{
		key = ";",
		mods = "LEADER|CTRL",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "e",
		mods = "CTRL|SUPER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "k",
		mods = "CTRL|SUPER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "CTRL|SUPER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "h",
		mods = "CTRL|SUPER",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	-- move between split panes
	split_nav("move", "k"),
	split_nav("move", "h"),
	split_nav("move", "a"),
	split_nav("move", "e"),
	-- resize panes
	split_nav("resize", "LeftArrow"),
	split_nav("resize", "DownArrow"),
	split_nav("resize", "UpArrow"),
	split_nav("resize", "RightArrow"),
}

config.key_tables = {

	-- Defines the keys that are active in our workspace mode.
	workspaces = {
		{
			key = "c",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
		{
			key = "l",
			action = act.ShowLauncherArgs({
				flags = "WORKSPACES",
			}),
		},
	},
}

-- and finally, return the configuration to wezterm
return config
