--!strict
local Types = require("@lib/types")

local plugin = PLUGIN :: Types.PluginType
local cmd = require("cmd") :: Types.CmdModule

--- Performs additional setup after installation
--- Documentation: https://mise.jdx.dev/dev-tools/backends/vfox.html
function plugin:PostInstall(ctx: { rootPath: string, runtimeVersion: string, sdkInfo: { [string]: Types.SdkInfo } })
	local sdkInfo = ctx.sdkInfo[plugin.name]
	local path: string = sdkInfo.path
	-- local version = sdkInfo.version

	-- Example 1: Single binary file (most common)
	-- The file is downloaded directly, move it to bin/ and make executable
	cmd.exec(`mkdir -p {path}/bin`)

	local srcFile = `{path}/{plugin.name}`
	local destFile = `{path}/bin/{plugin.name}`

	-- Move and make executable
	cmd.exec(`mv {srcFile} {destFile} && chmod +x {destFile}`)

	-- Verify installation works
	local ok, err = pcall(function()
		cmd.exec(`{destFile} --version`)
	end)
	if not ok then
		error(`{plugin.name} installation appears to be broken: {err}`)
	end

	-- Example 2: Archive already extracted by mise
	-- If pre_install returns a .tar.gz or .zip, mise extracts it automatically
	-- You might just need to move files around:
	--[[
	cmd.exec(`mkdir -p {path}/bin`)
	cmd.exec(`mv {path}/<TOOL>-*/bin/* {path}/bin/`)
	cmd.exec(`chmod +x {path}/bin/*`)
	--]]

	-- Example 3: Multiple binaries
	--[[
	cmd.exec(`mkdir -p {path}/bin`)
	local binaries = {"tool1", "tool2", "tool3"}
	for _, binary in binaries do
		cmd.exec(`mv {path}/{binary} {path}/bin/`)
		cmd.exec(`chmod +x {path}/bin/{binary}`)
	end
	--]]

	-- Example 4: No action needed
	-- If the archive already has the correct structure (bin/ directory),
	-- you might not need to do anything:
	--[[
	local ok, err = pcall(function()
		cmd.exec(`{path}/bin/<TOOL> --version`)
	end)
	if not ok then
		error("<TOOL> installation appears to be broken")
	end
	--]]

	-- Example 5: Platform-specific setup
	--[[
	local runtime = RUNTIME :: Types.RuntimeType
	if runtime.osType ~= "Windows" then
		cmd.exec(`chmod +x {path}/bin/*`)
	end
	--]]
end
