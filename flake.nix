# Sources:
# - https://github.com/NixOS/templates/blob/master/go-hello/flake.nix
# - https://templ.guide/quick-start/installation#nix
{
  description = "An example Go application that uses Nix to manage Templ";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Not required but provides a convienent helper for recursive systems
    utils.url = "github:numtide/flake-utils";
    # Include the Templ overlay
    templ.url = "github:a-h/templ";
  };

  outputs = { self, nixpkgs, utils, templ }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        # Bind the overlay
        templOverlay = system: templ.packages.${system}.templ;
      in
      {
        packages = {
          templ-app = pkgs.buildGoModule {
            pname = "templ-app";
            version = "0.1.0";
            src = ./.;
            vendorHash = "sha256-oAM/jDjEIfVZZYAbJLqRAT6jWtolpjZ4/oIXSXJkLVY=";
            meta = {
              description = "An example Nix + Go + Templ project";
              homepage = "https://github.com/Jonesy";
              license = pkgs.lib.licenses.unlicense;
              maintainers = with pkgs.lib.maintainers; [ jonesy ];
            };
          };
          # Prebuild all templates before compiling
          preBuild = ''
            ${templOverlay system}/bin/templ generate
          '';
        };
        devShell = with pkgs; mkShell {
          buildInputs = [
            go
            gopls
            gotools
            go-tools
            # Include the overlay as a build input
            (templOverlay system)
          ];
        };
        defaultPackage = self.packages.${system}.templ-app;
      });
}

