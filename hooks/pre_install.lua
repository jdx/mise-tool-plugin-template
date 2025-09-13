-- hooks/pre_install.lua
-- Returns download information for a specific version
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#preinstall-hook

function PLUGIN:PreInstall(ctx)
    local version = ctx.version
    -- ctx.runtimeVersion contains the full version string if needed

    -- Example 1: Simple binary download
    -- local url = "https://github.com/<USER>/<TOOL>/releases/download/v" .. version .. "/<TOOL>-linux-amd64"

    -- Example 2: Platform-specific binary
    -- local platform = get_platform() -- You'll need to implement this
    -- local url = "https://github.com/<USER>/<TOOL>/releases/download/v" .. version .. "/<TOOL>-" .. platform

    -- Example 3: Archive (tar.gz, zip) - mise will extract automatically
    -- local url = "https://github.com/<USER>/<TOOL>/releases/download/v" .. version .. "/<TOOL>-" .. version .. "-linux-amd64.tar.gz"

    -- Example 4: Raw file from repository
    -- local url = "https://raw.githubusercontent.com/<USER>/<TOOL>/" .. version .. "/bin/<TOOL>"

    -- Replace with your actual download URL pattern
    local url = "https://example.com/<TOOL>/releases/download/" .. version .. "/<TOOL>"

    -- Optional: Fetch checksum for verification
    -- local sha256 = fetch_checksum(version) -- Implement if checksums are available

    return {
        version = version,
        url = url,
        -- sha256 = sha256, -- Optional but recommended for security
        note = "Downloading <TOOL> " .. version,
        -- addition = { -- Optional: download additional components
        --     {
        --         name = "component",
        --         url = "https://example.com/component.tar.gz"
        --     }
        -- }
    }
end

-- Helper function for platform detection (uncomment and modify as needed)
--[[
local function get_platform()
    local os_name = os.getenv("OS")
    if not os_name then
        local handle = io.popen("uname -s")
        os_name = handle:read("*a"):gsub("%s+", "")
        handle:close()
    end

    local arch = os.getenv("PROCESSOR_ARCHITECTURE")
    if not arch then
        local handle = io.popen("uname -m")
        arch = handle:read("*a"):gsub("%s+", "")
        handle:close()
    end

    -- Map to your tool's platform naming convention
    local platform_map = {
        ["Darwin"] = {
            ["x86_64"] = "darwin-amd64",
            ["arm64"] = "darwin-arm64",
        },
        ["Linux"] = {
            ["x86_64"] = "linux-amd64",
            ["aarch64"] = "linux-arm64",
        },
        ["Windows_NT"] = {
            ["AMD64"] = "windows-amd64",
        }
    }

    local os_map = platform_map[os_name] or platform_map["Linux"]
    return os_map[arch] or "linux-amd64"
end
--]]
