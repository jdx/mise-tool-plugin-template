--!strict
local Types = require("@lib/types")

local plugin = PLUGIN :: Types.PluginType

--- Configures environment variables for the installed tool
--- Documentation: https://mise.jdx.dev/dev-tools/backends/vfox.html
function plugin:EnvKeys(
    ctx: { path: string, runtimeVersion: string, sdkInfo: { [string]: Types.SdkInfo }? }
): { Types.EnvKeyResult }
    local mainPath: string = ctx.path
    -- local sdkInfo = ctx.sdkInfo[plugin.name]
    -- local version = sdkInfo.version

    -- Basic configuration (minimum required for most tools)
    -- This adds the bin directory to PATH so the tool can be executed
    return {
        {
            key = "PATH",
            value = `{mainPath}/bin`,
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
			value = `{mainPath}/bin`,
		},
		-- Multiple PATH entries are automatically merged
		{
			key = "PATH",
			value = `{mainPath}/scripts`,
		},
	}
	--]]

    -- Example: Library paths for compiled tools
    --[[
	return {
		{
			key = "PATH",
			value = `{mainPath}/bin`,
		},
		{
			key = "LD_LIBRARY_PATH",
			value = `{mainPath}/lib`,
		},
		{
			key = "PKG_CONFIG_PATH",
			value = `{mainPath}/lib/pkgconfig`,
		},
	}
	--]]

    -- Example: Platform-specific configuration
    --[[
	local runtime = RUNTIME :: Types.RuntimeType
	local env_vars: { Types.EnvKeyResult } = {
		{
			key = "PATH",
			value = `{mainPath}/bin`,
		},
	}

	if runtime.osType == "Darwin" then
		table.insert(env_vars, {
			key = "DYLD_LIBRARY_PATH",
			value = `{mainPath}/lib`,
		})
	elseif runtime.osType == "Linux" then
		table.insert(env_vars, {
			key = "LD_LIBRARY_PATH",
			value = `{mainPath}/lib`,
		})
	end

	return env_vars
	--]]
end
