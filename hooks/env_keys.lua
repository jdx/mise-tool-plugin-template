function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path
    return {
        { key = "PATH", value = mainPath .. "/bin" },
    }
end
