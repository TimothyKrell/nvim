local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim", commit = "" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", commit = "" }) -- Useful lua functions used by lots of plugins
	use({ "dstein64/vim-startuptime", commit = "" })
	use({ "windwp/nvim-autopairs", commit = "" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim", commit = "" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "" })
	use({ "kyazdani42/nvim-web-devicons", commit = "" })
	use({ "kyazdani42/nvim-tree.lua", commit = "" })
	-- use { "akinsho/bufferline.nvim", commit = "",
	--   config = function() require("user.bufferline") end,
	-- }
	use({ "moll/vim-bbye", commit = "" })
	use({ "SmiteshP/nvim-navic" })
	use({ "akinsho/toggleterm.nvim", commit = "" })
	use({ "ahmedkhalf/project.nvim", commit = "" })
	use({ "lewis6991/impatient.nvim", commit = "" })
	use({ "goolord/alpha-nvim", commit = "" })
	use("folke/which-key.nvim")
	use("christoomey/vim-tmux-navigator")
	use("tpope/vim-surround")
	use({
		"pwntester/octo.nvim",
		event = "BufRead",
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		-- event = "BufRead",
		setup = function()
			vim.g.indentLine_enabled = 1
			vim.g.indent_blankline_char = "???"
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "alpha" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_show_first_indent_level = false
			vim.g.indent_blankline_space_char_blankline = " "
			vim.g.indent_blankline_show_current_context = true
			vim.g.indent_blankline_show_current_context_start = true
		end,
	})
	use({ "norcalli/nvim-colorizer.lua" })
	use({ "folke/todo-comments.nvim" })
	use({
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		config = function()
			require("user.symbols-outline")
		end,
	})
	use({
		'stevearc/aerial.nvim',
		config = function() require('aerial').setup({
			manage_fold = true,
			link_folds_to_tree = true,
			link_tree_to_folds = true,
		}) end,
	})
	use({
		"folke/trouble.nvim",
	})
	-- use({ "stevearc/dressing.nvim" })
	use({ "rcarriga/nvim-notify" })
	use({
		"laytan/cloak.nvim",
		config = function()
			require("user.cloak")
		end,
	})
	use({
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({
				auto_cmd = true, -- Set to false to disable automatic execution
				filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
					"netrw",
					"tutor",
				},
				buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
					"help",
					"nofile",
					"terminal",
					"prompt",
				},
			})
		end,
	})
	-- use({
	--   "kevinhwang91/nvim-hlslens",
	--   config = function()
	--     require("user.hlslens")
	--   end,
	-- })
	use({
		"petertriho/nvim-scrollbar",
		config = function()
			local colors = require("catppuccin.palettes").get_palette()
			require("scrollbar").setup({
				handle = {
					highlight = "CursorLine",
				},
			})
			require("scrollbar.handlers.search").setup()
		end,
	})
	use({ "kevinhwang91/nvim-bqf", ft = "qf" })
	use({
		"nvim-lualine/lualine.nvim",
		commit = "",
		config = function()
			require("user.lualine")
		end,
		requires = {
			"folke/noice.nvim",
		},
	})
	use({
		"folke/noice.nvim",
		-- event = "VimEnter",
		config = function()
			require('user.noice')
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"hrsh7th/nvim-cmp",
		},
	})

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "" })
	use({ "lunarvim/darkplus.nvim", commit = "" })
	use({
		"catppuccin/nvim",
		as = "catpuccin",
		config = function()
			require("user.catppuccin")
		end,
	})

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "" }) -- a bunch of snippets to use

	-- LSP
	-- use { "williamboman/nvim-lsp-installer", commit = "" } -- simple to use language server installer
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "neovim/nvim-lspconfig", commit = "" }) -- enable LSP
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate" })
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
		run = "make",
	})

	use({
		"wincent/command-t",
		commit = "",
		run = "cd lua/wincent/commandt/lib/ && make",
		config = function()
			require("wincent.commandt").setup()
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "",
	})
	use({ "nvim-treesitter/playground" })
	use("p00f/nvim-ts-rainbow") -- rainbow parens
	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("user.treesitter-context")
		end,
	})
	use({
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
			require("user.nvim-ufo")
		end,
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", commit = "" })
	use({
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit",
		},
		ft = { "fugitive" },
	})
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim',
		config = function() require('user.neogit') end,
	})

	-- DAP
	use({ "mfussenegger/nvim-dap", commit = "" })
	use({ "rcarriga/nvim-dap-ui", commit = "" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
