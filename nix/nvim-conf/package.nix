# A Nvim alias to automatically configure LSPs when launching the editor.

{
  writeShellScript,
  writeText,

  astro-language-server,
  typescript,
}: let
  configureScript = writeText "lsps.lua" (builtins.readFile ./lsps.lua);
  scriptArgs = "'${astro-language-server}', '${typescript}'";
in writeShellScript "nvim-conf.sh" ''
  nvim -c "lua loadfile('${configureScript}')(${scriptArgs})" $@
''
