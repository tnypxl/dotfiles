local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.use_fancy_tab_bar = false
config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
-- config.window_padding = {
-- 	left = "0.5cell",
-- 	right = "0.5cell",
-- 	bottom = "0.5px",
-- }

-- Define custom keybindings
config.keys = {
	-- Pane management
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "LeftArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "x", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },

	-- Workspace management
	{ key = "n", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace({ name = "default" }) },
	{ key = "w", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace({ name = "work" }) },
	{ key = "s", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace({ name = "study" }) },
	{ key = "a", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace({ name = "admin" }) },
	{ key = "d", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace({ name = "dev" }) },
	{ key = "c", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace({ name = "chat" }) },
	{ key = "t", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace({ name = "term" }) },
	{ key = "r", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace({ name = "research" }) },
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local tab_index = tab.tab_index + 1
	local tab_title = tab.active_pane.title
	local workspace = tab.active_pane.workspace
	local is_active = tab.is_active

	local bg_color = is_active and "#FAE3B0" or "#494D64"
	local fg_color = is_active and "#363A4F" or "#D9E0EE"

	local left_corner = is_active and "" or ""
	local right_corner = is_active and "" or ""

	return {
		{ Background = { Color = bg_color } },
		{ Foreground = { Color = fg_color } },
		{ Text = left_corner },
		{ Text = " " .. tab_index .. " " .. tab_title .. " [" .. workspace .. "] " },
		{ Text = right_corner },
	}
end)

-- Set tab bar colors
config.colors = {
	tab_bar = {
		background = "#24273A",
		active_tab = {
			bg_color = "#FAE3B0",
			fg_color = "#363A4F",
		},
		inactive_tab = {
			bg_color = "#494D64",
			fg_color = "#D9E0EE",
		},
		inactive_tab_hover = {
			bg_color = "#5B6078",
			fg_color = "#D9E0EE",
		},
		new_tab = {
			bg_color = "#24273A",
			fg_color = "#D9E0EE",
		},
		new_tab_hover = {
			bg_color = "#494D64",
			fg_color = "#D9E0EE",
		},
	},
}

return config
