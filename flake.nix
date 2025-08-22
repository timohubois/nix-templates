{
  description = "Simple Nix templates for Node.js and PHP development";

  # Reference template outputs directly - single source of truth!
  inputs = {
    # Node.js templates as inputs
    nodejs-10-template.url = "./nodejs/nodejs_10";
    nodejs-12-template.url = "./nodejs/nodejs_12";
    nodejs-14-template.url = "./nodejs/nodejs_14";
    nodejs-16-template.url = "./nodejs/nodejs_16";
    nodejs-18-template.url = "./nodejs/nodejs_18";
    nodejs-20-template.url = "./nodejs/nodejs_20";
    nodejs-22-template.url = "./nodejs/nodejs_22";

    # PHP templates as inputs
    php74-template.url = "./php/php74";
    php80-template.url = "./php/php80";
    php81-template.url = "./php/php81";
    php82-template.url = "./php/php82";
    php83-template.url = "./php/php83";
    php84-template.url = "./php/php84";
  };

  outputs = { self, ... }@inputs:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
  in {
    templates = {
      # PHP Templates
      php74 = {
        path = ./php/php74;
        description = "PHP 7.4 development environment";
      };
      php80 = {
        path = ./php/php80;
        description = "PHP 8.0 development environment";
      };
      php81 = {
        path = ./php/php81;
        description = "PHP 8.1 development environment";
      };
      php82 = {
        path = ./php/php82;
        description = "PHP 8.2 development environment";
      };
      php83 = {
        path = ./php/php83;
        description = "PHP 8.3 development environment";
      };
      php84 = {
        path = ./php/php84;
        description = "PHP 8.4 development environment";
      };

      # Node.js Templates
      nodejs_10 = {
        path = ./nodejs/nodejs_10;
        description = "Node.js 10 development environment";
      };
      nodejs_12 = {
        path = ./nodejs/nodejs_12;
        description = "Node.js 12 development environment";
      };
      nodejs_14 = {
        path = ./nodejs/nodejs_14;
        description = "Node.js 14 development environment";
      };
      nodejs_16 = {
        path = ./nodejs/nodejs_16;
        description = "Node.js 16 development environment";
      };
      nodejs_18 = {
        path = ./nodejs/nodejs_18;
        description = "Node.js 18 development environment";
      };
      nodejs_20 = {
        path = ./nodejs/nodejs_20;
        description = "Node.js 20 development environment";
      };
      nodejs_22 = {
        path = ./nodejs/nodejs_22;
        description = "Node.js 22 LTS development environment";
      };
    };

    # Reusable library functions using template nixpkgs directly
    lib = {
      # Standard systems support
      supportedSystems = systems;
      forEachSupportedSystem = f: builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);

      # Template lookup tables - single source of truth
      nodejsTemplates = {
        "10" = inputs.nodejs-10-template;
        "12" = inputs.nodejs-12-template;
        "14" = inputs.nodejs-14-template;
        "16" = inputs.nodejs-16-template;
        "18" = inputs.nodejs-18-template;
        "20" = inputs.nodejs-20-template;
        "22" = inputs.nodejs-22-template;
      };

      phpTemplates = {
        "74" = inputs.php74-template;
        "80" = inputs.php80-template;
        "81" = inputs.php81-template;
        "82" = inputs.php82-template;
        "83" = inputs.php83-template;
        "84" = inputs.php84-template;
      };

      # Main function - creates devShells for all systems automatically
      # Supports: nodejs only, php only, or both combined
      mkDevShells = { nodejs ? null, php ? null }: {
        devShells = self.lib.forEachSupportedSystem (system:
          let
            # Get template packages by referencing their devShells
            getNodePackages = version:
              let template = self.lib.nodejsTemplates.${version} or (throw "Unsupported Node.js version: ${version}");
              in template.devShells.${system}.default.buildInputs;

            getPhpPackages = version:
              let template = self.lib.phpTemplates.${version} or (throw "Unsupported PHP version: ${version}");
              in template.devShells.${system}.default.buildInputs;

            nodePackages = if nodejs != null then getNodePackages nodejs else [];
            phpPackages = if php != null then getPhpPackages php else [];

            # Use primary environment for base shell (nodejs takes precedence)
            baseTemplate = if nodejs != null then
              self.lib.nodejsTemplates.${nodejs} or (throw "Unsupported Node.js version: ${nodejs}")
            else if php != null then
              self.lib.phpTemplates.${php} or (throw "Unsupported PHP version: ${php}")
            else throw "Must specify either nodejs or php version";

            baseShell = baseTemplate.devShells.${system}.default;
            allPackages = nodePackages ++ phpPackages;
          in {
            default = baseShell.overrideAttrs (old: {
              buildInputs = allPackages;
              shellHook = ''
                ${if nodejs != null then ''echo "Node: $(node --version)"'' else ""}
                ${if php != null then ''echo "PHP: $(php --version)"'' else ""}
              '';
            });
          }
        );
      };
    };
  };
}
