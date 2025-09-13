function PLUGIN:Available(ctx)
    local http = require("http")
    local json = require("json")

    -- Replace with your tool's GitHub repository API for tags/releases
    local repo_url = "https://api.github.com/repos/<USER>/<TOOL>/tags"

    local resp, err = http.get({
        url = repo_url,
    })

    if err ~= nil then
        error("Failed to fetch versions: " .. err)
    end
    if resp.status_code ~= 200 then
        error("GitHub API returned status " .. resp.status_code .. ": " .. resp.body)
    end

    local tags = json.decode(resp.body)
    local result = {}
    for _, tag_info in ipairs(tags) do
        local version = tag_info.name
        table.insert(result, { version = version, note = nil })
    end
    return result
end
