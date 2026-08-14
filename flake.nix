{
  description = ''
    Epping is a theme for the severless/static Astro blog framework inspired by the colour scheme of
    Transport for NSW.
  '';

  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixche.url = "github:ezjfc/nixche";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    nixche,
  }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = nixpkgs.legacyPackages.${system};
    nixchePkgs = nixche.packages.${system};
    inherit (nixchePkgs.write-alias-script) writeAliasScriptBin;
    inherit (nixchePkgs.write-lua-script) writeLuaScriptShare;

    core = with pkgs; [
      nodejs
      typescript
    ];
    lsps = with pkgs; {
      ts_ls = typescript-language-server;
      astro = astro-language-server;
      tailwindcss = tailwindcss-language-server;
      nil = nil;
    };
    launchScriptPkg = writeLuaScriptShare {
      name = "neovim-launch-script";
      inherit lsps;
      text = builtins.readFile ./neovim/lsps.lua;
      TYPESCRIPT = pkgs.typescript;
    };
    launchScript = "${launchScriptPkg}/share/${launchScriptPkg.name}.lua";
  in {
    devShells.core = pkgs.mkShellNoCC {
      packages = core;
    };
    devShells.nvim = pkgs.mkShellNoCC {
      packages = core ++ (builtins.attrValues lsps) ++ [
        launchScriptPkg
        (writeAliasScriptBin "nvim" "nvim -c 'source ${launchScript}'")
      ];
    };
  });
}
