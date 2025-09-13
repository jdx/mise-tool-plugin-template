-- hooks/available.lua
-- Returns a list of available versions for the tool
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#available-hook

function PLUGIN:Available(ctx)
    local http = require("http")
    local json = require("json")

    -- Example 1: GitHub Tags API (most common)
    -- Replace <USER>/<TOOL> with your tool's repository
    local repo_url = "https://api.github.com/repos/<USER>/<TOOL>/tags"

    -- Example 2: GitHub Releases API (for tools that use GitHub releases)
    -- local repo_url = "https://api.github.com/repos/<USER>/<TOOL>/releases"

    -- Add GitHub token if available (helps with rate limits)
    local headers = {}
    if os.getenv("GITHUB_TOKEN") then
        headers["Authorization"] = "token " .. os.getenv("GITHUB_TOKEN")
    elseif os.getenv("GITHUB_API_TOKEN") then
        headers["Authorization"] = "token " .. os.getenv("GITHUB_API_TOKEN")
    end

    local resp, err = http.get({
        url = repo_url,
        headers = headers,
    })

    if err ~= nil then
        error("Failed to fetch versions: " .. err)
    end
    if resp.status_code ~= 200 then
        error("GitHub API returned status " .. resp.status_code .. ": " .. resp.body)
    end

    local tags = json.decode(resp.body)
    local result = {}

    -- Process tags/releases
    for _, tag_info in ipairs(tags) do
        local version = tag_info.name

        -- Clean up version string (remove 'v' prefix if present)
        -- version = version:gsub("^v", "")

        -- For releases API, you might want:
        -- local version = tag_info.tag_name:gsub("^v", "")
        -- local is_prerelease = tag_info.prerelease or false
        -- local note = is_prerelease and "pre-release" or nil

        table.insert(result, {
            version = version,
            note = nil, -- Optional: "latest", "lts", "pre-release", etc.
            -- addition = {} -- Optional: additional tools/components
        })
    end

    return result
end
