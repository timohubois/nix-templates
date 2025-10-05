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

### Quick Start with Templates

Use a pre-configured template:

```bash
nix flake new --template github:timohubois/nix-templates#php82 ./my-project
cd my-project && nix develop
```

### Custom Configuration with Library

Use the library for flexible configuration:

```nix
{
  inputs.templates.url = "github:timohubois/nix-templates";

  outputs = { templates, ... }:
    templates.lib.mkDevShells {
      nodejs = "20";        # Node.js 20
      php = "82";           # PHP 8.2 with Composer (included by default)
      # wp-cli = true;      # Optional: Include WP-CLI for WordPress
    };
}
```

## Examples

Complete working examples in [examples/](./examples/):

- **[Single Node.js](./examples/single-nodejs/)** - Node.js 20 with HTTP server
- **[Single PHP](./examples/single-php/)** - PHP 8.2 with Composer
- **[Combined](./examples/combined/)** - Node.js + PHP together
- **[PHP with WP-CLI](./examples/php-wpcli/)** - PHP 8.2 with Composer 2 and WP-CLI
- **[Custom](./examples/custom/)** - Extended with additional tools

## Library Functions

### `mkDevShells`

Main function for creating development environments:

```nix
templates.lib.mkDevShells {
  nodejs = null;        # "10" | "12" | "14" | "16" | "18" | "20" | "22"
  php = null;           # "74" | "80" | "81" | "82" | "83" | "84" (includes Composer by default)
  composer = null;      # null | "1" | "2" | false
  wp-cli = false;       # true | false
}
```

**Options:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `nodejs` | `string \| null` | `null` | Node.js version (includes npm) |
| `php` | `string \| null` | `null` | PHP version: `"82"` or `"8.2"` (major.minor only, patch version from nixpkgs) |
| `composer` | `string \| false \| null` | `null` | Override Composer version: `null` = use template default (2.8.x), `"1"` = Composer 1 from nixpkgs (1.10.22 for most platforms, 1.10.27 custom for aarch64-darwin), `"2"` = explicit override to 2.8.x, `false` = remove Composer |
| `wp-cli` | `boolean` | `false` | Include WP-CLI for WordPress development |

**Composer Behavior:**
- **PHP templates include Composer by default** - no need to specify
- Use `composer = "1"` to override with legacy Composer 1 (from nixpkgs where available, custom derivation for aarch64-darwin)
- Use `composer = "2"` to explicitly override with Composer 2
- Use `composer = false` to remove Composer from environment

### Other Functions

- `forEachSupportedSystem` - Multi-system helper
- `nodejsTemplates."X"` / `phpTemplates."X"` - Direct template access
