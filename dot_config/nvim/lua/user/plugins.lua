local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" }  -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" }  -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "akinsho/bufferline.nvim" }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" }
  use { "akinsho/toggleterm.nvim" }
  use { "ahmedkhalf/project.nvim" }
  use { "lewis6991/impatient.nvim" }
  use { "lukas-reineke/indent-blankline.nvim", main = "ibl" }
  use { "goolord/alpha-nvim" }

  -- Colorschemes
  use { "folke/tokyonight.nvim" }
  use { "lunarvim/darkplus.nvim" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" }         -- The completion plugin
  use { "hrsh7th/cmp-buffer" }       -- buffer completions
  use { "hrsh7th/cmp-path" }         -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }

  -- snippets
  use { "L3MON4D3/LuaSnip" }             --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  -- use { "williamboman/nvim-lsp-installer" } -- simple to use language server installer
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-frecency.nvim" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-packer.nvim" },
      { "nvim-telescope/telescope-symbols.nvim" },
      { "nvim-telescope/telescope-vimspector.nvim" },
      { "nvim-telescope/telescope-z.nvim" },
      { "nvim-telescope/telescope-github.nvim" },
    },
  }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }
  use 'nvim-treesitter/playground'
  -- Additional text objects via treesitter
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }



  -- Git
  use { "lewis6991/gitsigns.nvim" }

  -- DAP
  use {
    "mfussenegger/nvim-dap",
    init = function()
      print("init nvim dap")
      -- require("core.utils").load_mappings("dap")
    end,
  }

  use { "rcarriga/nvim-dap-ui" }
  use { "ravenxrz/DAPInstall.nvim" }

  use {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end,
  }

  -- undo tree
  use 'mbbill/undotree'

  -- filetypes
  -- use "nathom/filetype.nvim"

  -- surround
  use "kylechui/nvim-surround"

  -- Copilot
  use { "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        print("copilot enter")
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end, 100)
    end,
  }

  use { "zbirenbaum/copilot-cmp",
    after = {
      "copilot.lua",
      "nvim-cmp",
    },
    config = function()
      require("copilot_cmp").setup {
        method = "getCompletionsCycling",
      }
    end,
  }

  -- Which-key
  use { "folke/which-key.nvim" }

  -- Colour my parentheses
  use { "p00f/nvim-ts-rainbow" }

  -- Octo GH integration
  use { "pwntester/octo.nvim" }

  -- Tmux integration
  use { "christoomey/vim-tmux-navigator" }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
