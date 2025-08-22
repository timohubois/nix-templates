# Single Node.js Environment Example

Shows how to create a simple Node.js development environment with nix-templates.

## Usage

```bash
# Enter the development environment
nix develop

# Run the example server
npm start

# Visit http://localhost:3000 to see the JSON response
```

## What's included

- Node.js 20 LTS with npm
- Simple HTTP server using built-in `http` module
- JSON API demonstrating Node.js capabilities
- Cross-platform support (Linux x86_64/ARM64, macOS Intel/Apple Silicon)
- Zero external dependencies - uses only Node.js built-ins
- Shell hook displays Node.js version on entry
