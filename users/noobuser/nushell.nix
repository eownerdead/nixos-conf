{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };

  home.file."zoxide.nu" = {
    source = pkgs.runCommand ".zoxide.nu" { } ''
      ${pkgs.zoxide}/bin/zoxide init --hook prompt nushell > $out
    '';
    target = ".config/nushell/.zoxide.nu";
  };
}
