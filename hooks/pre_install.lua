function PLUGIN:PreInstall(ctx)
    local version = ctx.version

    -- Replace with the URL to your tool's release artifact
    local url = "https://example.com/your-tool/releases/download/" .. version .. "/your-tool"

    return {
        version = version,
        url = url,
        note = "Downloading your-tool " .. version,
    }
end
