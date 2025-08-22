{
  description = "PHP 7.4 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
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
          name = "php74-env";
          paths = [ pkgs.php74 pkgs.php74Packages.composer ];
        };
      }
    );

    devShells = forAllSystems (system:
      let pkgs = pkgsFor system; in {
        default = pkgs.mkShell {
          buildInputs = [ pkgs.php74 pkgs.php74Packages.composer ];
          shellHook = ''
            echo "PHP 7.4 development environment"
            php --version
            composer --version
          '';
        };
      }
    );
  };
}