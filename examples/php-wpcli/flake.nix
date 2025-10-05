{
  description = "PHP development environment with WP-CLI";

  inputs.templates.url = "github:timohubois/nix-templates";

  outputs = { templates, ... }:
    templates.lib.mkDevShells {
      php = "82";
      wp-cli = true;
    };
}
