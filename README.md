# mise tool plugin template

This is a GitHub template for building a mise tool plugin using the vfox-style Lua hooks architecture.

## Using this template

### Option 1: Use GitHub's template feature (recommended)
1. Click "Use this template" button on GitHub
2. Name your repository (e.g., `mise-mytool`)
3. Clone your new repository
4. Follow the setup instructions below

### Option 2: Clone and modify
```bash
git clone https://github.com/jdx/mise-tool-plugin-template mise-mytool
cd mise-mytool
rm -rf .git
git init
```

## Setup Instructions

### 1. Replace placeholders

Search and replace these placeholders throughout the project:
- `<TOOL>` → your tool name (e.g., `semver`)
- `<GITHUB_USER>` → your GitHub username or organization
- `<GITHUB_REPO>` → the upstream tool's GitHub repository name

Files to update:
- `metadata.lua` - Update name, description, author, updateUrl
- `hooks/*.lua` - Replace placeholders in all hook files
- `mise-tasks/test` - Update test version and command
- `README.md` - Update this file with your tool's information

### 2. Implement the hooks

#### `hooks/available.lua`
Returns a list of available versions. Examples:

```lua
-- Example 1: GitHub releases API
local repo_url = "https://api.github.com/repos/owner/repo/releases"

-- Example 2: GitHub tags API
local repo_url = "https://api.github.com/repos/owner/repo/tags"

-- Example 3: Custom version listing
-- Parse from a website, API, or other source
```

#### `hooks/pre_install.lua`
Returns download information for a specific version:

```lua
-- Example 1: Simple binary download
local url = "https://github.com/owner/repo/releases/download/v" .. version .. "/tool-linux-amd64"

-- Example 2: Archive download
local url = "https://github.com/owner/repo/releases/download/v" .. version .. "/tool-" .. version .. "-" .. platform .. ".tar.gz"

-- Example 3: Raw file from repository
local url = "https://raw.githubusercontent.com/owner/repo/" .. version .. "/bin/tool"
```

#### `hooks/post_install.lua`
Handles post-installation setup:

```lua
-- Example 1: Single binary (chmod and move to bin/)
os.execute("mkdir -p " .. path .. "/bin")
os.execute("mv " .. path .. "/tool " .. path .. "/bin/tool")
os.execute("chmod +x " .. path .. "/bin/tool")

-- Example 2: Extract from archive (handled automatically by mise)
-- Usually no action needed if pre_install returns an archive

-- Example 3: Multiple binaries
-- Move all executables to bin/ directory
```

### 3. Configure environment variables

Update `hooks/env_keys.lua` if your tool needs special environment variables:

```lua
-- Basic PATH setup (minimum required)
return {
    {
        key = "PATH",
        value = mainPath .. "/bin"
    }
}

-- Advanced example with tool-specific vars
return {
    {
        key = "TOOL_HOME",
        value = mainPath
    },
    {
        key = "PATH",
        value = mainPath .. "/bin"
    },
    {
        key = "LD_LIBRARY_PATH",
        value = mainPath .. "/lib"
    }
}
```

## Development Workflow

### Setting up development environment

1. Install pre-commit hooks (optional but recommended):
```bash
hk install
```

This sets up automatic linting and formatting on git commits.

### Local Testing

1. Link your plugin for development:
```bash
mise plugin link --force <TOOL> .
```

2. Run tests:
```bash
mise run test
```

3. Run linting:
```bash
mise run lint
```

4. Run full CI suite:
```bash
mise run ci
```

### Code Quality

This template uses [hk](https://hk.jdx.dev) for modern linting and pre-commit hooks:

- **Automatic formatting**: `stylua` formats Lua code
- **Static analysis**: `luacheck` catches Lua issues
- **GitHub Actions linting**: `actionlint` validates workflows
- **Pre-commit hooks**: Runs all checks automatically on git commit

Manual commands:
```bash
hk check      # Run all linters (same as mise run lint)
hk fix        # Run linters and auto-fix issues
```

### Debugging

Enable debug output:
```bash
MISE_DEBUG=1 mise install <TOOL>@latest
```

## Files

- `metadata.lua` – Plugin metadata and configuration
- `hooks/available.lua` – Returns available versions from upstream
- `hooks/pre_install.lua` – Returns artifact URL for a given version
- `hooks/post_install.lua` – Post-installation setup (permissions, moving files)
- `hooks/env_keys.lua` – Environment variables to export (PATH, etc.)
- `.github/workflows/ci.yml` – GitHub Actions CI/CD pipeline
- `mise.toml` – Development tools and configuration
- `mise-tasks/` – Task scripts for testing
- `hk.pkl` – Modern linting and pre-commit hook configuration
- `.luacheckrc` – Lua linting configuration
- `stylua.toml` – Lua formatting configuration

## Common Patterns

### Platform Detection
```lua
local function get_platform()
    -- RUNTIME object is provided by mise/vfox
    -- RUNTIME.osType: "Windows", "Linux", "Darwin"
    -- RUNTIME.archType: "amd64", "386", "arm64", etc.

    local os_name = RUNTIME.osType:lower()
    local arch = RUNTIME.archType

    -- Map to your tool's platform naming convention
    local platform_map = {
        ["darwin"] = {
            ["amd64"] = "darwin-amd64",
            ["arm64"] = "darwin-arm64",
        },
        ["linux"] = {
            ["amd64"] = "linux-amd64",
            ["arm64"] = "linux-arm64",
        },
        ["windows"] = {
            ["amd64"] = "windows-amd64",
            ["386"] = "windows-386",
        }
    }

    local os_map = platform_map[os_name]
    if os_map then
        return os_map[arch] or "linux-amd64"
    end
    return "linux-amd64"  -- fallback
end
```

### Checksum Verification
```lua
-- In pre_install.lua, return sha256
return {
    version = version,
    url = url,
    sha256 = "abc123...",  -- Optional but recommended
}
```

### Error Handling
```lua
if err ~= nil then
    error("Failed to fetch versions: " .. err)
end

if resp.status_code ~= 200 then
    error("API returned status " .. resp.status_code)
end
```

## Documentation

Refer to the mise docs for detailed information:

- [Tool plugin development](https://mise.jdx.dev/tool-plugin-development.html) - Complete guide to plugin development
- [Lua modules reference](https://mise.jdx.dev/plugin-lua-modules.html) - Available Lua modules and functions
- [Plugin publishing](https://mise.jdx.dev/plugin-publishing.html) - How to publish your plugin
- [mise-plugins organization](https://github.com/mise-plugins) - Community plugins repository

## Publishing

1. Ensure all tests pass: `mise run ci`
2. Create a GitHub repository for your plugin
3. Push your code
4. (Optional) Request to transfer to [mise-plugins](https://github.com/mise-plugins) organization
5. Add to the [mise registry](https://github.com/jdx/mise/blob/main/registry.toml) via PR

## License

MIT