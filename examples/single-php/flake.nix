{
  description = "PHP 8.2 development environment";

  inputs.templates.url = "github:timohubois/nix-templates";

  outputs = { templates, ... }:
    templates.lib.mkDevShells { php = "82"; };
}
