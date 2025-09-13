-- .luacheckrc configuration for mise tool plugins

std = "lua51"

-- Globals defined by the mise/vfox plugin system
globals = {
    "PLUGIN",
}

-- Read-only globals from the plugin environment
read_globals = {
    -- vfox modules
    "require",
    "http",
    "json",

    -- Standard Lua globals
    "os",
    "io",
    "table",
    "string",
    "math",
    "error",
    "ipairs",
    "pairs",
    "print",
    "tostring",
    "tonumber",
    "type",
}

ignore = {
    "631", -- line is too long
    "212", -- unused argument (self and ctx are often unused in simple hooks)
}

-- Allow trailing whitespace (can be auto-fixed)
allow_defined_top = true

-- Don't warn about unused self and ctx in hook functions
-- These are part of the plugin API signature
unused_args = false