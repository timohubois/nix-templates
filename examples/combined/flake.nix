{
  description = "Combined Node.js 20 and PHP 8.2 development environment";

  inputs.templates.url = "github:timohubois/nix-templates";

  outputs = { templates, ... }:
    templates.lib.mkDevShells {
      nodejs = "20";
      php = "82";
    };
}
