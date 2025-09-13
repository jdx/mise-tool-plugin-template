-- hooks/post_install.lua
-- Performs additional setup after installation
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#postinstall-hook

function PLUGIN:PostInstall(ctx)
    -- Available context:
    -- ctx.rootPath - Root installation path
    -- ctx.runtimeVersion - Full version string
    -- ctx.sdkInfo[PLUGIN.name] - SDK information

    local sdkInfo = ctx.sdkInfo[PLUGIN.name]
    local path = sdkInfo.path
    -- local version = sdkInfo.version

    -- Example 1: Single binary file (most common)
    -- The file is downloaded directly, move it to bin/ and make executable
    os.execute("mkdir -p " .. path .. "/bin")

    local srcFile = path .. "/" .. PLUGIN.name
    local destFile = path .. "/bin/" .. PLUGIN.name

    -- Move and make executable
    local result = os.execute("mv " .. srcFile .. " " .. destFile .. " && chmod +x " .. destFile)
    if result ~= 0 then
        error("Failed to install " .. PLUGIN.name .. " binary")
    end

    -- Verify installation works
    local testResult = os.execute(destFile .. " --version > /dev/null 2>&1")
    if testResult ~= 0 then
        error(PLUGIN.name .. " installation appears to be broken")
    end

    -- Example 2: Archive already extracted by mise
    -- If pre_install returns a .tar.gz or .zip, mise extracts it automatically
    -- You might just need to move files around:
    --[[
    os.execute("mkdir -p " .. path .. "/bin")
    os.execute("mv " .. path .. "/<TOOL>-*/bin/* " .. path .. "/bin/")
    os.execute("chmod +x " .. path .. "/bin/*")
    --]]

    -- Example 3: Multiple binaries
    --[[
    os.execute("mkdir -p " .. path .. "/bin")
    local binaries = {"tool1", "tool2", "tool3"}
    for _, binary in ipairs(binaries) do
        os.execute("mv " .. path .. "/" .. binary .. " " .. path .. "/bin/")
        os.execute("chmod +x " .. path .. "/bin/" .. binary)
    end
    --]]

    -- Example 4: No action needed
    -- If the archive already has the correct structure (bin/ directory),
    -- you might not need to do anything:
    --[[
    -- Archive already contains bin/<TOOL>, just verify it works
    local testResult = os.execute(path .. "/bin/<TOOL> --version > /dev/null 2>&1")
    if testResult ~= 0 then
        error("<TOOL> installation appears to be broken")
    end
    --]]

    -- Example 5: Platform-specific setup
    --[[
    -- RUNTIME object is provided by mise/vfox
    if RUNTIME.osType ~= "Windows" then
        -- Unix-like systems: make binaries executable
        os.execute("chmod +x " .. path .. "/bin/*")
    else
        -- Windows-specific setup if needed
        -- e.g., adding .exe extension or handling batch files
    end
    --]]
end
