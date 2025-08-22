{
  description = "Node.js 10 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  };

  outputs = { self, nixpkgs }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    # Force x86_64 on Apple Silicon for Node.js 10 compatibility because it's not supported on aarch64.
    pkgsFor = system:
      let
        targetSystem = if system == "aarch64-darwin" then "x86_64-darwin" else system;
      in import nixpkgs {
        system = targetSystem;
        config.permittedInsecurePackages = [ "nodejs-10.24.1" ];
      };
  in {
    packages = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.buildEnv {
          name = "node10-env";
          paths = [ pkgs.nodejs-10_x ];
        };
      }
    );

    devShells = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.mkShell {
          buildInputs = [ pkgs.nodejs-10_x ];
          shellHook = ''
            echo "Node.js 10 development environment"
            node --version
            npm --version
          '';
        };
      }
    );
  };
}
