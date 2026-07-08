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

    core = with pkgs; [
      nodejs
      typescript
    ];
    lsps = with pkgs; {
      tl_ls = typescript-language-server;
      astro = astro-language-server;
      tailwindcss = tailwindcss-language-server;
      nil = nil;
    };
  in {
    devShells.core = pkgs.mkShellNoCC {
      packages = core;
    };
    devShells.nvim = pkgs.mkShellNoCC {
      packages = builtins.attrValues lsps;

      shellHook = ''
        alias nvim="${pkgs.callPackage ./nix/nvim-conf/package.nix {}}"
      '';
    };
  });
}
