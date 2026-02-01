--!strict
local Types = require("@lib/types")

local plugin = PLUGIN :: Types.PluginType
local http = require("http") :: Types.HttpModule
local json = require("json") :: Types.JsonModule

--- Returns a list of available versions for the tool
--- Documentation: https://mise.jdx.dev/dev-tools/backends/vfox.html
function plugin:Available(_ctx: { args: { string }? }): { Types.AvailableResult }
    -- Example 1: GitHub Tags API (most common)
    -- Replace <GITHUB_USER>/<GITHUB_REPO> with your tool's repository
    local repo_url = "https://api.github.com/repos/<GITHUB_USER>/<GITHUB_REPO>/tags"

    -- Example 2: GitHub Releases API (for tools that use GitHub releases)
    -- local repo_url = "https://api.github.com/repos/<GITHUB_USER>/<GITHUB_REPO>/releases"

    -- mise automatically handles GitHub authentication - no manual token setup needed
    local resp = http.get({
        url = repo_url,
    })

    if resp.status_code ~= 200 then
        error(`GitHub API returned status {resp.status_code}: {resp.body}`)
    end

    local tags = json.decode(resp.body :: string)
    local result: { Types.AvailableResult } = {}

    -- Process tags/releases
    for _, tag_info in tags do
        local version: string = tag_info.name

        -- Clean up version string (remove 'v' prefix if present)
        -- version = version:gsub("^v", "")

        -- For releases API, you might want:
        -- local version = tag_info.tag_name:gsub("^v", "")
        -- local is_prerelease = tag_info.prerelease or false
        -- local note = if is_prerelease then "pre-release" else nil

        table.insert(result, {
            version = version,
            note = nil, -- Optional: "latest", "lts", "pre-release", etc.
            -- addition = {} -- Optional: additional tools/components
        })
    end

    return result
end
