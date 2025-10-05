{
  description = "PHP 8.3 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = system: import nixpkgs { inherit system; };
  in {
    packages = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.buildEnv {
          name = "php83-env";
          paths = [ pkgs.php83 ];
        };
      }
    );

    devShells = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.mkShell {
          buildInputs = [ 
            pkgs.php83
            pkgs.php83Packages.composer
          ];
          shellHook = ''
            echo "PHP 8.3 development environment"
            php --version
            composer --version
          '';
        };
      }
    );
  };
}