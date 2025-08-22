# Combined Node.js + PHP Environment Example

Shows how to create a development environment with both Node.js and PHP using nix-templates.

## Usage

```bash
# Enter the development environment
nix develop

# Run the Node.js API server
npm start

# In another terminal, run the PHP client
php api-client.php
```

## What's included

- Node.js 20 LTS with npm
- PHP 8.2 with Composer
- Both environments in a single shell
- Simple HTTP API server using Node.js built-ins (`server.js`)
- PHP client script that consumes the API using built-ins (`api-client.php`)
- Cross-platform support (Linux x86_64/ARM64, macOS Intel/Apple Silicon)
- Zero external dependencies - uses only built-in functionality
- Shell hook displays both Node.js and PHP versions on entry
