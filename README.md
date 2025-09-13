# mise tool plugin template

This is a GitHub template for building a mise tool plugin.

Clone or use this template, then replace placeholders like `<TOOL>` and repo URLs.

## Files

- `metadata.lua` – plugin metadata
- `hooks/available.lua` – returns available versions
- `hooks/pre_install.lua` – returns artifact URL for a given version
- `hooks/post_install.lua` – moves artifact to `bin/` and verifies
- `hooks/env_keys.lua` – environment variables to export (e.g., `PATH`)
- `.github/workflows/ci.yml` – lint and test jobs using `mise`
- `mise.toml`, `mise-tasks/*` – tools and tasks for development

## Getting started

1. Update `metadata.lua` fields (`name`, `updateUrl`, etc.)
2. Point `hooks/available.lua` and `hooks/pre_install.lua` at your release source
3. Run CI locally:

```bash
mise run ci
```

## Documentation

Refer to the mise docs for plugin development and usage:

- [Tool plugin development](https://mise.jdx.dev/tool-plugin-development.html)
- [Backend plugin development](https://mise.jdx.dev/backend-plugin-development.html)
- [Plugin publishing](https://mise.jdx.dev/plugin-publishing.html)
- [Plugin usage](https://mise.jdx.dev/plugin-usage.html)
- [CLI reference](https://mise.jdx.dev/cli/index.html)

## License

MIT
