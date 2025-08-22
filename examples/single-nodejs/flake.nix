{
  description = "Node.js 20 development environment";

  inputs.templates.url = "github:timohubois/nix-templates";

  outputs = { templates, ... }:
    templates.lib.mkDevShells { nodejs = "20"; };
}
