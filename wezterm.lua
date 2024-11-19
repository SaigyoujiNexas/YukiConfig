local wezterm = require("wezterm")
local config = wezterm.config_builder()
local fonts = wezterm.font_with_fallback({
	"MonoLisa Variable",
	"Noto Sans SC",
	"Nerd Font Symbols",
	"Noto Color Emoji",
})
config.font = fonts
config.font_size = 16.0
config.color_scheme = "Catppuccin Macchiato"
config.animation_fps = 144
config.allow_win32_input_mode = false
config.max_fps = 144
config.audible_bell = "SystemBeep"
-- config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.freetype_load_target = "HorizontalLcd"
config.use_fancy_tab_bar = false
config.cursor_blink_rate = 650
config.enable_scroll_bar = true
config.window_frame = {
	font = fonts,
	font_size = 16.0,
}
config.default_cursor_style = "BlinkingBar"

-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

config.integrated_title_button_color = "Auto"

local nf = wezterm.nerdfonts
local GLYPH_SCIRCLE_LEFT = nf.ple_left_half_circle_thick --[[  ]]
local GLYPH_SCIRCLE_RIGHT = nf.ple_right_half_circle_thick --[[  ]]
local GLYPH_CIRCLE = nf.fa_circle --[[  ]]
local GLYPH_ADMIN = nf.md_shield_half_full --[[ 󰞀 ]]
local GLYPH_LINUX = nf.cod_terminal_linux --[[  ]]
local GLYPH_DEBUG = nf.fa_bug --[[  ]]
-- local GLYPH_SEARCH = nf.fa_search --[[  ]]
local GLYPH_SEARCH = "🔭"
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#0b0022"
	local background = "#313244"
	local foreground = "#bac2de"

	if tab.is_active then
		background = "#585b70"
		foreground = "#cdd6f4"
	elseif hover then
		background = "#313244"
		foreground = "#cdd6f4"
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {

		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		-- 'ResetAttributes',
		{ Text = GLYPH_SCIRCLE_LEFT },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Attribute = { Intensity = "Bold" } },
		-- 'ResetAttributes',
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		-- 'ResetAttributes',
		{ Text = GLYPH_SCIRCLE_RIGHT },
	}
end)
return config
