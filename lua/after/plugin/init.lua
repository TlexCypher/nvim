local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-lua/plenary.nvim"
    },
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },

    },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        config = function()
            vim.cmd('colorscheme tokyonight')
        end
    },
    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     config = function()
    --         vim.cmd("colorscheme rose-pine")
    --     end
    -- },
    -- amongst your other plugins
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    {
        'nvim-treesitter/playground'
    },
    {
        'theprimeagen/harpoon'
    },
    {
        'mbbill/undotree'
    },
    -- {
    --     "tpope/vim-fugitive"
    -- },
    -- lsp
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    },
    --completions
    {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
    },
    --snippets
    {
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets"
    },
    --comment
    {
        'echasnovski/mini.comment'
    },
    --colorcode visualizer
    {
        'norcalli/nvim-colorizer.lua'
    },
    --auto pair of braces
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },
    --lua line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- lazygit
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
    --diffview
    {
        "sindrets/diffview.nvim",
        lazy = true,
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
        },
        keys = {
            { "<leader>do", "<cmd>DiffviewOpen<cr>",  desc = "DiffviewOpen" },
            { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
        },
    },
    -- trouble.nvim
    {
        "folke/trouble.nvim"
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        {
            "TlexCypher/clipper.nvim",
            lazy = false,    -- lazy should not be true.
            dependencies = { -- this is dependency for ui.
                "nvim-lua/plenary.nvim"
            },
            config = function()
                require("clipper").setup()
            end
        }
    },
})
