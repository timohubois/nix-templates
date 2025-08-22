# Nix Templates

Simple, focused Nix templates for Node.js and PHP development environments based on flakes.

> ⚠️ **Note:** This project uses [Nix flakes](https://nixos.wiki/wiki/Flakes), which are quite a while available and widely used but are still in the experimental stage.

## Available Templates

Each template uses the highest NixOS version where that specific software version was/is available. For example: Node.js 22 uses NixOS 25.05, while Node.js 10 uses NixOS 21.05 (when it was last available).

### PHP Versions

| PHP Version | EOL Date | NixOS |
|---------|----------|-------|
| [8.4](./php/php84) | Dec 2028 | 25.05 |
| [8.3](./php/php83) | Dec 2027 | 25.05 |
| [8.2](./php/php82) | Dec 2026 | 25.05 |
| [8.1](./php/php81) | Dec 2025 | 25.05 |
| [8.0](./php/php80) | Nov 2023 | 23.05 |
| [7.4](./php/php74) | Nov 2022 | 21.11 |

Read more about [PHP Supported Versions](https://www.php.net/supported-versions.php).

### Node.js Versions

| Node.js Version | EOL Date | NixOS |
|---------|----------|-------|
| [22](./nodejs/nodejs_22) | Apr 2027 | 25.05 |
| [20](./nodejs/nodejs_20) | Apr 2026 | 25.05 |
| [18](./nodejs/nodejs_18) | Apr 2025 | 24.11 |
| [16](./nodejs/nodejs_16) | Sep 2023 | 23.05 |
| [14](./nodejs/nodejs_14) | Apr 2023 | 22.05 |
| [12](./nodejs/nodejs_12) | Apr 2022 | 22.05 |
| [10](./nodejs/nodejs_10) | Apr 2021 | 21.05 |

Read more about [Node.js Releases](https://nodejs.org/en/about/previous-releases).

## Quick Start

### New Projects

```bash
# Create new project with template
nix flake new --template github:timohubois/nix-templates#php82 ./my-project
cd my-project && nix develop
```

### Existing Projects

```nix
{
  inputs.templates.url = "github:timohubois/nix-templates";

  outputs = { templates, ... }:
    templates.lib.mkDevShells {
      nodejs = "20";
      php = "82";
    };
}
```

## Examples

Complete working examples in [examples/](./examples/):

- **[Single Node.js](./examples/single-nodejs/)** - Node.js 20 with HTTP server
- **[Single PHP](./examples/single-php/)** - PHP 8.2 with Composer
- **[Combined](./examples/combined/)** - Node.js + PHP together
- **[Custom](./examples/custom/)** - Extended with additional tools

## Library Functions

- `mkDevShells { nodejs?, php? }` - Main function for creating environments
- `forEachSupportedSystem` - Multi-system helper
- `nodejsTemplates."X"` / `phpTemplates."X"` - Direct template access
