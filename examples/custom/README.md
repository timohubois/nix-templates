# Custom Environment Example

Shows how to extend nix-templates to create custom development environments with additional tools.

## What's included

**Base environment:**

- Node.js 18 LTS with npm (from templates)

**Additional tools:**

- Git version control
- curl for HTTP requests
- jq for JSON processing
- docker-compose for container orchestration
- PostgreSQL database

## Usage

```bash
# Enter the development environment
nix develop

# All tools are now available
node --version
git --version
curl --version
jq --version
docker-compose --version
postgres --version
```

## Customization

Shows how to:

1. **Extend existing templates** - Start with Node.js 18 as the base
2. **Add custom packages** - Include additional development tools
3. **Customize shell hooks** - Add custom startup messages
4. **Use forEachSupportedSystem** - For advanced multi-system support

## Key patterns

- `templates.lib.nodejsTemplates."18"` - Direct template access
- `baseShell.overrideAttrs` - Extend existing shell environments
- `old.buildInputs ++ customPackages` - Add packages to existing ones
- `old.shellHook + ''...''` - Extend existing shell hooks

This approach gives maximum flexibility while still leveraging the optimized template configurations.
