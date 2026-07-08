{
  description = ''
    Epping is a theme for the severless/static Astro blog framework inspired by the colour scheme of
    Transport for NSW.
  '';

  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = nixpkgs.legacyPackages.${system};
  in {
  });
}
