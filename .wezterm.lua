-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- config.font = wezterm.font("JetBrainsMono Nerd Font")

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Tokyo Night"
config.color_scheme = "Catppuccin Mocha"

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, _)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

-- Config for smart-splits
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end
local direction_move_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
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

-- Keys
config.leader = { key = "\\", mods = "SUPER", timeout_milliseconds = 1000 }
config.font_size = 16.0
config.keys = {
	{
		key = "|",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- LEADER, followed by 'w' will init workspaces interactions
	{
		key = "w",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "workspaces",
			timeout_milliseconds = 1000,
		}),
	},

	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
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

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 30

-- Define the arrow keys and corresponding hjkl keys
-- local arrow_mapping = {
-- 	LeftArrow = "h",
-- 	DownArrow = "j",
-- 	UpArrow = "k",
-- 	RightArrow = "l",
-- 	Home = "LeftArrow",
-- 	PageDown = "DownArrow",
-- 	PageUp = "UpArrow",
-- 	End = "RightArrow",
-- }
--
-- for input, output in pairs(arrow_mapping) do
-- 	for _, mod in ipairs({ "NONE", "CTRL", "SHIFT", "OPT" }) do
-- 		table.insert(config.keys, {
-- 			key = input,
-- 			mods = mod,
-- 			action = act.SendKey({ key = output, mods = mod }),
-- 		})
-- 	end
-- end

-- and finally, return the configuration to wezterm
return config
