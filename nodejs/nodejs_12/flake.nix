{
  description = "Node.js 12 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
  };

  outputs = { self, nixpkgs }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = system: import nixpkgs {
      inherit system;
      config.permittedInsecurePackages = [ "nodejs-12.22.12" ];
    };
  in {
    packages = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.buildEnv {
          name = "node12-env";
          paths = [ pkgs.nodejs-12_x ];
        };
      }
    );

    devShells = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.mkShell {
          buildInputs = [ pkgs.nodejs-12_x ];
          shellHook = ''
            echo "Node.js 12 development environment"
            node --version
            npm --version
          '';
        };
      }
    );
  };
}