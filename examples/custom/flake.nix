{
  description = "Custom development environment with additional tools";

  inputs = {
    templates.url = "github:timohubois/nix-templates";
    nixpkgs.url = "nixpkgs";
  };

  outputs = { templates, nixpkgs, ... }: {
    devShells = templates.lib.forEachSupportedSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Get the base Node.js 18 environment
        nodeTemplate = templates.lib.nodejsTemplates."18";
        baseShell = nodeTemplate.devShells.${system}.default;

        # Add custom packages
        customPackages = with pkgs; [
          git
          curl
          jq
          docker-compose
          postgresql
        ];
      in {
        default = baseShell.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ customPackages;

          shellHook = old.shellHook + ''
            echo "🛠️  Custom development environment"
            echo "📦 Additional tools: git, curl, jq, docker-compose, postgresql"
            echo "🗃️  Database: $(postgres --version 2>/dev/null || echo 'PostgreSQL available')"
          '';
        });
      }
    );
  };
}
