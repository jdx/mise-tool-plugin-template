-- metadata.lua
-- Plugin metadata and configuration
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#metadata-lua

PLUGIN = { -- luacheck: ignore
    -- Required: Plugin metadata name
    name = "<TOOL>",

    -- Required: Plugin metadata version
    version = "1.0.0",

    -- Optional: Plugin description
    description = "A mise tool plugin for <TOOL>",

    -- Optional: Plugin author
    author = "<GITHUB_USER>",

    -- Optional: License name
    license = "MIT",

    -- Optional: Plugin homepage
    homepage = "https://github.com/<GITHUB_USER>/mise-<TOOL>",

    -- Optional: Legacy version files this plugin can parse
    -- legacyFilenames = {
    --     ".<TOOL>-version",
    --     ".<TOOL>rc"
    -- },

    -- Optional: configured mise tools to add to install-hook PATH
    -- depends = { "node" },
}
