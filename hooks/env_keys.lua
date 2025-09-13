-- hooks/env_keys.lua
-- Configures environment variables for the installed tool
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#envkeys-hook

function PLUGIN:EnvKeys(ctx)
    -- Available context:
    -- ctx.path - Main installation path
    -- ctx.runtimeVersion - Full version string
    -- ctx.sdkInfo[PLUGIN.name] - SDK information

    local mainPath = ctx.path
    -- local sdkInfo = ctx.sdkInfo[PLUGIN.name]
    -- local version = sdkInfo.version

    -- Basic configuration (minimum required for most tools)
    -- This adds the bin directory to PATH so the tool can be executed
    return {
        {
            key = "PATH",
            value = mainPath .. "/bin",
        },
    }

    -- Example: Tool-specific environment variables
    --[[
    return {
        {
            key = "<TOOL>_HOME",
            value = mainPath,
        },
        {
            key = "PATH",
            value = mainPath .. "/bin",
        },
        -- Multiple PATH entries are automatically merged
        {
            key = "PATH",
            value = mainPath .. "/scripts",
        },
    }
    --]]

    -- Example: Library paths for compiled tools
    --[[
    return {
        {
            key = "PATH",
            value = mainPath .. "/bin",
        },
        {
            key = "LD_LIBRARY_PATH",
            value = mainPath .. "/lib",
        },
        {
            key = "PKG_CONFIG_PATH",
            value = mainPath .. "/lib/pkgconfig",
        },
    }
    --]]

    -- Example: Platform-specific configuration
    --[[
    local env_vars = {
        {
            key = "PATH",
            value = mainPath .. "/bin",
        },
    }

    -- RUNTIME object is provided by mise/vfox
    if RUNTIME.osType == "Darwin" then
        table.insert(env_vars, {
            key = "DYLD_LIBRARY_PATH",
            value = mainPath .. "/lib",
        })
    elseif RUNTIME.osType == "Linux" then
        table.insert(env_vars, {
            key = "LD_LIBRARY_PATH",
            value = mainPath .. "/lib",
        })
    end
    -- Windows doesn't use these library path variables

    return env_vars
    --]]
end
