-- metadata.lua
-- Plugin metadata and configuration
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#metadata-lua

PLUGIN = { -- luacheck: ignore
    -- Required: Tool name (lowercase, no spaces)
    name = "<TOOL>",

    -- Required: Plugin version (not the tool version)
    version = "1.0.0",

    -- Required: Brief description of the tool
    description = "A mise tool plugin for <TOOL>",

    -- Required: Plugin author/maintainer
    author = "<GITHUB_USER>",

    -- Optional: Repository URL for plugin updates
    updateUrl = "https://github.com/<GITHUB_USER>/mise-<TOOL>",

    -- Optional: Minimum mise runtime version required
    minRuntimeVersion = "0.2.0",

    -- Optional: Other mise-managed tools that must install first and be on PATH
    -- while running install hooks (Lua `cmd`, etc.). Use the same tool names as in
    -- mise.toml ("node", "go", …). mise uses these for install scheduling and hook-time `PATH`;
    -- they are not the same as
    -- `depends` on a `[tools]` entry in mise.toml (that only orders installs among
    -- tools you already list in config).
    -- See https://mise.jdx.dev/tool-plugin-development.html#_2-metadata-lua
    -- depends = { "node" },

    -- Optional: Legacy version files this plugin can parse
    -- legacyFilenames = {
    --     ".<TOOL>-version",
    --     ".<TOOL>rc"
    -- }
}
