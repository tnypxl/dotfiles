local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato" -- Change this to your preferred color scheme
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.enable_tab_bar = true
-- config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.scrollback_lines = 25000
config.window_frame = {
	-- border_bottom_height = "0.5cell",
	border_top_height = "0.5cell",
}

config.colors = {
	tab_bar = {
		background = "#23273C",
	},
}
config.window_padding = {
	top = "0.5cell",
	left = "1cell",
	right = "1cell",
	bottom = "0.5cell",
}

-- Define custom keybindings
config.keys = {
	-- Pane management
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "LeftArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 8 }) },
	{ key = "DownArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
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

	-- Option + Arrow Keys
	{ key = "LeftArrow", mods = "OPT", action = act.SendKey({ key = "b", mods = "ALT" }) },
	{ key = "RightArrow", mods = "OPT", action = act.SendKey({ key = "f", mods = "ALT" }) },
	{ key = "UpArrow", mods = "OPT", action = act.SendKey({ key = "b", mods = "CTRL" }) },
	{ key = "DownArrow", mods = "OPT", action = act.SendKey({ key = "f", mods = "CTRL" }) },

	-- Command + Arrow Keys
	{ key = "LeftArrow", mods = "CMD", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "RightArrow", mods = "CMD", action = act.SendKey({ key = "e", mods = "CTRL" }) },
	{ key = "UpArrow", mods = "CMD", action = act.SendKey({ key = "p", mods = "CTRL" }) },
	{ key = "DownArrow", mods = "CMD", action = act.SendKey({ key = "n", mods = "CTRL" }) },

	-- Option + Delete
	{ key = "Backspace", mods = "OPT", action = act.SendKey({ key = "w", mods = "CTRL" }) },

	-- Command + Delete
	{ key = "Backspace", mods = "CMD", action = act.SendKey({ key = "u", mods = "CTRL" }) },
}

-- tabs
config.tab_max_width = 32
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
	local background = "#363a4f"
	local foreground = "#8087a2"
	local edge_background = "#23273C"

	if tab.is_active or hover then
		background = "#8bd5ca"
		foreground = "#363a4f"
	end
	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	local max = config.tab_max_width - 9
	if #title > max then
		title = wezterm.truncate_right(title, max) .. "…"
	end

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = " " },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
		{ Text = " " .. (tab.tab_index + 1) .. ": " .. title .. " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = "" },
	}
end)

return config
