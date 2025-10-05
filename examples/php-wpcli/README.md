# PHP Development Environment with WP-CLI

PHP 8.2 development environment with Composer and WP-CLI tooling for WordPress development and management.

## What's Included

- **PHP 8.2** - Modern PHP version
- **Composer** - Dependency management (included with PHP by default)
- **WP-CLI 2.12.0** - Command-line interface for WordPress

## Quick Start

```bash
# Enter development environment
nix develop

# Verify WP-CLI is available
wp --version

# Example: Download and set up WordPress
wp core download
wp config create --dbname=wordpress --dbuser=root --dbpass=root --dbhost=localhost
wp core install --url=http://localhost:8080 --title="My Site" --admin_user=admin --admin_password=admin --admin_email=admin@example.com

# Start PHP development server
php -S localhost:8080
```

## Common WP-CLI Commands

```bash
# Check version
wp --version

# List installed plugins
wp plugin list

# Install and activate a plugin
wp plugin install akismet --activate

# Update all plugins
wp plugin update --all

# Create a new post
wp post create --post_type=post --post_title='Hello World' --post_status=publish

# Search and replace in database
wp search-replace 'http://oldurl.com' 'http://newurl.com'

# Export database
wp db export backup.sql

# Import database
wp db import backup.sql
```

## Configuration Options

You can customize the environment by modifying `flake.nix`:

```nix
templates.lib.mkDevShells {
  php = "82";           # PHP 8.2 (includes Composer by default)
  wp-cli = true;        # Include WP-CLI
}
```

### Use Different PHP Version

```nix
templates.lib.mkDevShells {
  php = "83";           # Use PHP 8.3 instead (includes Composer)
  wp-cli = true;
}
```

### Use Legacy Composer 1

```nix
templates.lib.mkDevShells {
  php = "82";
  composer = "1";       # Override to use Composer 1.10.22
  wp-cli = true;
}
```

### Add Node.js (for frontend development)

```nix
templates.lib.mkDevShells {
  nodejs = "20";        # Add Node.js 20 with npm
  php = "82";
  wp-cli = true;
}
```

## Learn More

- [WP-CLI Documentation](https://wp-cli.org/)
- [WP-CLI Commands](https://developer.wordpress.org/cli/commands/)
- [WordPress Developer Resources](https://developer.wordpress.org/)
