{
  description = "PHP 8.2 development environment";

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
          name = "php82-env";
          paths = [ pkgs.php82 ];
        };
      }
    );

    devShells = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.mkShell {
          buildInputs = [ 
            pkgs.php82
            pkgs.php82Packages.composer
          ];
          shellHook = ''
            echo "PHP 8.2 development environment"
            php --version
            composer --version
          '';
        };
      }
    );
  };
}