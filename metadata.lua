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

    -- Optional: SPDX license id or name
    license = "MIT",

    -- Optional: Project or plugin home page
    homepage = "https://github.com/<GITHUB_USER>/mise-<TOOL>",

    -- Optional: Legacy version files this plugin can parse
    -- legacyFilenames = {
    --     ".<TOOL>-version",
    --     ".<TOOL>rc"
    -- },

    -- Optional: configured mise tools to add to install-hook PATH
    -- depends = { "node" },
}
