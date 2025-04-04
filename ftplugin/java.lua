local jdtls_setup = require("jdtls.setup")
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)
if not root_dir then
    return
end

local home = os.getenv("HOME")
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local config_dir = jdtls_path .. "/config_mac" -- if you use linux /config_linux
local launcher_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

-- LSP capabilities with nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

function get_java()
    local handle = io.popen("/usr/libexec/java_home -v 21")
    local java_home = handle:read("*a"):gsub("%s+", "")
    handle:close()
    return java_home .. "/bin/java"
end

local config = {
    cmd = {
        get_java(),
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", launcher_path,
        "-configuration", config_dir,
        "-data", workspace_dir,
    },
    root_dir = root_dir,
    capabilities = capabilities,
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = "/opt/homebrew/Cellar/openjdk@21/21.0.6/libexec/openjdk.jdk/Contents/Home",
                    },
                },
            },
            import = {
                gradle = {
                    enabled = true, -- Gradleサポートを有効化
                },
                maven = {
                    enabled = true, -- Mavenサポートを有効化
                }
            },
            signatureHelp = { enabled = true }, -- シグネチャヘルプを有効化
        },
    },
    init_options = {
        bundles = {},
        extendedClientCapabilities = jdtls_setup.extendedClientCapabilities
    }
}

-- サーバーをアタッチする前に設定を確認するためのログ (デバッグ用)
-- print(vim.inspect(config))

jdtls_setup.start_or_attach(config)
