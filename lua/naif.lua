local M = {}
M.options = {}

local function get_highlight(group)
	local highlight = vim.api.nvim_get_hl(0, { name = group })
	return { bg = highlight.bg or "", fg = highlight.fg or "" }
end

local function set_highlight(group, color)
	vim.api.nvim_set_hl(0, group, color)
end

local function get_palette(overrides)
	overrides = overrides or {}
	local palette = {
		strong = { fg = get_highlight("Normal").fg, bold = true },
		normal = { fg = get_highlight("Normal").fg, bg = get_highlight("Normal").bg },
		critical = { fg = get_highlight("Normal").bg, bg = get_highlight("ErrorMsg").fg },
		popout = { fg = get_highlight("Number").fg },
		salient = { fg = get_highlight("Type").fg },
		faded = { fg = get_highlight("Comment").fg },
		subtle = { fg = get_highlight("Comment").fg, bg = get_highlight("StatusLine").bg },
	}
	return vim.tbl_deep_extend("force", palette, overrides)
end

function M.disable_semantic_highlights()
	for _, group in ipairs(vim.fn.getcompletion("@", "highlight")) do
		vim.api.nvim_set_hl(0, group, {})
	end
end

function M.disable_treesitter_highlights()
	vim.cmd("TSDisable highlight")
end

function M.setup(options)
	options = options or {}
	options.palette = options.palette or {}

	M.options = vim.tbl_deep_extend("force", { disable_extra_highlights = true, palette = get_palette() }, options)

	M.apply(get_palette(options.palette))

	-- Set highlights when colorscheme changes
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			M.apply(get_palette(options.palette))
		end,
	})

	if M.options.disable_extra_highlights then
		vim.api.nvim_create_autocmd({ "ColorScheme", "LspAttach" }, {
			callback = M.disable_semantic_highlights,
		})

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = M.disable_treesitter_highlights,
		})
	end
end

function M.apply(palette)
	M.options.palette = palette

	-- Strong
	set_highlight("Function", palette.strong)

	-- Normal
	set_highlight("Conditional", palette.normal)
	set_highlight("Constant", palette.normal)
	set_highlight("Exception", palette.normal)
	set_highlight("Identifier", palette.normal)
	set_highlight("Include", palette.normal)
	set_highlight("Keyword", palette.normal)
	set_highlight("Label", palette.normal)
	set_highlight("Normal", palette.normal)
	set_highlight("Operator", palette.normal)
	set_highlight("PreProc", palette.normal)
	set_highlight("Repeat", palette.normal)
	set_highlight("Special", palette.normal)
	set_highlight("Statement", palette.normal)
	set_highlight("Structure", palette.normal)

	-- Critical
	set_highlight("ErrorMsg", palette.critical)

	-- Popout

	-- Salient
	set_highlight("Boolean", palette.salient)
	set_highlight("Constant", palette.salient)
	set_highlight("Number", palette.salient)
	set_highlight("String", palette.salient)

	-- Faded
	set_highlight("Comment", palette.faded)

	-- Subtle
	set_highlight("StatusLine", palette.subtle)
end

return M
