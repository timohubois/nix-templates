{
  description = "Node.js 16 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = system: import nixpkgs {
      inherit system;
      config.permittedInsecurePackages = [ "nodejs-16.20.2" ];
    };
  in {
    packages = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.buildEnv {
          name = "node16-env";
          paths = [ pkgs.nodejs-16_x ];
        };
      }
    );

    devShells = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.mkShell {
          buildInputs = [ pkgs.nodejs-16_x ];
          shellHook = ''
            echo "Node.js 16 development environment"
            node --version
            npm --version
          '';
        };
      }
    );
  };
}