{
  description = "PHP 8.0 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = system: import nixpkgs {
      inherit system;
      config.permittedInsecurePackages = [ "openssl-1.1.1w" ];
    };
  in {
    packages = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.buildEnv {
          name = "php80-env";
          paths = [ pkgs.php80 pkgs.php80Packages.composer ];
        };
      }
    );

    devShells = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.mkShell {
          buildInputs = [ pkgs.php80 pkgs.php80Packages.composer ];
          shellHook = ''
            echo "PHP 8.0 development environment"
            php --version
            composer --version
          '';
        };
      }
    );
  };
}