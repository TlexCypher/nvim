local mason = require('mason')
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

local autocmd = vim.api.nvim_create_autocmd
autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

mason.setup()
mason_lspconfig.setup()
mason_lspconfig.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {}
    end,

    ["solargraph"] = function()
        lspconfig.solargraph.setup{}
    end,

    ["pyright"] = function()
        local function is_directory(path)
            local stat = vim.loop.fs_stat(path)
            return stat and stat.type == "directory"
        end
        local function get_python_path()
            local cwd = vim.fn.getcwd()
            local pyproject_toml = cwd .. "/pyproject.toml"
            local virtualenv = cwd .. "/venv"
            local uv_rye_env = cwd .. "/.venv"
            -- using poetry or uv or rye
            if vim.fn.filereadable(pyproject_toml) == 1 then
                local poetry_venv = vim.fn.trim(vim.fn.system("poetry env info --path"))
                -- using poetry
                if vim.v.shell_error == 0 and poetry_venv ~= "" then
                    vim.notify("[From Pyright] Using poetry settings", vim.log.levels.WARN)
                    return poetry_venv .. "/bin/python"
                    -- using rye or uv, but no other differences using .venv directory.
                elseif is_directory(uv_rye_env) then
                    vim.notify("[From Pyright] Using rye or uv settings", vim.log.levels.WARN)
                    return uv_rye_env .. '/bin/python3'
                end
            end
            -- using virtualenv
            if is_directory(virtualenv) then
                vim.notify("[From Pyright] Using venv settings", vim.log.levels.WARN)
                return virtualenv .. '/bin/python3'
            else
                vim.notify("Virtual environment not found. Using default Python.", vim.log.levels.WARN)
            end
            return vim.fn.exepath("python3")
        end

        lspconfig.pyright.setup {
            settings = {
                python = {
                    pythonPath = get_python_path(),
                },
            },
        }
    end,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    })
})
